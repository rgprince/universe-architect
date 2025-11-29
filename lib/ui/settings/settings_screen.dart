import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/preferences_service.dart';
import '../backup/backup_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _prefs = PreferencesService();
  final _apiKeyController = TextEditingController();
  final _emailController = TextEditingController();
  
  bool _apiKeyObscured = true;
  int _selectedTheme = 0; // 0=System, 1=Light, 2=Dark
  int _selectedFont = 0; // 0=Sans, 1=Serif, 2=Mono
  
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    final apiKey = await _prefs.getApiKey();
    final email = await _prefs.getEmail();
    final theme = await _prefs.getThemeMode();
    final font = await _prefs.getEditorFont();
    
    setState(() {
      _apiKeyController.text = apiKey ?? '';
      _emailController.text = email ?? '';
      _selectedTheme = theme;
      _selectedFont = font;
    });
  }
  
  @override
  void dispose() {
    _apiKeyController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          _buildSection(
            title: 'AI Configuration',
            icon: Icons.smart_toy,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _apiKeyController,
                  obscureText: _apiKeyObscured,
                  decoration: InputDecoration(
                    labelText: 'Gemini API Key',
                    hintText: 'Enter your API key',
                    border: const OutlineInputBorder(),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(_apiKeyObscured ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _apiKeyObscured = !_apiKeyObscured;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.save, color: Colors.green),
                          onPressed: () async {
                            final apiKey = _apiKeyController.text.trim();
                            if (apiKey.isNotEmpty) {
                              await _prefs.setGeminiApiKey(apiKey);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('✓ API key saved')),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Get your free API key at: https://makersuite.google.com/app/apikey',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const Divider(),
          _buildSection(
            title: 'Email Configuration',
            icon: Icons.email,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Your Email',
                    hintText: 'for chapter delivery & copyright proof',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.save, color: Colors.green),
                      onPressed: () async {
                        final email = _emailController.text.trim();
                        if (email.isNotEmpty) {
                          await _prefs.saveEmail(email);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('✓ Email saved')),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Used for one-click chapter delivery and proof of authorship',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const Divider(),
          _buildSection(
            title: 'Appearance',
            icon: Icons.palette,
            children: [
              ListTile(
                title: const Text('Theme'),
                subtitle: Text(_getThemeName(_selectedTheme)),
                trailing: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text('Auto')),
                    ButtonSegment(value: 1, label: Text('Light')),
                    ButtonSegment(value: 2, label: Text('Dark')),
                  ],
                  selected: {_selectedTheme},
                  onSelectionChanged: (Set<int> newSelection) async {
                    setState(() {
                      _selectedTheme = newSelection.first;
                    });
                    await _prefs.saveThemeMode(_selectedTheme);
                  },
                ),
              ),
              ListTile(
                title: const Text('Editor Font'),
                subtitle: Text(_getFontName(_selectedFont)),
                trailing: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text('Sans')),
                    ButtonSegment(value: 1, label: Text('Serif')),
                    ButtonSegment(value: 2, label: Text('Mono')),
                  ],
                  selected: {_selectedFont},
                  onSelectionChanged: (Set<int> newSelection) async {
                    setState(() {
                      _selectedFont = newSelection.first;
                    });
                    await _prefs.saveEditorFont(_selectedFont);
                  },
                ),
              ),
            ],
          ),
          const Divider(),
          _buildSection(
            title: 'Backup & Data',
            icon: Icons.backup,
            children: [
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text('Backup & Restore'),
                subtitle: const Text('Export and import your data'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BackupScreen()),
                  );
                },
              ),
            ],
          ),
          const Divider(),
          _buildSection(
            title: 'About',
            icon: Icons.info,
            children: [
              const ListTile(
                title: Text('Universe Architect'),
                subtitle: Text('Version 2.0.0\nA professional novel writing app'),
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('Open Source'),
                subtitle: const Text('Built with Flutter'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        ...children,
      ],
    );
  }
  
  String _getThemeName(int mode) {
    switch (mode) {
      case 1:
        return 'Always Light';
      case 2:
        return 'Always Dark';
      default:
        return 'System Default';
    }
  }
  
  String _getFontName(int font) {
    switch (font) {
      case 1:
        return 'Serif (Classic)';
      case 2:
        return 'Monospace (Code)';
      default:
        return 'Sans-serif (Modern)';
    }
  }
}
