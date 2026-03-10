import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_sync/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: const Text('Google Calendar'),
            subtitle: const Text('Connect to sync study sessions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calendar integration - add your API keys')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_rounded),
            title: const Text('Notion'),
            subtitle: const Text('Export plans to Notion'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notion integration - add your API key')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Sign Out'),
            onTap: () async {
              await context.read<AuthProvider>().signOut();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/onboarding');
              }
            },
          ),
        ],
      ),
    );
  }
}
