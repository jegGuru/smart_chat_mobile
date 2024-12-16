```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_chat/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          if (settings.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: const Text('Enable GPT'),
                subtitle: const Text('Use GPT for enhanced responses'),
                value: settings.enableGpt,
                onChanged: (value) {
                  settings.updateSettings(enableGpt: value);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Language'),
                subtitle: Text(settings.language),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showLanguageDialog(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final languages = [
      'English',
      'Bahasa Indonesia',
      'Chinese',
      'Japanese',
      'Korean',
      'Tamil',
      'Thai',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages
                .map(
                  (lang) => ListTile(
                    title: Text(lang),
                    onTap: () {
                      context
                          .read<SettingsProvider>()
                          .updateSettings(language: lang);
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
```