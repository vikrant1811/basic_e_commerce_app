import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../../../core/core.dart';
import '../../../res/base.dart';
import '../../../res/endpoints.dart';
import '../../file/repository/file_repo.dart';
import '../models/profile.dart';

final profileRepoProvider = Provider<ProfileRepo>((ref) {
  final api = ref.watch(apiProvider);
  return ProfileRepo(api: api, ref: ref);
});

class ProfileRepo {
  final API _api;
  final Ref _ref;

  ProfileRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> updateProfile({
    required Profile profile,
    File? file,
  }) async {
    final body = {
      "name": profile.name,
      "address": profile.address,
      "city": profile.city,
      "pincode": profile.pincode,
      "state": profile.state,
      "country": profile.country,
    };
    if (file != null) {
      final info = await _ref
          .read(fileRepoProvider)
          .uploadFile(file: file, type: UploadFileType.USER);
      log(info.toString());
      if (info != null) {
        body['avatar'] = "${BasePaths.storageURL}${info.key}";
      }
    }

    final response =
    await _api.patchRequest(url: Endpoints.editProfile, body: body);
    return response;
  }




}