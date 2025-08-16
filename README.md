# ChatLy

# 💬 Swift ile Firebase tabanlı mesajlaşma uygulaması

Swift ile tamamen kod tabanlı olarak geliştirilen, Firebase altyapısı kullanan modern bir mesajlaşma uygulaması.

Bu uygulama, kullanıcıların e-posta ve şifre ile kayıt olup giriş yapabileceği, diğer kullanıcılarla birebir gerçek zamanlı mesajlaşabileceği bir sistem sunar. Kodlama MVVM mimarisiyle düzenlenmiş, arayüzler storyboard yerine programatik olarak oluşturulmuştur.

---

## 🚀 Özellikler

- ✅ E-posta & Şifre ile kullanıcı kayıt ve giriş (Firebase Authentication)
- ✅ Gerçek zamanlı birebir mesajlaşma (Firebase Firestore)
- ✅ Kullanıcı listesi ve sohbet başlatma
- ✅ Profil resmi desteği (Firebase Storage)
- ✅ MVVM mimarisiyle temiz kod yapısı
- ✅ UIKit mimarisi ile tamamen programatik

---

## 🛠️ Kullanılan Teknolojiler

| Katman | Teknoloji |
|--------|-----------|
| Arayüz | UIKit (programatik) |
| Mimari | MVVM (Model-View-ViewModel) |
| Backend | Firebase Authentication, Cloud Firestore, Firebase Storage |
| Diğer | Swift 5, Xcode 16+, CocoaPods veya Swift Package Manager |


<div align="center">

  <!-- 1. Register -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registerPage.png" width="300" alt="Kayıt Ol (Register) ekranı - Kullanıcıların yeni hesap oluşturduğu ekran." />
  <br/><br/>Kayıt Olma (Register) Ekranı
Bu ekran, uygulamaya yeni kullanıcıların güvenli bir şekilde kayıt olmasını sağlamaktadır. Kullanıcıdan e-posta, şifre ve diğer gerekli bilgiler alınarak sistemde bir hesap oluşturulur. Ayrıca kullanıcı adı alanında özel bir kontrol mekanizması bulunmaktadır. Bu mekanizma sayesinde, seçilen kullanıcı adı sistemde mevcut verilerle karşılaştırılır ve yalnızca size ait olacak benzersiz bir kullanıcı adı belirlemenize imkân tanır. Böylece hem güvenlik hem de kişiselleştirme açısından kullanıcı deneyimi artırılmış olur.
  <br/><br/>

  <!-- 2. Login -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/loginPage.png" width="300" alt="Giriş (Login) ekranı - Kayıtlı kullanıcıların giriş yaptığı ekran." />
  <br/><br/>Giriş Yapma (Login) Ekranı
Bu ekran, mevcut kullanıcıların daha önce oluşturdukları hesap bilgileriyle sisteme giriş yapmasını sağlar. Kullanıcı, kayıt sırasında kullandığı e-posta ve şifre bilgilerini girerek sisteme erişir. Yanlış girişlerde veya eksik bilgi girildiğinde, kullanıcıya hatanın neden kaynaklandığını anlatan bir uyarı gösterilir. Başarılı giriş sonrası kullanıcı sohbet ekranına yönlendirilir. Bu ekran, kullanıcı deneyimi açısından uygulamanın en kritik kısımlarından biridir çünkü kullanıcıların uygulamaya erişimi bu adımda gerçekleşir.
  <br/><br/>

  <!-- 3. JGProgressHUD -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/registrationProcess.png" width="300" alt="JGProgressHUD ekranı - Kayıt veya giriş sırasında yükleniyor göstergesi." />
  <br/><br/>JGProgressHUD (Yükleniyor Göstergesi)
Arka planda JGProgressHUD bileşeni kullanılarak, kayıt işleminin devam ettiği görsel olarak kullanıcıya bildirilir. Böylece kullanıcı, işlemin çalıştığını ve uygulamanın donmadığını anlayabilir. Başarılı bir kayıt sonrası kullanıcı sisteme yönlendirilir; hata durumunda ise kullanıcıya bilgilendirici bir uyarı gösterilir.
  <br/><br/>

  <!-- 4. ShowAlert -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/ShowAllert.PNG" width="300" alt="ShowAlert ekranı - Kullanıcıya hata mesajının gösterildiği ekran." />
  <br/><br/>Hata Bildirimi (ShowAlert Kullanımı)
Uygulamada, kullanıcıların yaptığı işlemler sırasında ortaya çıkabilecek hataların anlaşılır bir şekilde iletilmesi için showAlert yöntemi kullanılmaktadır. Bu yöntem sayesinde, sistemde oluşan hata durumları doğrudan ekrana yansıtılarak kullanıcıya bildirilir. Örneğin, yanlış bir e-posta formatı girildiğinde, şifre alanı boş bırakıldığında ya da kullanıcı adı zaten alınmışsa, uygulama bu hataları tespit eder ve ilgili mesajı bir uyarı penceresi (alert) aracılığıyla kullanıcıya gösterir.

Bu yaklaşım, kullanıcıların hatalarını kolayca fark edip düzeltmesini sağlarken aynı zamanda uygulamanın güvenilirliğini ve kullanıcı deneyimini artırır. Kullanıcı, hangi adımı yanlış yaptığını açık bir mesaj ile öğrenir ve tekrar deneme fırsatına sahip olur. Böylece uygulama sadece hata ayıklamak için değil, aynı zamanda kullanıcıyı yönlendiren bir rehber gibi de işlev görür.
  <br/><br/>

  <!-- 5. Kullanıcı Listesi -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagePage.png" width="300" alt="Kullanıcı listesi ekranı - Mevcut kullanıcılarla sohbet başlatma ekranı." />
  <br/><br/>Sohbet Başlatma (Kullanıcı Listesi) Ekranı
Bu ekranda, sistemde kayıtlı diğer kullanıcıların bilgileri listelenir. Kullanıcı buradan istediği kişiyi seçerek sohbet başlatabilir. Liste düzenli bir şekilde gösterilir ve her kullanıcı seçilebilir bir alan olarak sunulur. Bu ekran, uygulamanın sosyal etkileşimi başlatan ilk noktası olduğu için kullanıcı dostu bir tasarıma sahiptir.
  <br/><br/>

  <!-- 6. En Son Mesajlar -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/lastMessage.png" width="300" alt="En son mesajlar ekranı - Kullanıcının son sohbetlerini gösteren ekran." />
  <br/><br/>Son Mesajlar (Ana Sohbet Listesi) Ekranı
Bu ekranda, kullanıcının daha önce sohbet ettiği kişilere ait son mesajlar listelenir. Böylece kullanıcı, en güncel sohbetlerine hızlıca erişebilir. Mesajlar karşı tarafın adıyla birlikte özet şeklinde gösterilir ve üzerine tıklanınca mesajlaşma ekranına yönlendirilir. Bu ekran, mesajlaşma uygulamalarında kullanıcıların en çok vakit geçirdiği ve düzenli olarak kontrol ettiği yerdir.
  <br/><br/>

  <!-- 7. Mesajlaşma Ekranı -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/messagingScreen.PNG" width="300" alt="Mesajlaşma ekranı - Kullanıcıların birebir sohbet ettiği ekran." />
  <br/><br/>Mesajlaşma (Chat) Ekranı
Bu ekran, iki kullanıcı arasında gerçek zamanlı mesajlaşmayı sağlar. Mesajlar baloncuklar şeklinde düzenlenmiştir ve gönderilen/alınan mesajlar görsel olarak ayrılır. Kullanıcı yeni mesaj yazabilir, gönderebilir ve karşı taraftan gelen yanıtları anlık olarak görebilir. Bu ekran uygulamanın en temel işlevini, yani iletişimi gerçekleştirdiği için teknik açıdan performanslı ve sade bir şekilde geliştirilmiştir.
  <br/><br/>

  <!-- 8. Profil -->
  <img src="https://github.com/Mahmutakin99/ChatLy/blob/main/ChatLy/Photos/profilePage.png" width="300" alt="Profil ekranı - Kullanıcı bilgilerini görüntüleme ve çıkış yapma ekranı." />
  <br/><br/>Profil Ekranı
Profil ekranında, kullanıcının kendi bilgilerini görüntülemesi ve uygulamadan çıkış yapabilmesi sağlanır. Burada kullanıcının kayıtlı adı ve kullanıcı adı gibi temel bilgiler yer alır. Ayrıca kullanıcı çıkış butonuna basarak uygulamadan güvenli bir şekilde ayrılabilir. Bu ekran, kişiselleştirme ve güvenlik açısından önemlidir çünkü kullanıcı kendi bilgilerini kontrol edebilir ve istediği zaman oturumunu sonlandırabilir.

</div>
