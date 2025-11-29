import 'package:flutter/material.dart';

/// AI Action Menu - Shows AI options for selected text
class AiActionMenu extends StatelessWidget {
  final VoidCallback onImprove;
  final VoidCallback onFixGrammar;
  final VoidCallback onTranslate;
  final VoidCallback onMakeShorter;
  final VoidCallback onMakeLonger;
  final VoidCallback onContinue;
  
  const AiActionMenu({
    super.key,
    required this.onImprove,
    required this.onFixGrammar,
    required this.onTranslate,
    required this.onMakeShorter,
    required this.onMakeLonger,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'AI Actions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.auto_fix_high, size: 20),
            title: const Text('Improve Writing'),
            onTap: onImprove,
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.spellcheck, size: 20),
            title: const Text('Fix Grammar'),
            onTap: onFixGrammar,
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.translate, size: 20),
            title: const Text('Translate to English'),
            onTap: onTranslate,
          ),
          const Divider(height: 1),
          ListTile(
            dense: true,
            leading: const Icon(Icons.compress, size: 20),
            title: const Text('Make Shorter'),
            onTap: onMakeShorter,
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.expand, size: 20),
            title: const Text('Make Longer'),
            onTap: onMakeLonger,
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.auto_stories, size: 20),
            title: const Text('Continue Writing'),
            onTap: onContinue,
          ),
        ],
      ),
    );
  }
}
