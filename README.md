💬 ChatLy

Swift ile Firebase tabanlı modern mesajlaşma uygulaması.
Kullanıcılar e-posta ve şifreyle kayıt/giriş yapabilir, gerçek zamanlı birebir mesajlaşma deneyimi yaşayabilir. Uygulama MVVM mimarisi ile geliştirildi ve tamamen programatik UIKit kullanıldı.

🚀 Özellikler

🔑 Firebase Authentication ile kayıt & giriş
💬 Firebase Firestore ile gerçek zamanlı mesajlaşma
🧑‍🤝‍🧑 Kullanıcı listesi üzerinden sohbet başlatma
🖼 Profil resmi yükleme (Firebase Storage)
🧩 MVVM mimarisi ile temiz kod yapısı
📱 Storyboard’suz, tamamen programatik UIKit arayüz

🛠 Kullanılan Teknolojiler
| Katman  | Teknoloji                                             |
| ------- | ----------------------------------------------------- |
| Arayüz  | UIKit (Programatik)                                   |
| Mimari  | MVVM (Model-View-ViewModel)                           |
| Backend | Firebase Authentication, Firestore, Storage           |
| Diğer   | Swift 5, Xcode 16+,  Swift Package Manager            |


📸 Uygulama Ekran Görüntüleri
<div align="center">
🔐 Kayıt & Giriş
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registerPage.png" width="260" /> <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/loginPage.png" width="260" />

➡️ Yeni kullanıcılar kayıt olabilir, mevcut kullanıcılar e-posta & şifre ile giriş yapar.
➡️ Kullanıcı adı kontrolü ile benzersiz kullanıcı adı seçimi sağlanır.
➡️ Yanlış girişlerde anlamlı hata mesajları gösterilir.


⏳ Kayıt & İşlem Süreci
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registrationProcess.png" width="260" /> <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/ShowAllert.PNG" width="260" />

➡️ JGProgressHUD ile işlem sırasında yükleniyor animasyonu.
➡️ Hata durumlarında showAlert ile kullanıcıya yönlendirici mesajlar.


👥 Sohbet Başlatma
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagePage.png" width="260" />

➡️ Tüm kullanıcıların listelendiği ekran.
➡️ Kullanıcı seçilerek sohbet başlatılabilir.


📨 Son Mesajlar
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/lastMessage.png" width="260" />

➡️ Kullanıcının en güncel sohbetleri hızlı erişim için listelenir.
➡️ Son mesajlar özet halinde gösterilir.


💬 Mesajlaşma Ekranı
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagingScreen.PNG" width="260" />

➡️ Gerçek zamanlı birebir mesajlaşma.
➡️ Mesajlar baloncuk yapısıyla gönderilen/alınan olarak ayrılır.


👤 Profil
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/profilePage.png" width="260" />

➡️ Kullanıcı bilgilerini görüntüleme.
➡️ Güvenli çıkış yapma özelliği.

</div>


📂 Proje Yapısı (MVVM)
ChatLy
 ┣ Models/         # Veri modelleri
 ┣ Views/          # Programatik UIKit görünümleri
 ┣ ViewModels/     # İş mantığı & veri bağlama
 ┣ Controllers/    # ViewController katmanı
 ┣ Services/       # Firebase servisleri (Auth, Firestore, Storage)
 ┗ Utils/          # Yardımcı fonksiyonlar (alert, loader vs.)


🔧 Kurulum

1. Repoyu klonla:
  git clone https://github.com/Mahmutakin99/ChatLy.git

2. Firebase projesi oluştur ve GoogleService-Info.plist dosyasını projeye ekle.

3.Bağımlılıkları yükle (CocoaPods kullanıyorsan):
  pod install
  (veya Swift Package Manager üzerinden gerekli Firebase paketlerini ekle.)

4. Xcode’da projeyi aç ve çalıştır 🚀


🤝 Katkı
Katkıda bulunmak isterseniz lütfen fork alın, yeni branch açın ve pull request gönderin.
