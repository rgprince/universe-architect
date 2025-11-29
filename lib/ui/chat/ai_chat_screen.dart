import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../../data/providers/database_provider.dart';
import '../universes/universes_screen.dart';
import '../../services/preferences_service.dart';
import '../settings/settings_screen.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _prefs = PreferencesService();
  final List<ChatMessage> _messages = [];
  final _currentUser = ChatUser(id: '1', firstName: 'You');
  final _geminiUser = ChatUser(id: '2', firstName: 'AI Co-Author');
  
  String? _apiKey;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }
  
  Future<void> _loadApiKey() async {
    final key = await _prefs.getApiKey();
    setState(() {
      _apiKey = key;
      _isLoading = false;
    });
    
    if (key != null && key.isNotEmpty) {
      Gemini.init(apiKey: key);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (_apiKey == null || _apiKey!.isEmpty) {
      return _buildNoApiKeyScreen();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Co-Author'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DashChat(
        currentUser: _currentUser,
        messages: _messages,
        onSend: _onSend,
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
            hintText: 'Ask about your story world...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        messageOptions: MessageOptions(
          currentUserContainerColor: Theme.of(context).colorScheme.primary,
          containerColor: Colors.grey[200] ?? Colors.grey.shade200,
        ),
      ),
    );
  }
  
  Widget _buildNoApiKeyScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Co-Author'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.key_off, size: 100, color: Colors.grey.shade300),
              const SizedBox(height: 24),
              Text(
                'API Key Required',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const Text(
                'To use the AI Co-Author, you need to add your Gemini API key in Settings.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                  // Reload API key when returning from settings
                  await _loadApiKey();
                },
                icon: const Icon(Icons.settings),
                label: const Text('Go to Settings'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: Open browser to makersuite.google.com
                },
                child: const Text('Get free API key →'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _extractEntityNames(String text) {
    final regex = RegExp(r'\b[A-Z][a-z]+\b');
    return regex.allMatches(text).map((m) => m.group(0)!).toSet().toList();
  }

  Future<void> _onSend(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
    });

    // RAG Pipeline Step 1: Extract entity mentions
    final entityNames = _extractEntityNames(message.text);
    
    // RAG Pipeline Step 2: Fetch entity context from database
    final db = ref.read(databaseProvider);
    String contextStr = '';
    
    final activeUniverseId = ref.read(activeUniverseProvider);
    if (entityNames.isNotEmpty && activeUniverseId != null) {
      try {
        final entities = await db.fetchEntitiesByNames(activeUniverseId, entityNames);
        
        if (entities.isNotEmpty) {
          contextStr = 'World Context:\n';
          for (final entity in entities) {
            contextStr += '${entity.name} (${entity.type}): ${entity.attributesJson}\n';
          }
          contextStr += '\n';
        }
      } catch (e) {
        debugPrint('Error fetching entity context: $e');
      }
    }
    
    // RAG Pipeline Step 3: Build prompt with context + user message
    final prompt = contextStr.isEmpty 
        ? message.text 
        : '$contextStr User question: ${message.text}';
    
    // Send to Gemini API
    try {
      final gemini = Gemini.instance;
      final response = await gemini.prompt(parts: [Part.text(prompt)]);
      
      final aiMessage = ChatMessage(
        text: response?.output ?? 'No response from AI',
        user: _geminiUser,
        createdAt: DateTime.now(),
      );
      
      setState(() {
        _messages.insert(0, aiMessage);
      });
    } catch (e) {
      final errorMessage = ChatMessage(
        text: '❌ API Error: $e',
        user: _geminiUser,
        createdAt: DateTime.now(),
      );
      setState(() {
        _messages.insert(0, errorMessage);
      });
    }
  }
}
