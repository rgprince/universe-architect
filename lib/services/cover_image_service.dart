import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Service for handling book cover images
/// Picks, crops to 400x600, and saves cover images
class CoverImageService {
  final ImagePicker _picker = ImagePicker();
  
  /// Pick and crop an image for book cover (400x600 ratio)
  /// Returns the path to the saved cover image, or null if cancelled
  Future<String?> pickAndCropCover() async {
    try {
      // Pick image from gallery
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200, // Reasonable max size
        maxHeight: 1800,
        imageQuality: 85,
      );
      
      if (pickedFile == null) return null;
      
      // Crop to 400x600 ratio (2:3)
      final cropper = ImageCropper();
      final croppedFile = await cropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 3),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Book Cover',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
        ],
      );
      
      if (croppedFile == null) return null;
      
      // Save to app directory
      final appDir = await getApplicationDocumentsDirectory();
      final coversDir = Directory(p.join(appDir.path, 'covers'));
      
      if (!await coversDir.exists()) {
        await coversDir.create(recursive: true);
      }
      
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'cover_$timestamp.jpg';
      final savedPath = p.join(coversDir.path, fileName);
      
      await File(croppedFile.path).copy(savedPath);
      
      return savedPath;
    } catch (e) {
      debugPrint('Error picking cover image: $e');
      return null;
    }
  }
  
  /// Delete a cover image file
  Future<void> deleteCover(String? coverPath) async {
    if (coverPath == null || coverPath.isEmpty) return;
    
    try {
      final file = File(coverPath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting cover: $e');
    }
  }
}
