/*
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../../../core/api.dart';
import '../../../res/endpoints.dart';

final fileRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return FileRepo(api: api);
});

class FileRepo {
  final API _api;
  FileRepo({required API api}) : _api = api;

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

  Future<UplaodInfo?> uploadFile(
      {required File file, required UploadFileType type}) async {
    final extension = _getFileExstension(file);
    final info = await _getUploadUrl(extension: extension, type: type);
    if (info != null) {
      final fileUploadSuccess =
          await _upload(file: file, uploadUrl: info.uploadUrl);
      if (fileUploadSuccess) {
        log('File Uploaded successfully');
        return info;
      }
    }
    return null;
  }

  Future<bool> _upload({required File file, required String uploadUrl}) async {
    log('Uploading File to $uploadUrl');
    final response =
        await http.put(Uri.parse(uploadUrl), body: file.readAsBytesSync());
    return (response.statusCode == 200);
  }

  String _getFileExstension(File file) {
    final String filePath = file.path;
    final String extension = path.extension(filePath);
    final ext = extension.substring(1);
    log("File extension : $ext");
    return ext;
  }
}

enum UploadFileType {
  USER('User'),
  PARTNER('Partner'),
  THUMBNAIL('THUMBNAIL'),
  IMAGE('IMAGE');

  final String text;
  const UploadFileType(this.text);

  factory UploadFileType.fromText(String text) {
    switch (text.toUpperCase()) {
      case 'USER':
        return UploadFileType.USER;
      case 'PARTNER':
        return UploadFileType.PARTNER;
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

final fileRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return FileRepo(api: api);
});

class FileRepo {
  final API _api;
  FileRepo({required API api}) : _api = api;

  /// Retrieves an upload URL from the storage endpoint.
  ///
  /// [extension] is the file extension (e.g., "jpg").
  /// [type] must be either UploadFileType.USER or UploadFileType.PARTNER.
  /// [documentType] is optional. Allowed values are "Avatar" or "Image" (case-insensitive).
  /// If not provided or invalid, defaults to "Avatar" when type is USER, or "Image" when type is PARTNER.
  Future<UplaodInfo?> _getUploadUrl({
    required String extension,
    required UploadFileType type,
    String? documentType,
  }) async {
    if (type != UploadFileType.USER && type != UploadFileType.PARTNER) {
      throw Exception('Invalid uploadType: ${type.text}. Must be either "User" or "Partner".');
    }
    const allowedDocTypes = ['avatar', 'image'];
    final String finalDocumentType = (documentType != null && documentType.isNotEmpty && allowedDocTypes.contains(documentType.toLowerCase()))
        ? (documentType.toLowerCase() == 'avatar' ? 'Avatar' : 'Image')
        : (type == UploadFileType.USER ? 'Avatar' : 'Image');

    final body = {
      "extension": extension,
      "uploadType": type.text,
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

  /// Uploads a file using the provided [type] and optional [documentType].
  Future<UplaodInfo?> uploadFile({
    required File file,
    required UploadFileType type,
    String? documentType,
  }) async {
    final extension = _getFileExstension(file);
    final info = await _getUploadUrl(
      extension: extension,
      type: type,
      documentType: documentType,
    );
    if (info != null) {
      final fileUploadSuccess = await _upload(file: file, uploadUrl: info.uploadUrl);
      if (fileUploadSuccess) {
        log('File Uploaded successfully');
        return info;
      }
    }
    return null;
  }

  Future<bool> _upload({required File file, required String uploadUrl}) async {
    log('Uploading File to $uploadUrl');
    final response = await http.put(Uri.parse(uploadUrl), body: file.readAsBytesSync());
    return response.statusCode == 200;
  }

  String _getFileExstension(File file) {
    final String filePath = file.path;
    final String extension = path.extension(filePath);
    final ext = extension.substring(1);
    log("File extension : $ext");
    return ext;
  }
}

enum UploadFileType {
  USER('User'),
  PARTNER('Partner'),
  THUMBNAIL('THUMBNAIL'),
  IMAGE('IMAGE');

  final String text;
  const UploadFileType(this.text);

  factory UploadFileType.fromText(String text) {
    switch (text.toUpperCase()) {
      case 'USER':
        return UploadFileType.USER;
      case 'PARTNER':
        return UploadFileType.PARTNER;
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


