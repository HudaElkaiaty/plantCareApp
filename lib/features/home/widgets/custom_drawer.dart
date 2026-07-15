import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare/features/profile/cubit/profile_cubit.dart';
import 'package:plantcare/features/profile/cubit/states.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Container(
                  height: 175,
                  color: Colors.green[700],
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }

              if (state is ProfileLoaded) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.green),
                  ),
                  accountName: Text(
                    state.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(state.email),
                  decoration: BoxDecoration(color: Colors.green[700]),
                );
              }

              if (state is ProfileError) {
                return Container(
                  height: 175,
                  color: Colors.green[700],
                  child: const Center(
                    child: Text(
                      'Failed to load profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),

          // Menu Items
          ListTile(
            leading: const Icon(
              Icons.tips_and_updates_outlined,
              color: Colors.green,
            ),
            title: const Text('Care Tips'),
            onTap: () {
              // Navigate to Care Tips Screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.water_drop_outlined, color: Colors.green),
            title: const Text('Propagation Guide'),
            onTap: () {
              // Navigate to Propagation guide Screen
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.green,
            ),
            title: const Text('Watering Reminders'),
            onTap: () {
              // Navigate to Watering Reminders Screen
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.manage_accounts_outlined,
              color: Colors.green,
            ),
            title: const Text('Account Settings'),
            onTap: () {
              // Navigate to account settings Screen
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.green),
            title: const Text('About App'),
            onTap: () {
              // Navigate to about app Screen
            },
          ),

          const Spacer(), 
          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
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
