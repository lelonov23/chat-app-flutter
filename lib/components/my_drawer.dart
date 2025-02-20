import 'package:app/services/auth/auth_service.dart';
import 'package:app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  void logout() async {
    final authService = AuthService();
    authService.signOut();
  }

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Icon(
                      Icons.message,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    title: Text("H O M E"),
                    leading: Icon(Icons.home),
                    iconColor: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    title: Text("S E T T I N G S"),
                    leading: Icon(Icons.settings),
                    iconColor: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => SettingsPage()
                        )
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ListTile(
                title: Text("L O G O U T"),
                leading: Icon(Icons.logout),
                iconColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.primary,
                onTap: logout,
              ),
            )
          ],
        ),
      ),
    );
  }
}