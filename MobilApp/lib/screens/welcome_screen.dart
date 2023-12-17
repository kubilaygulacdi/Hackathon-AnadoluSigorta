import 'package:as_chatbot/screens/chat_screen.dart';
import 'package:flutter/material.dart';

/* Bu sınıf hem anadolu sigorta app'i için mockup görevi görür hem de
 sağ altta bulunan butona tıklandığında chat ekranına yönlendirme sağlar. */

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/as_ss.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        backgroundColor: Color(0xff0133A0),
        child: const Icon(
          Icons.forum_outlined,
        ),
      ),
    );
  }
}
