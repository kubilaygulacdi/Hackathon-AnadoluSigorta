import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplaintPage extends StatefulWidget {
  ComplaintPage({Key? key}) : super(key: key);

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {

  final TextEditingController complaintController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  bool isCheckboxChecked = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateController.text = "${DateTime.now().toLocal()}".split(' ')[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<http.Response> submitComplaint(
      Map<String, String> complaintData) async {
    String url = 'http://10.0.2.2:5000/complaint/submit';
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(complaintData),
    );
    return response;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: isCheckboxChecked
          ? () async {
              Map<String, String> complaintData = {
                'date': dateController.text,
                'name': nameController.text,
                'surname': surnameController.text,
                'no': phoneController.text,
                'email': emailController.text,
                'title': titleController.text,
                'complaint': complaintController.text,
              };

              http.Response response = await submitComplaint(complaintData);
              if (response.statusCode == 200) {
                print("Şikayet başarıyla gönderildi: ${response.body}");
                complaintController.clear();
                dateController.clear();
                nameController.clear();
                surnameController.clear();
                titleController.clear();
                emailController.clear();
                phoneController.clear();
              } else {
                print("Şikayet gönderilemedi: ${response.statusCode}");
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        primary: Color(0xff0133A0),
        shape: const StadiumBorder(),
        fixedSize: Size(150, 50),
      ),
      child: const Text("GÖNDER"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff0133A0),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Anadolu Sigorta Şikayet & Öneri',
          style: TextStyle(
            color: Color(0xff0133A0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              MyCustomInputField(
                hintText: 'İsim',
                controller: nameController,
              ),
              MyCustomInputField(
                hintText: 'Soyisim',
                controller: surnameController,
              ),
              MyCustomDatePicker(
                hintText: 'Tarih Seçiniz',
                controller: dateController,
                selectDate: _selectDate,
              ),
              MyCustomInputField(
                hintText: 'Telefon Numarası',
                controller: phoneController,
              ),
              MyCustomInputField(
                hintText: 'E-Posta Adresi',
                controller: emailController,
              ),
              MyCustomInputField(
                hintText: 'Şikayet & Öneri Konu Başlığı',
                controller: titleController,
              ),
              MyCustomTextArea(
                hintText: 'Şikayet & Öneri Giriniz',
                controller: complaintController,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: isCheckboxChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isCheckboxChecked = newValue!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Ürün, hizmet, kampanya ve anketler hakkında tarafımla iletişime geçilmesine '
                        've tarafıma bilgilendirme yapılmasına belirtilen esaslar çerçevesinde onay veriyorum.',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Image.asset(
                'assets/complaint_image-removebg-preview.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 12),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // Controller eklendi

  MyCustomInputField({
    required this.hintText,
    required this.controller, // Constructor'da controller parametresi eklendi
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller, // TextField içinde controller kullanımı
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: hintText,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class MyCustomTextArea extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  MyCustomTextArea({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class MyCustomDatePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Future<void> Function(BuildContext context) selectDate;

  MyCustomDatePicker({
    required this.hintText,
    required this.controller,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        readOnly: true,
        onTap: () => selectDate(context),
      ),
    );
  }
}
