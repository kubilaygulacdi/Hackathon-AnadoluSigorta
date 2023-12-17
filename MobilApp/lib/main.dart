import 'package:as_chatbot/screens/complaint_page.dart';
import 'package:as_chatbot/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

// Bu sınıf, MaterialApp widget'ını kullanarak uygulamanın temel yapılandırmasını sağlar
// ve uygulamanın başlangıç ekranı olarak WelcomeScreen widget'ını ayarlar.
// 'debugShowCheckedModeBanner: false' ayarı, geliştirme modu etiketini gizler.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}




