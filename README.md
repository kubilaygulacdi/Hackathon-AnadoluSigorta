# ASbot - Şikayet & Öneri Sistemi 

🤩 Anadolu Sigorta sponsorluğundaki Hack Series'in ilk Hackathonu kapsamında kullanıcıların sorularına hızlı ve etkili bir şekilde cevap verebilen bir chatbot geliştirdik. Bu chatbot, kullanıcıların sigorta ile ilgili çeşitli konularda bilgi edinmelerine yardımcı olacak şekilde tasarlandı. Ayrıca, kullanıcı deneyimini daha da zenginleştirmek amacıyla, hem uygulama menüsünden hem de chatbot arayüzünden erişilebilen bir şikayet ve öneri sistemi entegre ettik. Bu sistem, kullanıcılara herhangi bir sorunları veya önerileri olduğunda doğrudan geri bildirimde bulunma imkanı sunuyor. Projemizin amacı, kullanıcıların ihtiyaçlarına hızlı ve verimli bir şekilde yanıt vermek ve onlara kapsamlı bir destek sağlamak.

Contributors

[@kubilaygulacdi](https://github.com/kubilaygulacdi) - Data Scientist

[@aydozy](https://github.com/aydozy) - Mobile Developer

## Kullanılan Teknolojiler
- **Web**: Streamlit
- **Mobil**: Dart & Flutter
- **Generative AI**: Langchain, OpenAI
- **Backend**: Python, MongoDB, ChromaDB, Flask

## Asbot - Şikayet & Öneri Gen AI Özellikler
## Asbot - Şikayet & Öneri Backend Özellikler

## Asbot - Şikayet & Öneri Mobil Özellikler

**HTTP GET İsteği**:
- Verilen bir URL'ye HTTP GET isteği gönderir.
- http paketini kullanarak ağ isteklerini gerçekleştirir.
- Asenkron bir işlevdir ve HTTP isteğinin yanıtını bekler.

**ChatScreen Sınıfı**:
- Uygulamanın ana chat ekranını yönetir.
- Kullanıcı mesajlarını yönetmek için `TextEditingController` kullanır.
- Gönderilen ve alınan mesajları liste şeklinde saklar.
- Kullanıcıya başlangıçta varsayılan bir mesaj gösterir.
- Kullanıcıdan gelen mesajları alıp, API aracılığıyla cevaplarını getirir.

**ComplaintPage Sınıfı**:
- Şikayet ve öneri formu için ayrı bir sayfa oluşturur.
- Kullanıcıdan çeşitli bilgiler almak için `TextEditingController` kullanır.
- Tarih seçimi için bir DatePicker entegre edilmiştir.
- Şikayet verisini API'ye göndermek için submitComplaint fonksiyonunu kullanır.

**WelcomeScreen Sınıfı**:
- Uygulamanın karşılama ekranını oluşturur.
- Bir arka plan resmi gösterir (mockup olarak görev alır) ve chat ekranına geçiş için bir buton içerir.

## ASbot Uygulama Görüntüsü

  <img src="https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/7db253d6-3b1b-4f0d-b676-20746047a82a" width="250" height="500">

## Şikayet & Öneri Sistemi Uygulama Görüntüsü

<img src="https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/191c020f-b26d-4a43-8e1b-b295af6e19c0" width="250" height="500">

## ASbot Demo

[![Video Önizleme](https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/your-preview-image.jpg)](https://github.com/kubilaygulacdi/Hackathon-AnadoluSigorta/assets/104395137/ac43619a-863f-4229-bbac-950aece9283f)




