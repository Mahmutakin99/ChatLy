💬 ChatLy

Swift ile Firebase tabanlı modern mesajlaşma uygulaması.
Kullanıcılar e-posta ve şifreyle kayıt/giriş yapabilir, gerçek zamanlı birebir mesajlaşma deneyimi yaşayabilir. Uygulama MVVM mimarisi ile geliştirildi ve tamamen programatik UIKit kullanıldı.
<br><br>
🚀 Özellikler

🔑 Firebase Authentication ile kayıt & giriş
💬 Firebase Firestore ile gerçek zamanlı mesajlaşma
🧑‍🤝‍🧑 Kullanıcı listesi üzerinden sohbet başlatma
🖼 Profil resmi yükleme (Firebase Storage)
🧩 MVVM mimarisi ile temiz kod yapısı
📱 Storyboard’suz, tamamen programatik UIKit arayüz

<br><br>
🛠 Kullanılan Teknolojiler
| Katman  | Teknoloji                                             |
| ------- | ----------------------------------------------------- |
| Arayüz  | UIKit (Programatik)                                   |
| Mimari  | MVVM (Model-View-ViewModel)                           |
| Backend | Firebase Authentication, Firestore, Storage           |
| Diğer   | Swift 5, Xcode 16+,  Swift Package Manager            |

<br><br>
📸 Uygulama Ekran Görüntüleri
<div align="center">
🔐 Kayıt & Giriş
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registerPage.png" width="260" /> <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/loginPage.png" width="260" /><br>

➡️ Yeni kullanıcılar kayıt olabilir, mevcut kullanıcılar e-posta & şifre ile giriş yapar.
➡️ Kullanıcı adı kontrolü ile benzersiz kullanıcı adı seçimi sağlanır.
➡️ Yanlış girişlerde anlamlı hata mesajları gösterilir.

<br><br>
⏳ Kayıt & İşlem Süreci
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registrationProcess.png" width="260" /> <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/ShowAllert.PNG" width="260" /><br>

➡️ JGProgressHUD ile işlem sırasında yükleniyor animasyonu.
➡️ Hata durumlarında showAlert ile kullanıcıya yönlendirici mesajlar.

<br><br>
👥 Sohbet Başlatma
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagePage.png" width="260" /><br>

➡️ Tüm kullanıcıların listelendiği ekran.
➡️ Kullanıcı seçilerek sohbet başlatılabilir.

<br><br>
📨 Son Mesajlar
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/lastMessage.png" width="260" /><br>

➡️ Kullanıcının en güncel sohbetleri hızlı erişim için listelenir.
➡️ Son mesajlar özet halinde gösterilir.

<br><br>
💬 Mesajlaşma Ekranı
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagingScreen.PNG" width="260" /><br>

➡️ Gerçek zamanlı birebir mesajlaşma.
➡️ Mesajlar baloncuk yapısıyla gönderilen/alınan olarak ayrılır.

<br><br>
👤 Profil
<img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/profilePage.png" width="260" /><br>

➡️ Kullanıcı bilgilerini görüntüleme.
➡️ Güvenli çıkış yapma özelliği.

</div>

<br><br>
📂 Proje Yapısı (MVVM)<br>
ChatLy<br>
 ┣ Models/         # Veri modelleri<br>
 ┣ Views/          # Programatik UIKit görünümleri<br>
 ┣ ViewModels/     # İş mantığı & veri bağlama<br>
 ┣ Controllers/    # ViewController katmanı<br>
 ┣ Services/       # Firebase servisleri (Auth, Firestore, Storage)<br>
 ┗ Utils/          # Yardımcı fonksiyonlar (alert, loader vs.)<br>

<br><br>
🔧 Kurulum

1. Repoyu klonla:<br>
  git clone https://github.com/Mahmutakin99/ChatLy.git
<br>
2. Firebase projesi oluştur ve GoogleService-Info.plist dosyasını projeye ekle.
<br><br>
3.Bağımlılıkları yükle (CocoaPods kullanıyorsan):<br>
  pod install<br>
veya Swift Package Manager üzerinden gerekli Firebase paketlerini ekle.
<br>

4. Xcode’da projeyi aç ve çalıştır 🚀


🤝 Katkı<br>
Katkıda bulunmak isterseniz lütfen fork alın, yeni branch açın ve pull request gönderin.
