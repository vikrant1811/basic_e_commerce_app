/*
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../../../core/api.dart';
import '../../../res/endpoints.dart';

final warehouseFileRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return WarehouseFile(api: api);
});

class WarehouseFile {
  final API _api;
  WarehouseFile({required API api}) : _api = api;

  // Method to get upload URL for a single file
  Future<UplaodInfo?> _getUploadUrl({
    required String extension,
    required UploadFileType type,
  }) async {
    final body = {"extension": extension, "uploadType": type.text};

    final result = await _api.postRequest(
        url: Endpoints.storage, body: body, requireAuth: false);
    return result.fold((l) {
      log('Failed to get downloadUrl');
      return null;
    }, (r) {
      final data = jsonDecode(r.body);
      final info = UplaodInfo.fromJson(data);
      return info;
    });
  }

  // Method to upload a single file
  Future<UplaodInfo?> uploadFile({
    required File file,
    required UploadFileType type,
  }) async {
    final extension = _getFileExtension(file);
    final info = await _getUploadUrl(extension: extension, type: type);
    if (info != null) {
      final fileUploadSuccess =
          await _upload(file: file, uploadUrl: info.uploadUrl);
      if (fileUploadSuccess) {
        log('File uploaded successfully');
        return info;
      }
    }
    return null;
  }

  // Method to upload multiple files
  Future<List<UplaodInfo?>> uploadMultipleFiles({
    required List<File> files,
    required UploadFileType type,
  }) async {
    List<UplaodInfo?> uploadResults = [];
    for (File file in files) {
      final result = await uploadFile(file: file, type: type);
      uploadResults.add(result);
    }
    return uploadResults;
  }

  // Method to upload a thumbnail file
  Future<UplaodInfo?> uploadThumbnail({
    required File thumbnail,
  }) async {
    return await uploadFile(file: thumbnail, type: UploadFileType.THUMBNAIL);
  }

  // Helper method to perform file upload
  Future<bool> _upload({required File file, required String uploadUrl}) async {
    log('Uploading File to $uploadUrl');
    final response = await http.put(
      Uri.parse(uploadUrl),
      body: file.readAsBytesSync(),
    );
    return (response.statusCode == 200);
  }

  // Helper method to get file extension
  String _getFileExtension(File file) {
    final String filePath = file.path;
    final String extension = path.extension(filePath);
    final ext = extension.substring(1);
    log("File extension : $ext");
    return ext;
  }
}

enum UploadFileType {
  THUMBNAIL('THUMBNAIL'), // Thumbnail
  IMAGE('IMAGE'); // For general images

  final String text;
  const UploadFileType(this.text);

  factory UploadFileType.fromText(String text) {
    switch (text.toUpperCase()) {
      case 'THUMBNAIL':
        return UploadFileType.THUMBNAIL;
      case 'IMAGE':
        return UploadFileType.IMAGE;
      default:
        throw Exception('Invalid UploadFileType: $text');
    }
  }
}

UplaodInfo uplaodInfoFromJson(String str) =>
    UplaodInfo.fromJson(json.decode(str));

String uplaodInfoToJson(UplaodInfo data) => json.encode(data.toJson());

class UplaodInfo {
  final String uploadUrl;
  final bool success;
  final String fileName;
  final String downloadUrl;
  final String key;

  UplaodInfo({
    required this.uploadUrl,
    required this.success,
    required this.fileName,
    required this.downloadUrl,
    required this.key,
  });

  UplaodInfo copyWith({
    String? uploadUrl,
    bool? success,
    String? fileName,
    String? downloadUrl,
    String? key,
  }) =>
      UplaodInfo(
        uploadUrl: uploadUrl ?? this.uploadUrl,
        success: success ?? this.success,
        fileName: fileName ?? this.fileName,
        downloadUrl: downloadUrl ?? this.downloadUrl,
        key: key ?? this.key,
      );

  factory UplaodInfo.fromJson(Map<String, dynamic> json) => UplaodInfo(
        uploadUrl: json["uploadUrl"],
        success: json["success"],
        fileName: json["fileName"],
        downloadUrl: json["downloadUrl"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "uploadUrl": uploadUrl,
        "success": success,
        "fileName": fileName,
        "downloadUrl": downloadUrl,
        "key": key,
      };
}

 */
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../../../core/api.dart';
import '../../../res/endpoints.dart';

final warehouseFileRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return WarehouseFile(api: api);
});

class WarehouseFile {
  final API _api;
  WarehouseFile({required API api}) : _api = api;

  /// Retrieves an upload URL for a file.
  ///
  /// [extension]: The file extension (e.g. "jpg").
  /// [type]: The upload type (THUMBNAIL or IMAGE).
  /// [documentType]: Optional parameter. Allowed values are "Avatar" or "Image" (case-insensitive).
  /// If null or invalid, defaults to "Image".
  Future<UplaodInfo?> _getUploadUrl({
    required String extension,
    required UploadFileType type,
    String? documentType,
  }) async {
    // Allowed document types.
    const allowedDocTypes = ['avatar', 'image'];
    final String finalDocumentType = (documentType != null &&
        documentType.isNotEmpty &&
        allowedDocTypes.contains(documentType.toLowerCase()))
        ? (documentType.toLowerCase() == 'avatar' ? 'Avatar' : 'Image')
        : 'Image';

    final body = {
      "extension": extension,
      "uploadType": type.text, // For warehouse, this will be either "THUMBNAIL" or "IMAGE"
      "documentType": finalDocumentType,
    };

    final result = await _api.postRequest(
      url: Endpoints.storage,
      body: body,
      requireAuth: false,
    );

    return result.fold(
          (l) {
        log('Failed to get downloadUrl');
        return null;
      },
          (r) {
        final data = jsonDecode(r.body);
        final info = UplaodInfo.fromJson(data);
        return info;
      },
    );
  }

  /// Uploads a single file.
  ///
  /// [file]: The file to be uploaded.
  /// [type]: The upload type.
  /// [documentType]: Optional parameter to override default document type.
  Future<UplaodInfo?> uploadFile({
    required File file,
    required UploadFileType type,
    String? documentType,
  }) async {
    final extension = _getFileExtension(file);
    final info = await _getUploadUrl(
      extension: extension,
      type: type,
      documentType: documentType,
    );
    if (info != null) {
      final fileUploadSuccess = await _upload(file: file, uploadUrl: info.uploadUrl);
      if (fileUploadSuccess) {
        log('File uploaded successfully');
        return info;
      }
    }
    return null;
  }

  /// Uploads multiple files.
  Future<List<UplaodInfo?>> uploadMultipleFiles({
    required List<File> files,
    required UploadFileType type,
    String? documentType,
  }) async {
    List<UplaodInfo?> uploadResults = [];
    for (File file in files) {
      final result = await uploadFile(file: file, type: type, documentType: documentType);
      uploadResults.add(result);
    }
    return uploadResults;
  }

  /// Uploads a thumbnail file.
  Future<UplaodInfo?> uploadThumbnail({
    required File thumbnail,
  }) async {
    // For thumbnails, you may decide to always use "Image" as documentType.
    return await uploadFile(
      file: thumbnail,
      type: UploadFileType.THUMBNAIL,
      documentType: "Image",
    );
  }

  Future<bool> _upload({required File file, required String uploadUrl}) async {
    log('Uploading File to $uploadUrl');
    final response = await http.put(Uri.parse(uploadUrl), body: file.readAsBytesSync());
    return (response.statusCode == 200);
  }

  String _getFileExtension(File file) {
    final String filePath = file.path;
    final String extension = path.extension(filePath);
    final ext = extension.substring(1);
    log("File extension : $ext");
    return ext;
  }
}

enum UploadFileType {
  THUMBNAIL('THUMBNAIL'), // Thumbnail
  IMAGE('IMAGE'); // For general images

  final String text;
  const UploadFileType(this.text);

  factory UploadFileType.fromText(String text) {
    switch (text.toUpperCase()) {
      case 'THUMBNAIL':
        return UploadFileType.THUMBNAIL;
      case 'IMAGE':
        return UploadFileType.IMAGE;
      default:
        throw Exception('Invalid UploadFileType: $text');
    }
  }
}

UplaodInfo uplaodInfoFromJson(String str) => UplaodInfo.fromJson(json.decode(str));
String uplaodInfoToJson(UplaodInfo data) => json.encode(data.toJson());

class UplaodInfo {
  final String uploadUrl;
  final bool success;
  final String fileName;
  final String downloadUrl;
  final String key;

  UplaodInfo({
    required this.uploadUrl,
    required this.success,
    required this.fileName,
    required this.downloadUrl,
    required this.key,
  });

  UplaodInfo copyWith({
    String? uploadUrl,
    bool? success,
    String? fileName,
    String? downloadUrl,
    String? key,
  }) =>
      UplaodInfo(
        uploadUrl: uploadUrl ?? this.uploadUrl,
        success: success ?? this.success,
        fileName: fileName ?? this.fileName,
        downloadUrl: downloadUrl ?? this.downloadUrl,
        key: key ?? this.key,
      );

  factory UplaodInfo.fromJson(Map<String, dynamic> json) => UplaodInfo(
    uploadUrl: json["uploadUrl"],
    success: json["success"],
    fileName: json["fileName"],
    downloadUrl: json["downloadUrl"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "uploadUrl": uploadUrl,
    "success": success,
    "fileName": fileName,
    "downloadUrl": downloadUrl,
    "key": key,
  };
}

