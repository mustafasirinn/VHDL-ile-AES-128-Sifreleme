<h1>FPGA Üzerinde VHDL ile AES-128 Şifreleme (1 Tur)</h1>
<h2><strong>1. AES ŞİFRELEME</strong></h2>
<p>AES (Rijndael-Gelişmiş Şifreleme Standardı) algoritması 128 bit veri bloklarını 128, 192, 256 bit anahtar seçenekleri ile şifreleyen simetrik şifreleme algoritmasıdır. Döngü sayısı anahtar genişliğine göre değişmektedir. 128 bit anahtar için 10 döngüde şifreleme yaparken 192 ve 256 bit anahtarlar için sırasıyla 12 ve 14 döngüde şifreleme yapmaktadır. AES-128 10 çevrimdir. İlk olarak Anahtarı Ekleme adımı gerçekleşir. Bu aşamadan sonra 10 çevrim gerçekleşir. Her çevrim sırasıyla Bayt Değiştirme, Satırları kaydırma, Sütunları karıştırma ve Tur Anahtarını Ekleme işlemlerinden oluşur. Son çevrim olan onuncu çevrimde Sütunları Karıştırma adımı uygulanmaz.</p>
<p><span style="color: rgb(0, 0, 0); font-family: &quot;Times New Roman&quot;; font-size: medium; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Aşağıdaki görselde AES-128 algoritmasının tamamı adımlar halinde gösterilmiştir.</span></p>
<p> resim gelecek </p>
<p>Bu repoda şifrelemeye ait ilk tur modellenmiş ve VHDL ile gerçeklenmiştir. İlk tur: 128 bitlik metnin Anahtar ile XOR’lanması, Byte Yer Değişimi işlemi, Satır Öteleme işlemi, Sütun Karıştırma İşlemi, Tur Anahtarı ile XOR’lama işleminden oluşur. (Tur anahtarı, girişte elimizdeki gizli anahtarın özel bir işlemden (anahtar üretici) geçerek ürettiği her turda bir önceki tur anahtarı ile üretilen anahtardır. Her turda birbirinden farklı değere sahiptir. Bu örnekte anahtar üretici yerine ilk tur anahtarı doğrudan kullanılmıştır.)&nbsp;</p>
<h2><strong>2. AES-128 ŞİFRELEMEDE İLK TURUN VHDL İLE GERÇEKLENMESİ</strong></h2>
<h3><strong>2.1 İŞLEM ADIMLARI</strong></h3>
<p>Ana kodun sade olmasını sağlamak için şifreleme için gerekli işlemler Component’ler ile tanımlanarak yapılmıştır. Tüm adımlara ait componentleri içeren ve AES-128 ilk tur şifrelemesini gerçekleştiren projemizin ana kodu (AESSifreleme.vhd) Bölüm 2.2’de verilmiştir.</p>
<h4><strong>2.1.1 METİN İLE ANAHTARIN XOR İŞLEMİNDEN GEÇMESİ</strong></h4>
<p>Şifrelenmemiş metnimiz ilk olarak Anahtar ile XOR işlemine girer. Bu işleme ait model aşağıdaki gibidir. (İşlem kodu &gt; anahtarekleme.vhd)</p>
<p>
  resim
</p>
<p>
  resim
</p>
<h4><strong>2.1.2 BYTE DEĞİŞTİRME İŞLEMİ</strong></h4>
<p>Byte değiştirme işleminde 128 bitlik metin 8’er bitlik parçalara ayrılarak 4x4 bir matris oluşturulur. Sonrasında her bir 8 bitlik değerin S Kutusundan geçirme işlemi uygulanır. Bu işlem 8 bitlik değerin S kutusundaki karşılığı ile değiştirilmesi demektir. Bu işlem için byte değiştirme işlemi içerisinde S Kutusu işlemi için component oluşturulmuş ve byte değiştirme işleminde component çağrılarak işlem yapılmıştır. (S Kutusu işleminin kodu &gt; skutusu.vhd),(byte değiştirme kodu &gt; bytedegistirme.vhd)</p>
<p>
  resim
</p>
<p>
  resim
</p>
<p>
  resim
</p>
<h4><strong>2.1.3 SATIR KAYDIRMA İŞLEMİ</strong></h4>
<p>Satırların ötelenmesi işleminde, 4x4 matrisimizin son üç satırındaki byte’lar sırasıyla 2. satır 1 kere, 3. satır 2 kere, 4. satır 3 kere olmak üzere çevrimli olarak kaydırılır. (İşlem için gerekli kod &gt; satirkaydirma.vhd)</p>
<p>
  resim
</p>
<h4><strong>2.1.4 SÜTUN KARIŞTIRMA İŞLEMİ</strong></h4>
<p>Şifreleme algoritmamızda karmaşıklığı sağlayan ve zorlu bir işlemdir. Sütun karıştırma işlemi, 4x4 matrisimiz üzerinde sütun sütun işlem yapar. İşlem aşağıdaki görselde görüldüğü gibidir.</p>
<p>
 resim
</p>
<p>
  resim
</p>
<p>Bu işlem için önce XOR işlemini yapacak bir sutunislem.vhd componentimizi yazıyoruz, ardından sutunkarma.vhd kodumuzda 128 bitlik verimizi 4x4 matris halinde componentte işleme sokuyoruz.</p>
<p>
 resim
</p>
<p>
 resim
</p>
<p>
  resim
</p>
<p>
  resim
</p>
<p>4x4 matrisimizle işlemlerimizi tamamladıktan sonra bir sonraki adımda kullanabilmek için elde ettiğimiz 16 tane 8 bitlik sonucu birleştirerek çıkış alıyoruz.</p>
<h4><strong>2.1.5 TUR ANAHTARI İLE TOPLAMA</strong></h4>
<p>Bu adımda ilk tur anahtarımızla sütun karıştırma işlemi sonucu elde ettiğimiz veriyi XOR işlemine sokarız. Bu işlem için ilk Bölüm 2.1.1’de yazılan anahtarekleme.vhd component’i kullanılacaktır.</p>
<p>
 resim
</p>
<h3><strong>2.2 AES-128 İLK TUR ŞİFRELEME ANA KODU</strong></h3>
<p>Component kodlarını yazdıktan sonra sistemimizin modeline uygun olarak ana kodumuzu (AESSifreleme.vhd) yazıyoruz. Sistemimizin modeli aşağıdaki gibidir.</p>
<p>
  resim
</p>
<p>Burada yer alan sinyaller ana kodda tanımlanmış ve işleme sokulmuştur. Modelde yer alan 5 adım için gerekli kodlar Bölüm 2.1’de sırasıyla verilmiştir.</p>
<p>Ana kodumuz; 3 giriş ve 1 çıkış değişkenine sahiptir. Girişlerden bir tanesi şifrelenmemiş metin (metin), bir tanesi şifreleme anahtarı (anahtar) ve sonuncusu ise ilk tur anahtarıdır (adimanahtari). Çıkışımız ise AES-128 algoritması ile 1 tur şifrelenmiş metindir (sifrelimetin). Tüm değişkenlerimiz 128 bit boyutundadır. &nbsp;Ayrıca baslangic, skutusinyal, satirksinyal, sifrelisinyal, sutunksinyal isimlerinde tanımladığımız 5 tane sinyalimiz bulunmaktadır.</p>
<h2><strong>3. SİSTEMİN SİMÜLASYON ÜZERİNDE TESTİ</strong></h2>
<p>Sisteme ait kodlar Quartus programında oluşturulmuştur.</p>
<p>ModelSim programı üzerinde kodumuz çalışır yapısı aşağıdaki giriş değişkenleri kullanılarak simüle edilmiştir. &nbsp;Çıkışını bildiğimiz girişleri deneyerek sistemimizin doğruluğunu test ediyoruz.</p>
<p>Sisteme verilen girişlerle çıkışta alınan şifrelenmiş metin çıktısı örneği (AES-128 İlk Tur) aşağıda verilmiş, sonuç kırmızı dörtgen içerisine alınmıştır.</p>
<p>
  resim
</p>
<p>Giriş değerlerimizin hem hex hem binary hali aşağıda belirtilmiştir.&nbsp;</p>
<p><strong>Girişler:</strong></p>
<p><em>metin&nbsp;</em></p>
<p>hx3243f6a8885a308d313198a2e0370734</p>
<p>bx00110010010000111111011010101000100010000101101000110000100011010011000100110001100110001010001011100000001101110000011100110100</p>
<p><em>anahtar</em></p>
<p>hx2b7e151628aed2a6abf7158809cf4f3c</p>
<p>bx00101011011111100001010100010110001010001010111011010010101001101010101111110111000101011000100000001001110011110100111100111100</p>
<p><em>adimanahtari</em></p>
<p>hxa0fafe1788542cb123a339392a6c7605</p>
<p>bx10100000111110101111111000010111100010000101010000101100101100010010001110100011001110010011100100101010011011000111011000000101</p>
<p>
  <br>
</p>
<p>Elde edilen çıktının hem hex hali hem de binary hali aşağıda verilmiştir.</p>
<p>
  resim
</p>
<p>
  resim
</p>
<p>
  <br>
</p>
<p>Proje gelişim aşamasındadır...</p>
<p>Üzerinde çalışılan yeni özellik:</p>
<p>&gt; Anahtar Üreteci</p>