import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:as_chatbot/widgets/chatComposer.dart';
import 'package:as_chatbot/api/function.dart';
import 'complaint_page.dart';

/*Bu sınıfın görevi chat ekranının tasarımı
ve sorulan soru ile gelen cevabı göstermek*/

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // _controller : kullanıcının mesaj yazma alanına girdiği metni yönetir
  final TextEditingController _controller = TextEditingController();

  //_messages : Gönderilen ve alınan mesajları bir sözlük yapısında (Map<String, dynamic>) saklar.
  // Mesajlar bu listeye eklenir ve ekranda gösterilir.
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  bool _showDefaultMessage = true;


  @override
  /*void initState() {
    super.initState();
    // Varsayılan başlangıç mesajını ekleyin
    _addDefaultMessage();
  }*/

 /* void _addDefaultMessage() {
      _messages.insert(0, {
        'text': RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: 'Size nasıl yardımcı olabilirim? '),
              TextSpan(
                text: 'Öneri ve şikayetleriniz için buraya tıklayın.',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ComplaintPage(),
                  ));
                },
              ),
            ],
          ),
        ),
        'sender': 'bot',
        'isRichText': true, // RichText olduğunu belirten bir flag ekleyin
      });
  }*/

  void _addDefaultMessage() {
    final defaultTextWidget = RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        children: [
          TextSpan(text: 'Size nasıl yardımcı olabilirim? '),
          TextSpan(
            text: 'Öneri ve şikayetleriniz için ',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: 'buraya tıklayın.',
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ComplaintPage(),
              ));
            },
          ),
        ],
      ),
    );

    setState(() {
      _messages.insert(0, {
        'text': defaultTextWidget,
        'sender': 'bot',
        'isRichText': true,
      });
    });
  }

  Widget _buildDefaultMessageBanner(BuildContext context) {
    return _showDefaultMessage ? Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.blue[200], // Banner rengi
        child: Stack(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                children: [
                  TextSpan(text: 'Size nasıl yardımcı olabilirim? '),
                  TextSpan(
                    text: 'Öneri ve şikayetleriniz için ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'buraya tıklayın.',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ComplaintPage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showDefaultMessage = false; // Mesajı kapat
                  });
                },
                child: Icon(Icons.close, color: Colors.black,size: 16.0,),
              ),
            ),
          ],
        ),
      ),
    ) : SizedBox.shrink(); // Eğer varsayılan mesaj gösterilmiyorsa, boş bir widget göster
  }



  //_sendMessage: Kullanıcı tarafından gönder butonuna basıldığında çağrılır.
  // Girilen metni _messages listesine ekler ve TextField'ı temizler.
  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {'text': text, 'sender': 'user'});
        _controller.clear();
      });
      // API'den cevap almak için _getApiResponse fonksiyonunu çağır
      _getApiResponse(text);
    }
  }


  void _getApiResponse(String message) async {
    setState(() {
      _isLoading = true;
    });
    String url = 'http://10.0.2.2:5000/question?query=$message';
    String apiResponse = await fetchdata(url);
    setState(() {
      _isLoading = false;
      _messages.insert(0, {'text': '$apiResponse', 'sender': 'bot'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff0133A0),
          //color: Color(0xff0133A0),
        ),
       // toolbarHeight: 100,
        backgroundColor: Colors.white,
       // backgroundColor: Color(0xff0133A0),
        //elevation: 0,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Image.asset(
              "assets/as_logo.png",
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      //backgroundColor: Color(0xff0133A0),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            _buildDefaultMessageBanner(context),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      //color: Color(0xff0133A0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        if (message['isRichText'] != null && message['isRichText'] == true) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: message['text'], // RichText widget'ını direkt olarak göster
                            ),
                          );
                        }
                        return Align(
                          alignment: message['sender'] == 'user'
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: message['sender'] == 'user'
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              message['text'],
                              style: TextStyle(
                                color: message['sender'] == 'user'
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_isLoading)
                    Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
            ChatComposer(controller: _controller, sendMessage: _sendMessage),
          ],
        ),
      ),
    );
  }


}
