import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../commons/providers/common_providers.dart';
import '../../../models/user_model.dart';
import '../../../res/colors.dart';
import '../../../utils/snackbar_service.dart';
import '../../file/controller/file_controller.dart';
import '../models/profile.dart';
import '../repository/profile_repo.dart';


final  profileController = StateNotifierProvider<ProfileController, User?>(
      (ref) {
    final repo = ref.watch(profileRepoProvider);
    final user = ref.watch(currentUserProvider);
    return ProfileController(repo: repo, ref: ref, user: user);
  },
);

class ProfileController extends StateNotifier<User?> {
  final ProfileRepo _repo;
  final Ref _ref;
  //final User? _user;

  ProfileController({
    required ProfileRepo repo,
    required Ref ref,
    required User? user,
  })  : _repo = repo,
        _ref = ref,
    //    _user = user,
        super(user); // Initial state

  Future<void> updateProfile({
    required BuildContext context,
    required Profile profile,
    File? file,
  }) async {
    try {
      final result = await _repo.updateProfile(profile: profile, file: file);
      result.fold(
            (failure) {
          SnackBarService.showSnackBar(
            context: context,
            message: "Profile update failed: ${failure.message}",
            backgroundColor: const Color.fromARGB(255, 227, 121, 113),
          );
        },
            (response) {
          // Handle the success case
          final data = jsonDecode(response.body);
          final success = data['success'];

          SnackBarService.showSnackBar(
            context: context,
            message: success
                ? "Profile updated successfully"
                : "Profile update failed",
            backgroundColor: success
                ? AppColors.green
                : const Color.fromARGB(255, 215, 101, 93),
          );

          if (success) {
            final userDetails = data['user'];
            log('User Details: $userDetails');
            final user = User.fromJson(userDetails);

            _ref.read(currentUserProvider.notifier).update((state) => user);
            context.pop();
          }
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e');
      log('Stacktrace: $stacktrace');

      // Show error snackbar
      SnackBarService.showSnackBar(
        context: context,
        message: "An unexpected error occurred",
        backgroundColor: const Color.fromARGB(255, 227, 121, 113),
      );
    }
  }

  void selectFile(String imageType) async {
    final file = await _ref.read(fileControllerProvider).selectFile();
    if (file != null) {
      log('Selected file path: ${file.path}');
      switch (imageType) {
        case 'avatar':
          _ref.read(selectedAvatarFileProvider.notifier).state = file;
          break;
        default:
          break;
      }
    }
  }





}