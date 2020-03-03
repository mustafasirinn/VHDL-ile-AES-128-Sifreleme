# FPGA Üzerinde VHDL ile AES-128 Şifreleme (1 Tur)
## 1. AES ŞİFRELEME
AES (Rijndael-Gelişmiş Şifreleme Standardı) algoritması 128 bit veri bloklarını 128, 192, 256 bit anahtar seçenekleri ile şifreleyen simetrik şifreleme algoritmasıdır. Döngü sayısı anahtar genişliğine göre değişmektedir. 128 bit anahtar için 10 döngüde şifreleme yaparken 192 ve 256 bit anahtarlar için sırasıyla 12 ve 14 döngüde şifreleme yapmaktadır. AES-128 10 çevrimdir. İlk olarak Anahtarı Ekleme adımı gerçekleşir. Bu aşamadan sonra 10 çevrim gerçekleşir. Her çevrim sırasıyla Bayt Değiştirme, Satırları kaydırma, Sütunları karıştırma ve Tur Anahtarını Ekleme işlemlerinden oluşur. Son çevrim olan onuncu çevrimde Sütunları Karıştırma adımı uygulanmaz.
Aşağıdaki görselde AES-128 algoritmasının tamamı adımlar halinde gösterilmiştir.
![1](https://sirinoloji.com/github/aes128-vhdl/1.png)
Bu repoda şifrelemeye ait ilk tur modellenmiş ve VHDL ile gerçeklenmiştir. İlk tur: 128 bitlik metnin Anahtar ile XOR’lanması, Byte Yer Değişimi işlemi, Satır Öteleme işlemi, Sütun Karıştırma İşlemi, Tur Anahtarı ile XOR’lama işleminden oluşur. (Tur anahtarı, girişte elimizdeki gizli anahtarın özel bir işlemden (anahtar üretici) geçerek ürettiği her turda bir önceki tur anahtarı ile üretilen anahtardır. Her turda birbirinden farklı değere sahiptir. Bu örnekte anahtar üretici yerine ilk tur anahtarı doğrudan kullanılmıştır.) 

## 2. AES-128 ŞİFRELEMEDE İLK TURUN VHDL İLE GERÇEKLENMESİ
### 2.1 İŞLEM ADIMLARI
Ana kodun sade olmasını sağlamak için şifreleme için gerekli işlemler Component’ler ile tanımlanarak yapılmıştır. Tüm adımlara ait componentleri içeren ve AES-128 ilk tur şifrelemesini gerçekleştiren projemizin ana kodu (AESSifreleme.vhd) Bölüm 2.2’de verilmiştir.

#### 2.1.1 METİN İLE ANAHTARIN XOR İŞLEMİNDEN GEÇMESİ
Şifrelenmemiş metnimiz ilk olarak Anahtar ile XOR işlemine girer. Bu işleme ait model aşağıdaki gibidir. (İşlem kodu > anahtarekleme.vhd)
![2](https://sirinoloji.com/github/aes128-vhdl/2.png)
![3](https://sirinoloji.com/github/aes128-vhdl/3.png)

#### 2.1.2 BYTE DEĞİŞTİRME İŞLEMİ
Byte değiştirme işleminde 128 bitlik metin 8’er bitlik parçalara ayrılarak 4x4 bir matris oluşturulur. Sonrasında her bir 8 bitlik değerin S Kutusundan geçirme işlemi uygulanır. Bu işlem 8 bitlik değerin S kutusundaki karşılığı ile değiştirilmesi demektir. Bu işlem için byte değiştirme işlemi içerisinde S Kutusu işlemi için component oluşturulmuş ve byte değiştirme işleminde component çağrılarak işlem yapılmıştır. (S Kutusu işleminin kodu > skutusu.vhd),(byte değiştirme kodu > bytedegistirme.vhd)
![4](https://sirinoloji.com/github/aes128-vhdl/4.png)
![5](https://sirinoloji.com/github/aes128-vhdl/5.png)
![6](https://sirinoloji.com/github/aes128-vhdl/6.png)

#### 2.1.3 SATIR KAYDIRMA İŞLEMİ
Satırların ötelenmesi işleminde, 4x4 matrisimizin son üç satırındaki byte’lar sırasıyla 2. satır 1 kere, 3. satır 2 kere, 4. satır 3 kere olmak üzere çevrimli olarak kaydırılır. (İşlem için gerekli kod > satirkaydirma.vhd)
![7](https://sirinoloji.com/github/aes128-vhdl/7.png)

#### 2.1.4 SÜTUN KARIŞTIRMA İŞLEMİ
Şifreleme algoritmamızda karmaşıklığı sağlayan ve zorlu bir işlemdir. Sütun karıştırma işlemi, 4x4 matrisimiz üzerinde sütun sütun işlem yapar. İşlem aşağıdaki görselde görüldüğü gibidir.
![8](https://sirinoloji.com/github/aes128-vhdl/8.png)
![9](https://sirinoloji.com/github/aes128-vhdl/9.png)

Bu işlem için önce XOR işlemini yapacak bir sutunislem.vhd componentimizi yazıyoruz, ardından sutunkarma.vhd kodumuzda 128 bitlik verimizi 4x4 matris halinde componentte işleme sokuyoruz.
![10](https://sirinoloji.com/github/aes128-vhdl/10.png)
![11](https://sirinoloji.com/github/aes128-vhdl/11.png)
![12](https://sirinoloji.com/github/aes128-vhdl/12.png)
![13](https://sirinoloji.com/github/aes128-vhdl/13.png)
4x4 matrisimizle işlemlerimizi tamamladıktan sonra bir sonraki adımda kullanabilmek için elde ettiğimiz 16 tane 8 bitlik sonucu birleştirerek çıkış alıyoruz.

#### 2.1.5 TUR ANAHTARI İLE TOPLAMA
Bu adımda ilk tur anahtarımızla sütun karıştırma işlemi sonucu elde ettiğimiz veriyi XOR işlemine sokarız. Bu işlem için ilk Bölüm 2.1.1’de yazılan anahtarekleme.vhd component’i kullanılacaktır.
![14](https://sirinoloji.com/github/aes128-vhdl/14.png)

### 2.2 AES-128 İLK TUR ŞİFRELEME ANA KODU
Component kodlarını yazdıktan sonra sistemimizin modeline uygun olarak ana kodumuzu (AESSifreleme.vhd) yazıyoruz. Sistemimizin modeli aşağıdaki gibidir.
![15](https://sirinoloji.com/github/aes128-vhdl/15.png)

Burada yer alan sinyaller ana kodda tanımlanmış ve işleme sokulmuştur. Modelde yer alan 5 adım için gerekli kodlar Bölüm 2.1’de sırasıyla verilmiştir.
Ana kodumuz; 3 giriş ve 1 çıkış değişkenine sahiptir. Girişlerden bir tanesi şifrelenmemiş metin (metin), bir tanesi şifreleme anahtarı (anahtar) ve sonuncusu ise ilk tur anahtarıdır (adimanahtari). Çıkışımız ise AES-128 algoritması ile 1 tur şifrelenmiş metindir (sifrelimetin). Tüm değişkenlerimiz 128 bit boyutundadır.  Ayrıca baslangic, skutusinyal, satirksinyal, sifrelisinyal, sutunksinyal isimlerinde tanımladığımız 5 tane sinyalimiz bulunmaktadır.

## 3. SİSTEMİN SİMÜLASYON ÜZERİNDE TESTİ
Sisteme ait kodlar **Quartus** programında oluşturulmuştur.
**ModelSim** programı üzerinde kodumuz çalışır yapısı aşağıdaki giriş değişkenleri kullanılarak simüle edilmiştir.  Çıkışını bildiğimiz girişleri deneyerek sistemimizin doğruluğunu test ediyoruz.
Sisteme verilen girişlerle çıkışta alınan şifrelenmiş metin çıktısı örneği (AES-128 İlk Tur) aşağıda verilmiş, sonuç kırmızı dörtgen içerisine alınmıştır.
![16](https://sirinoloji.com/github/aes128-vhdl/16.png)

Giriş değerlerimizin hem hex hem binary hali aşağıda belirtilmiştir. 

**Girişler:**

*metin* 
**hx**3243f6a8885a308d313198a2e0370734
**bx**00110010010000111111011010101000100010000101101000110000100011010011000100110001100110001010001011100000001101110000011100110100

*anahtar*
**hx**2b7e151628aed2a6abf7158809cf4f3c
**bx**00101011011111100001010100010110001010001010111011010010101001101010101111110111000101011000100000001001110011110100111100111100

*adimanahtari*
**hx**a0fafe1788542cb123a339392a6c7605
**bx**10100000111110101111111000010111100010000101010000101100101100010010001110100011001110010011100100101010011011000111011000000101

Elde edilen çıktının hem hex hali hem de binary hali aşağıda verilmiştir.
![17](https://sirinoloji.com/github/aes128-vhdl/17.png)
![18](https://sirinoloji.com/github/aes128-vhdl/18.png)

***Proje gelişim aşamasındadır...***

*Üzerinde çalışılan yeni özellik:*
> *Anahtar Üreteci*