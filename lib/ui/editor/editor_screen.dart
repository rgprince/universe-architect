import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import '../../services/clipboard_service.dart';
import '../../services/email_service.dart';
import '../widgets/word_count_widget.dart';

/// Provider for the Quill editor controller

final editorControllerProvider = StateProvider<QuillController>((ref) {
  return QuillController.basic();
});

/// Provider to toggle between editor and HTML view
final isHtmlViewProvider = StateProvider<bool>((ref) => false);

class EditorScreen extends ConsumerWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(editorControllerProvider);
    final isHtmlView = ref.watch(isHtmlViewProvider);

    // Get plain text for word count
    final plainText = controller.document.toPlainText();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Word count badge
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WordCountWidget(text: plainText),
          ),
          // Email chapter button
          IconButton(
            icon: const Icon(Icons.email),
            tooltip: 'Email Chapter',
            onPressed: () => _emailChapter(context, ref, controller),
          ),
          // Copy HTML button
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copy HTML',
            onPressed: () => _copyHtml(context, controller),
          ),
        ],
      ),
      body: Column(
        children: [
          if (!isHtmlView)
            Expanded(
              child: QuillToolbar.simple(
                controller: controller,
                configurations: const QuillSimpleToolbarConfigurations(
                  sharedConfigurations: QuillSharedConfigurations(),
                ),
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: isHtmlView
                  ? _buildHtmlView(controller)
                  : QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: controller,
                        placeholder: 'Start writing your story...',
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(isHtmlViewProvider.notifier).state = !isHtmlView;
        },
        icon: Icon(isHtmlView ? Icons.edit : Icons.preview),
        label: Text(isHtmlView ? 'Edit' : 'Preview HTML'),
      ),
    );
  }

  Widget _buildHtmlView(QuillController controller) {
    final delta = controller.document.toDelta();
    final converter = QuillDeltaToHtmlConverter(
      delta.toJson(),
      ConverterOptions.forEmail(),
    );
    final html = converter.convert();

    return SingleChildScrollView(
      child: SelectableText(
        html,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }

  Future<void> _copyHtml(BuildContext context, QuillController controller) async {
    final delta = controller.document.toDelta();
    final converter = QuillDeltaToHtmlConverter(
      delta.toJson(),
      ConverterOptions.forEmail(),
    );
    final html = converter.convert();
    final plain = controller.document.toPlainText();

    final clipboardService = ClipboardService();
    await clipboardService.copyRichText(html, plain);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ HTML copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _emailChapter(
    BuildContext context,
    WidgetRef ref,
    QuillController controller,
  ) async {
    final titleController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('📧 Email Chapter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Chapter Title',
                hintText: 'e.g., Chapter 1: The Beginning',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'This will send the chapter to your configured email address with a timestamp for copyright protection.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.send),
            label: const Text('Send'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final emailService = EmailService();
      final plainText = controller.document.toPlainText();
      
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Preparing email...'),
                ],
              ),
            ),
          ),
        ),
      );

      final success = await emailService.sendChapterProof(
        chapterTitle: titleController.text.trim().isNotEmpty
            ? titleController.text.trim()
            : 'Untitled Chapter',
        chapterContent: plainText,
      );

      if (context.mounted) {
        Navigator.pop(context); // Close loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? '✓ Chapter email prepared! (Email feature requires SMTP configuration)'
                  : '❌ Please configure email in Settings first.',
            ),
            backgroundColor: success ? Colors.green : Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
