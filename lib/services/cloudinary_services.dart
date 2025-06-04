import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  final Cloudinary _cloudinary;

  CloudinaryService()
    : _cloudinary = Cloudinary.unsignedConfig(
        cloudName: dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '',
      );

  Future<String?> uploadImage(
    String filePath,
    String uploadPreset, {
    String? fileName,
    String? folder,
  }) async {
    try {
      // Check if file exists
      final File file = File(filePath);
      if (!await file.exists()) {
        return null;
      }

      // Ensure file size isn't zero
      final fileStats = await file.stat();
      if (fileStats.size == 0) {
        return null;
      }

      // Verify upload preset is correct - this is crucial
      if (uploadPreset.isEmpty) {
        return null;
      }

      // Perform the upload with complete parameters - simplified for debugging
      final response = await _cloudinary.unsignedUpload(
        file: filePath,
        uploadPreset: uploadPreset,
        resourceType: CloudinaryResourceType.image,
        // First try without optional parameters that might be causing issues
      );

      if (response.isSuccessful) {
        return response.secureUrl;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
