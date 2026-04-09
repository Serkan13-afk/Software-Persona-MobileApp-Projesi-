import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:softwarepersona_mobileapp_projesi/models/Urunler.dart';

class Detaysayfa extends StatefulWidget {
  final Urunler urun;
  const Detaysayfa({super.key, required this.urun});

  @override
  State<Detaysayfa> createState() => _DetaysayfaState();
}

class _DetaysayfaState extends State<Detaysayfa> {
  // Kullanıcının seçeceği ürün adeti
  int _secilenAdet = 1;

  @override
  Widget build(BuildContext context) {
    final double yukseklik = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Arka planı hafif gri yapıyoruz ki beyaz kart öne çıksın
      extendBodyBehindAppBar: true, // AppBar'ı resmin üzerine bindirir (Modern görünüm)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black), // Geri butonu siyah olsun
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Ürün Görseli
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Container(
                height: yukseklik * 0.45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.urun.url), // Dinamik ürün resmi
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Ürün Detay Kartı
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: double.infinity,
                // Kartı hafifçe resmin üzerine doğru kaydırıyoruz
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Başlık ve Fiyat
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: Text(
                            widget.urun.ad,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "₺${widget.urun.fiyat}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan, // Ana sayfa ile uyumlu renk
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Yıldızlar / Değerlendirme
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const Icon(Icons.star_half, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "(${widget.urun.puan}/5 Değerlendirme)",
                          style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Ürün Açıklaması
                    const Text(
                      "Açıklama",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.urun.aciklama,
                      style: TextStyle(color: Colors.grey.shade700, height: 1.5, fontSize: 15),
                    ),
                    const SizedBox(height: 30),

                    // Adet Seçici
                    Row(
                      children: [
                        const Text(
                          "Adet: ",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_secilenAdet > 1) {
                                    setState(() {
                                      _secilenAdet--;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.remove, size: 20),
                              ),
                              Text(
                                "$_secilenAdet",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _secilenAdet++;
                                  });
                                },
                                icon: const Icon(Icons.add, size: 20),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // İçerik aşağı taşmasın diye ekstra boşluk
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Ekranın Altına Sabitlenmiş Sepete Ekle Butonu
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            // Basıldığında alttan bir bilgi mesajı çıksın
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("$_secilenAdet adet ürün sepete eklendi!"),
                backgroundColor: Colors.cyan.shade700,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: const Text(
            "Sepete Ekle",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}