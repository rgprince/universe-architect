import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../data/database.dart';
import '../../data/providers/database_provider.dart';
import '../../services/preferences_service.dart';

/// AI Chat Screen with persistent conversation history
class AiChatHistoryScreen extends ConsumerStatefulWidget {
  final Book? book;
  
  const AiChatHistoryScreen({super.key, this.book});

  @override
  ConsumerState<AiChatHistoryScreen> createState() => _AiChatHistoryScreenState();
}

class _AiChatHistoryScreenState extends ConsumerState<AiChatHistoryScreen> {
  AiConversation? _selectedConversation;
  final _messageController = TextEditingController();
  final _prefs = PreferencesService();
  GenerativeModel? _model;
  bool _isLoading = false;
  
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment),
            tooltip: 'New Conversation',
            onPressed: _createNewConversation,
          ),
        ],
      ),
      body: Row(
        children: [
          // Conversations list (sidebar)
          SizedBox(
            width: 250,
            child: _buildConversationsList(),
          ),
          const VerticalDivider(width: 1),
          // Chat view
          Expanded(
            child: _selectedConversation == null
                ? _buildEmptyState()
                : _buildChatView(),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsList() {
    final db = ref.watch(databaseProvider);
    
    return FutureBuilder<List<AiConversation>>(
      future: widget.book != null
          ? (db.select(db.aiConversations)
              ..where((c) => c.bookId.equals(widget.book!.id))
              ..orderBy([(c) => drift.OrderingTerm.desc(c.updatedAt)]))
              .get()
          : (db.select(db.aiConversations)
              ..orderBy([(c) => drift.OrderingTerm.desc(c.updatedAt)]))
              .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final conversations = snapshot.data ?? [];
        
        if (conversations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('No conversations yet'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _createNewConversation,
                  child: const Text('Start Chat'),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            final conv = conversations[index];
            final isSelected = _selectedConversation?.id == conv.id;
            
            return ListTile(
              selected: isSelected,
              leading: const Icon(Icons.chat),
              title: Text(
                conv.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                _formatDate(conv.updatedAt),
                style: const TextStyle(fontSize: 12),
              ),
              onTap: () {
                setState(() {
                  _selectedConversation = conv;
                });
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: () => _deleteConversation(conv),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text('Select a conversation or start a new one'),
        ],
      ),
    );
  }

  Widget _buildChatView() {
    if (_selectedConversation == null) return const SizedBox();
    
    final db = ref.watch(databaseProvider);
    
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedConversation!.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              if (widget.book != null)
                Chip(
                  label: Text(widget.book!.title),
                  avatar: const Icon(Icons.book, size: 16),
                ),
            ],
          ),
        ),
        // Messages
        Expanded(
          child: FutureBuilder<List<AiMessage>>(
            future: (db.select(db.aiMessages)
                  ..where((m) => m.conversationId.equals(_selectedConversation!.id))
                  ..orderBy([(m) => drift.OrderingTerm.asc(m.timestamp)]))
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              final messages = snapshot.data ?? [];
              
              if (messages.isEmpty) {
                return const Center(
                  child: Text('Start the conversation by sending a message!'),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return _buildMessage(msg);
                },
              );
            },
          ),
        ),
        // Input
        if (_isLoading)
          const LinearProgressIndicator(),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Ask about your book...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  enabled: !_isLoading,
                  onSubmitted: _isLoading ? null : (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _isLoading ? null : _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessage(AiMessage msg) {
    final isUser = msg.role == 'user';
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.content,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(msg.timestamp),
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNewConversation() async {
    final titleController = TextEditingController();
    
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Conversation'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Conversation Title',
            hintText: 'e.g., Character Development Ideas',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, titleController.text),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    
    if (title == null || title.trim().isEmpty) return;
    
    final db = ref.read(databaseProvider);
    final id = await db.into(db.aiConversations).insert(
      AiConversationsCompanion.insert(
        bookId: drift.Value(widget.book?.id),
        title: title.trim(),
      ),
    );
    
    final newConv = await (db.select(db.aiConversations)
          ..where((c) => c.id.equals(id)))
        .getSingle();
    
    setState(() {
      _selectedConversation = newConv;
    });
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    
    setState(() {
      _isLoading = true;
    });
    
    final db = ref.read(databaseProvider);
    
    // Save user message
    await db.into(db.aiMessages).insert(
      AiMessagesCompanion.insert(
        conversationId: _selectedConversation!.id,
        role: 'user',
        content: message,
      ),
    );
    
    _messageController.clear();
    setState(() {});
    
    // Get AI response
    try {
      await _initModel();
      
      // Build context from book if available
      String contextPrompt = '';
      if (widget.book != null) {
        final characters = await db.getEntitiesByType(widget.book!.universeId, EntityType.character);
        final locations = await db.getEntitiesByType(widget.book!.universeId, EntityType.location);
        
        contextPrompt = '''
Context about the book "${widget.book!.title}":
${widget.book!.synopsis ?? ""}

Characters: ${characters.map((c) => c.name).join(', ')}
Locations: ${locations.map((l) => l.name).join(', ')}

''';
      }
      
      final fullPrompt = contextPrompt + message;
      final response = await _model!.generateContent([Content.text(fullPrompt)]);
      final aiResponse = response.text ?? 'Sorry, I could not generate a response.';
      
      // Save AI response
      await db.into(db.aiMessages).insert(
        AiMessagesCompanion.insert(
          conversationId: _selectedConversation!.id,
          role: 'assistant',
          content: aiResponse,
        ),
      );
      
      // Update conversation timestamp
      await (db.update(db.aiConversations)
            ..where((c) => c.id.equals(_selectedConversation!.id)))
          .write(AiConversationsCompanion(
            updatedAt: drift.Value(DateTime.now()),
          ));
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _initModel() async {
    if (_model != null) return;
    
    final apiKey = await _prefs.getGeminiApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Please set Gemini API key in Settings');
    }
    
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
  }

  Future<void> _deleteConversation(AiConversation conv) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Conversation?'),
        content: const Text('This will permanently delete all messages in this conversation.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    
    if (confirmed != true) return;
    
    final db = ref.read(databaseProvider);
    await (db.delete(db.aiConversations)..where((c) => c.id.equals(conv.id))).go();
    
    if (_selectedConversation?.id == conv.id) {
      setState(() {
        _selectedConversation = null;
      });
    } else {
      setState(() {});
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.month}/${date.day}/${date.year}';
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
