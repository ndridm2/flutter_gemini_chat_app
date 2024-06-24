import 'package:flutter/material.dart';
import 'package:gemini_chat_app/pages/splashscreen.dart';

const apiKey = 'AIzaSyBORmgOMU8vBQlVPqzlQliYmcxPwv8Y6ow';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}



