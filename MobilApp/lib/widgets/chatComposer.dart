import 'package:flutter/material.dart';

/*Bu widget, kullanıcıların bir mesaj yazıp göndermelerini sağlayan bir işleve sahiptir.
İçinde kullanıcının mesajını yazabileceği bir TextField ve gönderme eyleminin yapılmasını sağlayan bir Icon bulunur.*/

class ChatComposer extends StatelessWidget {
  //Bu controller, TextField içindeki metni takip etmek ve kontrol etmek için kullanılır.
  // Kullanıcı tarafından yazılan metni almak ve gönderme işleminden sonra metni temizlemek için kullanılır.
  final TextEditingController controller;

  //Bu callback fonksiyonu, kullanıcı gönderme ikonuna tıkladığında çağrılır.
  // Kullanıcının yazdığı mesajı almak ve sohbet ekranında işlemek için kullanılır.
  final Function(String) sendMessage;

  const ChatComposer(
      {required this.controller, required this.sendMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  //SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "ASbot'a soru sorun...",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        onSubmitted: (text) => sendMessage(
                            text), // Send icon'a basınca mesaj gönder
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              sendMessage(controller.text);
            },
            child: const Icon(
              Icons.send_outlined,
              color: Color(0xff0133A0),
            ),
          )
        ],
      ),
    );
  }
}
