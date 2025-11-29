import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive_io.dart';
import '../data/database.dart';

/// Export Service - EPUB and text export
class ExportService {
  /// Export book to EPUB format
  Future<String?> exportToEpub(AppDatabase db, Book book) async {
    try {
      // Get all chapters
      final chapters = await db.getChaptersForBook(book.id);
      if (chapters.isEmpty) {
        throw Exception('No chapters to export');
      }
      
      // Sort by chapter number
      chapters.sort((a, b) => a.chapterNumber.compareTo(b.chapterNumber));
      
      // Get download directory
      final directory = await getExternalStorageDirectory();
      if (directory == null) throw Exception('Cannot access storage');
      
      final downloadsDir = Directory(p.join(directory.path, 'Downloads'));
      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }
      
      // Create EPUB structure
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${book.title.replaceAll(' ', '_')}_$timestamp.epub';
      final epubPath = p.join(downloadsDir.path, fileName);
      
      // Create temp directory for EPUB contents
      final tempDir = await Directory.systemTemp.createTemp('epub_');
      
      // Create EPUB structure
      await _createEpubStructure(tempDir.path, book, chapters);
      
      // Zip to EPUB
      final encoder = ZipFileEncoder();
      encoder.create(epubPath);
      encoder.addDirectory(Directory(tempDir.path));
      encoder.close();
      
      // Cleanup
      await tempDir.delete(recursive: true);
      
      return epubPath;
    } catch (e) {
      debugPrint('Error exporting EPUB: $e');
      return null;
    }
  }
  
  Future<void> _createEpubStructure(String basePath, Book book, List<Chapter> chapters) async {
    // Create directories
    final metaInfDir = Directory(p.join(basePath, 'META-INF'));
    final oebpsDir = Directory(p.join(basePath, 'OEBPS'));
    
    await metaInfDir.create(recursive: true);
    await oebpsDir.create(recursive: true);
    
    // mimetype file
    await File(p.join(basePath, 'mimetype')).writeAsString('application/epub+zip');
    
    // container.xml
    final containerXml = '''<?xml version="1.0"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>''';
    await File(p.join(metaInfDir.path, 'container.xml')).writeAsString(containerXml);
    
    // content.opf
    final contentOpf = _generateContentOpf(book, chapters);
    await File(p.join(oebpsDir.path, 'content.opf')).writeAsString(contentOpf);
    
    // toc.ncx
    final tocNcx = _generateTocNcx(book, chapters);
    await File(p.join(oebpsDir.path, 'toc.ncx')).writeAsString(tocNcx);
    
    // Chapter HTML files
    for (int i = 0; i < chapters.length; i++) {
      final chapter = chapters[i];
      final chapterHtml = _generateChapterHtml(chapter);
      await File(p.join(oebpsDir.path, 'chapter${i + 1}.html')).writeAsString(chapterHtml);
    }
  }
  
  String _generateContentOpf(Book book, List<Chapter> chapters) {
    final chapterManifest = chapters.asMap().entries.map((e) => 
      '<item id="chapter${e.key + 1}" href="chapter${e.key + 1}.html" media-type="application/xhtml+xml"/>'
    ).join('\n    ');
    
    final chapterSpine = chapters.asMap().entries.map((e) => 
      '<itemref idref="chapter${e.key + 1}"/>'
    ).join('\n    ');
    
    return '''<?xml version="1.0" encoding="UTF-8"?>
<package xmlns="http://www.idpf.org/2007/opf" version="2.0" unique-identifier="BookID">
  <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
    <dc:title>${book.title}</dc:title>
    <dc:language>en</dc:language>
    <dc:identifier id="BookID">urn:uuid:${book.id}</dc:identifier>
  </metadata>
  <manifest>
    <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
    $chapterManifest
  </manifest>
  <spine toc="ncx">
    $chapterSpine
  </spine>
</package>''';
  }
  
  String _generateTocNcx(Book book, List<Chapter> chapters) {
    final navPoints = chapters.asMap().entries.map((e) {
      final chapter = e.value;
      final title = chapter.title ?? 'Chapter ${e.key + 1}';
      return '''    <navPoint id="chapter${e.key + 1}" playOrder="${e.key + 1}">
      <navLabel><text>$title</text></navLabel>
      <content src="chapter${e.key + 1}.html"/>
    </navPoint>''';
    }).join('\n');
    
    return '''<?xml version="1.0" encoding="UTF-8"?>
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
  <head>
    <meta name="dtb:uid" content="urn:uuid:${book.id}"/>
  </head>
  <docTitle><text>${book.title}</text></docTitle>
  <navMap>
$navPoints
  </navMap>
</ncx>''';
  }
  
  String _generateChapterHtml(Chapter chapter) {
    final title = chapter.title ?? 'Chapter ${chapter.chapterNumber}';
    final content = chapter.contentHtml ?? '<p>No content</p>';
    
    return '''<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>$title</title>
  <style>
    body { font-family: Georgia, serif; margin: 2em; line-height: 1.6; }
    h1 { text-align: center; margin-bottom: 2em; }
    p { text-indent: 1.5em; margin: 0.5em 0; }
  </style>
</head>
<body>
  <h1>$title</h1>
  <div>$content</div>
</body>
</html>''';
  }
}
