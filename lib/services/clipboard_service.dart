import 'package:super_clipboard/super_clipboard.dart';

/// Service for copying rich text content to the Android clipboard.
/// 
/// Handles both HTML and plain text formats to ensure compatibility
/// with various Android apps.
class ClipboardService {
  /// Copy both HTML and plain text to the system clipboard.
  /// 
  /// This method writes two formats:
  /// - HTML: For apps that support rich text (Gmail, Google Docs, etc.)
  /// - Plain text: Fallback for apps that only support plain text
  /// 
  /// Example:
  /// ```dart
  /// final service = ClipboardService();
  /// await service.copyRichText(
  ///   '<p><strong>Bold text</strong></p>',
  ///   'Bold text'
  /// );
  /// ```
  /// 
  /// Throws an [Exception] if clipboard is not available or write fails.
  Future<void> copyRichText(String html, String plain) async {
    final clipboard = SystemClipboard.instance;
    
    if (clipboard == null) {
      throw Exception('Clipboard not available on this platform');
    }

    final item = DataWriterItem();
    item.add(Formats.htmlText(html));
    item.add(Formats.plainText(plain));

    try {
      await clipboard.write([item]);
    } catch (e) {
      throw Exception('Failed to write to clipboard: $e');
    }
  }

  /// Check if clipboard is available on the current platform.
  bool get isAvailable => SystemClipboard.instance != null;
}
