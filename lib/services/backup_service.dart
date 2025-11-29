import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive_io.dart';
import 'dart:convert';

/// Service for backing up and restoring the database
class BackupService {
  /// Export complete database as ZIP file
  /// Returns path to the created ZIP file
  Future<String> exportBackup() async {
    try {
      // Get database file path
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = p.join(appDir.path, 'universe_architect.db');
      final dbFile = File(dbPath);
      
      if (!await dbFile.exists()) {
        throw Exception('Database file not found');
      }
      
      // Create archive
      final archive = Archive();
      
      // Add database file
      final dbBytes = await dbFile.readAsBytes();
      archive.addFile(ArchiveFile(
        'universe_architect.db',
        dbBytes.length,
        dbBytes,
      ));
      
      // Add metadata
      final metadata = {
        'exported_at': DateTime.now().toIso8601String(),
        'version': '2.0.0',
        'app': 'Universe Architect',
      };
      archive.addFile(ArchiveFile.string(
        'metadata.json',
        jsonEncode(metadata),
      ));
      
      // Encode to ZIP
      final zipData = ZipEncoder().encode(archive);
      if (zipData == null) {
        throw Exception('Failed to create ZIP archive');
      }
      
      // Save to Downloads directory
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'universe_architect_backup_$timestamp.zip';
      
      // Try to save to Downloads, fallback to app directory
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        // On Android, use external storage Downloads
        downloadsDir = Directory('/storage/emulated/0/Download');
        if (!await downloadsDir.exists()) {
          downloadsDir = await getExternalStorageDirectory();
        }
      } else {
        downloadsDir = await getDownloadsDirectory();
      }
      
      downloadsDir ??= appDir;
      
      final zipFile = File(p.join(downloadsDir.path, fileName));
      await zipFile.writeAsBytes(zipData);
      
      return zipFile.path;
    } catch (e) {
      print('Backup error: $e');
      rethrow;
    }
  }
  
  /// Import backup from ZIP file
  /// Returns true if successful
  Future<bool> importBackup(String zipPath) async {
    try {
      final zipFile = File(zipPath);
      if (!await zipFile.exists()) {
        throw Exception('Backup file not found');
      }
      
      // Read and decode ZIP
      final zipBytes = await zipFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(zipBytes);
      
      // Find database file in archive
      final dbArchiveFile = archive.files.firstWhere(
        (file) => file.name == 'universe_architect.db',
        orElse: () => throw Exception('Invalid backup file'),
      );
      
      // Extract database
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = p.join(appDir.path, 'universe_architect.db');
      final dbFile = File(dbPath);
      
      // Write database file
      await dbFile.writeAsBytes(dbArchiveFile.content as List<int>);
      
      return true;
    } catch (e) {
      print('Restore error: $e');
      return false;
    }
  }
  
  /// Get backup file size in MB
  Future<double> getBackupSize() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = p.join(appDir.path, 'universe_architect.db');
      final dbFile = File(dbPath);
      
      if (await dbFile.exists()) {
        final bytes = await dbFile.length();
        return bytes / (1024 * 1024); // Convert to MB
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }
}
