import 'package:flutter/material.dart';
import 'package:weather_bee/providers/auth_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                AuthProvider.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
