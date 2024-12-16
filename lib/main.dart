import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_chat/providers/auth_provider.dart';
import 'package:smart_chat/providers/chat_provider.dart';
import 'package:smart_chat/providers/settings_provider.dart';
import 'package:smart_chat/providers/file_provider.dart';
import 'package:smart_chat/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => FileProvider()),
      ],
      child: MaterialApp(
        title: 'Smart Chat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00A884),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
```