import 'package:basic_e_commerce_app/src/features/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../commons/widgets/custom_button.dart';
import '../../../commons/widgets/custom_down_drop_field.dart';
import '../../../commons/widgets/reusable_back_button.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';

class EditProfileScreen extends StatelessWidget {
  static String routeName = 'editProfile';
  static const routePath = '/editProfile';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: const ReusableBackButton(),//routePath: ProfileScreen.routePath

        centerTitle: true,
        title: const Text('Edit Profile'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(ImageAssets.appleLogo),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          // Handle change picture action
                        },
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.theme,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Change Picture',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Input Fields
              const Text(
                'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'John Doe',
                  hintStyle: const TextStyle(color: AppColors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.grey, ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.theme),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Email ID',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'johndoe@gmail.com',
                  hintStyle: const TextStyle(color: AppColors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.grey, ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.theme),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Phone Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: '+91 1234567890',
                  hintStyle: const TextStyle(color: AppColors.grey),
                  suffixIcon: TextButton(
                    onPressed: () {
                      // Handle phone number change
                    },
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        color: AppColors.theme,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.grey, ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.theme),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Gender Dropdown
              CustomDropdownField(
                label: 'Gender',
                value: 'Male',
                items: const ['Male', 'Female', 'Other'],
                onChanged: (value) {
                  // Handle gender change
                },
              ),
              const SizedBox(height: 30),
              // Update Button
              const CustomButton(
                label: 'Update', route: ProfileScreen.routePath,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
