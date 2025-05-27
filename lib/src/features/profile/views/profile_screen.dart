import 'package:basic_e_commerce_app/src/features/cart/cart_screen.dart';
import 'package:basic_e_commerce_app/src/features/privacy_policy/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../commons/widgets/custom_menu_item_tile.dart';
import '../../../res/assets.dart';
import '../../../res/colors.dart';
import '../../category/category_screen.dart';
import '../../help_center/help_center_screen.dart';
import '../../logout/logout_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static String routeName = 'profile';
  static const routePath = '/profile';
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final menuItems = [
     // MenuItem(Icons.money_rounded, 'Payment Method', CartScreen.routePath),//PaymentMethodScreen
     // MenuItem(Icons.settings, 'Settings', CartScreen.routePath),//SettingsScreen
     // MenuItem(Icons.money, 'Transactions', CartScreen.routePath),//TransactionsScreen
      MenuItem(Icons.help_outline, 'Help Center', HelpCenterScreen.routePath),//HelpCenterScreen
      MenuItem(Icons.privacy_tip_outlined, 'Privacy Policy', PrivacyPolicyScreen.routePath),//PrivacyPolicyScreen
      MenuItem(Icons.logout, 'Log out', LogoutScreen.routePath),//LogoutScreen
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade900, Colors.teal.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Picture
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(ImageAssets.appleLogo),
                        ),
                        SizedBox(width: 16),
                        // Name and Age
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Edit Icon
                  Positioned(
                    top: 20,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: AppColors.black,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          context.push(EditProfileScreen.routePath);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // List of Menu Items
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];
                return CustomMenuItemTile(
                  menuItem: menuItem,
                  onTap: () {
                    context.push(menuItem.routePath);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


