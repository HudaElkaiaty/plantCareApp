import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/core/color_manager.dart'; 
import 'package:plantcare/core/style_manager.dart'; 
import 'package:plantcare/features/profile/cubit/profile_cubit.dart';
import 'package:plantcare/features/profile/cubit/states.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorManager.scaffoldBackground,
      child: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Container(
                  height: 175, 
                  color: ColorManager.greenColor,
                  child: const Center(
                    child: CircularProgressIndicator(color: ColorManager.whiteColor),
                  ),
                );
              }

              if (state is ProfileLoaded) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: ColorManager.whiteColor,
                    child: Icon(Icons.person, size: 40, color: ColorManager.greenColor), 
                  ),
                  accountName: Text(
                    state.name,
                    style: StyleManager.drawerHeaderNameStyle, 
                  ),
                  accountEmail: Text(
                    state.email,
                    style: StyleManager.drawerHeaderEmailStyle,
                  ),
                  decoration: const BoxDecoration(color: ColorManager.greenColor), 
                );
              }

              if (state is ProfileError) {
                return Container(
                  height: 175, 
                  color: ColorManager.greenColor, 
                  child: Center(
                    child: Text(
                      'Failed to load profile',
                      style: StyleManager.drawerHeaderNameStyle,
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),

          // Menu Items
          ListTile(
            leading: const Icon(Icons.eco_outlined, color: ColorManager.greenColor),
            title: Text('My Plants', style: StyleManager.drawerItemTitleStyle), 
            onTap: () {
              Navigator.pushNamed(context, '/yourPlantsScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.tips_and_updates_outlined, color: ColorManager.greenColor),
            title: Text('Care Tips', style: StyleManager.drawerItemTitleStyle),
            onTap: () {
              Navigator.pushNamed(context, '/care_tips');
            },
          ),
          ListTile(
            leading: const Icon(Icons.water_drop_outlined, color: ColorManager.greenColor),
            title: Text('Propagation Guide', style: StyleManager.drawerItemTitleStyle),
            onTap: () {
                Navigator.pushNamed(context, '/propagation_guide');
            },
          ),
          

          const Spacer(),
          const Divider(color: ColorManager.dividerColor), 

          ListTile(
            leading: const Icon(Icons.logout, color: ColorManager.errorRed),
            title: Text('Log Out', style: StyleManager.drawerLogoutTitleStyle), 
            onTap: () {
              //log out logic
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}