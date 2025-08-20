<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />

</head>
<body>

<h1>💬 ChatLy</h1>
<p>
Swift ile <b>Firebase tabanlı modern mesajlaşma uygulaması</b>. Kullanıcılar
<b>e-posta ve şifreyle kayıt/giriş</b> yapabilir, <b>gerçek zamanlı birebir mesajlaşma</b>
deneyimi yaşayabilir. Uygulama <b>MVVM mimarisi</b> ile geliştirildi ve
<b>tamamen programatik UIKit</b> kullanıldı.
</p>

<h2>🚀 Özellikler</h2>
<ul>
  <li>🔑 Firebase Authentication ile <b>kayıt & giriş</b></li>
  <li>💬 Firebase Firestore ile <b>gerçek zamanlı mesajlaşma</b></li>
  <li>👥 <b>Kullanıcı listesi</b> üzerinden sohbet başlatma</li>
  <li>🖼 <b>Profil resmi yükleme</b> (Firebase Storage)</li>
  <li>🧩 <b>MVVM mimarisi</b> ile temiz kod yapısı</li>
  <li>📱 <b>Storyboard’suz, tamamen programatik UIKit arayüz</b></li>
</ul>

<h2>🛠 Kullanılan Teknolojiler</h2>
<table border="1" cellpadding="6" cellspacing="0">
  <tr><th>Katman</th><th>Teknoloji</th></tr>
  <tr><td>Arayüz</td><td>UIKit (Programatik)</td></tr>
  <tr><td>Mimari</td><td>MVVM</td></tr>
  <tr><td>Backend</td><td>Firebase Authentication, Firestore, Storage</td></tr>
  <tr><td>Diğer</td><td>Swift 5, Xcode 16+, CocoaPods / Swift Package Manager</td></tr>
</table>

<h2>📸 Uygulama Ekran Görüntüleri</h2>

<div class="section">
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registerPage.png" width="260" />
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/loginPage.png" width="260" />
  <p>
    🔐 <b>Kayıt & Giriş</b><br/>
    ➡️ Yeni kullanıcılar kayıt olabilir, mevcut kullanıcılar e-posta & şifre ile giriş yapar.<br/>
    ➡️ Kullanıcı adı kontrolü ile benzersiz kullanıcı adı seçimi sağlanır.<br/>
    ➡️ Yanlış girişlerde anlamlı hata mesajları gösterilir.
  </p>
</div>
<br><br>
<div class="section">
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registrationProcess.png" width="260" />
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/ShowAllert.PNG" width="260" />
  <p>
    ⏳ <b>Kayıt & İşlem Süreci</b><br/>
    ➡️ <code>JGProgressHUD</code> ile işlem sırasında yükleniyor animasyonu.<br/>
    ➡️ Hata durumlarında <code>showAlert</code> ile kullanıcıya yönlendirici mesajlar.
  </p>
</div>
<br><br>
<div class="section">
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagePage.png" width="260" />
  <p>
    👥 <b>Sohbet Başlatma</b><br/>
    ➡️ Tüm kullanıcıların listelendiği ekran.<br/>
    ➡️ Kullanıcı seçilerek sohbet başlatılabilir.
  </p>
</div>
<br><br>
<div class="section">
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/lastMessage.png" width="260" />
  <p>
    📨 <b>Son Mesajlar</b><br/>
    ➡️ Kullanıcının en güncel sohbetleri hızlı erişim için listelenir.<br/>
    ➡️ Son mesajlar özet halinde gösterilir.
  </p>
</div>
<br><br>
<div class="section">
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagingScreen.PNG" width="260" />
  <p>
    💬 <b>Mesajlaşma Ekranı</b><br/>
    ➡️ Gerçek zamanlı birebir mesajlaşma.<br/>
    ➡️ Mesajlar baloncuk yapısıyla gönderilen/alınan olarak ayrılır.
  </p>
</div>
<br><br>
<div class="section">
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/profilePage.png" width="260" />
  <p>
    👤 <b>Profil</b><br/>
    ➡️ Kullanıcı bilgilerini görüntüleme.<br/>
    ➡️ Güvenli çıkış yapma özelliği.
  </p>
</div>

<h2>📂 Proje Yapısı (MVVM)</h2>
<pre>
ChatLy
 ┣ Models/         # Veri modelleri
 ┣ Views/          # Programatik UIKit görünümleri
 ┣ ViewModels/     # İş mantığı & veri bağlama
 ┣ Controllers/    # ViewController katmanı
 ┣ Services/       # Firebase servisleri (Auth, Firestore, Storage)
 ┗ Utils/          # Yardımcı fonksiyonlar (alert, loader vs.)
</pre>

<h2>🔧 Kurulum</h2>
<ol>
  <li>Repoyu klonla:
    <pre>git clone https://github.com/Mahmutakin99/ChatLy.git</pre>
  </li>
  <li>Firebase projesi oluştur ve <code>GoogleService-Info.plist</code> dosyasını projeye ekle.</li>
  <li>Bağımlılıkları yükle:<br>
    Swift Package Manager üzerinden gerekli Firebase, JGProgressHud ve SDWebİmage paketlerini ekle.
  </li><br>
  <li>Xcode’da projeyi aç ve çalıştır 🚀</li>
</ol>

<h2>🤝 Katkı</h2>
<p>
Katkıda bulunmak isterseniz lütfen <code>fork</code> alın, yeni branch açın ve <b>pull request</b> gönderin.
</p>

</body>
</html>
