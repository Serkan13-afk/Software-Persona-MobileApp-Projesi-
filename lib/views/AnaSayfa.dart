import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:softwarepersona_mobileapp_projesi/views/DetaySayfa.dart';
import 'package:softwarepersona_mobileapp_projesi/views/UrunListesiSayfa.dart';
import 'package:softwarepersona_mobileapp_projesi/models/Urunler.dart';
import 'package:softwarepersona_mobileapp_projesi/services/urun_service.dart';
class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  // late keyword'üne gerek yok, değişkeni final yapmak daha güvenlidir.
  final TextEditingController textEditingController = TextEditingController();
  List<Urunler> _tumUrunler = [];
  List<Urunler> _filtrelenmisUrunler = [];
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _verileriYukle();
  }

  Future<void> _verileriYukle() async {
    final urunler = await UrunService.urunleriGetir();
    setState(() {
      _tumUrunler = urunler;
      _filtrelenmisUrunler = urunler;
      _yukleniyor = false;
    });
  }

  // Bellek sızıntılarını önlemek için controller'ı dispose ediyoruz.
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  // Arama çubuğu biraz daha estetik hale getirildi
  Widget searchBar(double g, double y) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        controller: textEditingController,
        onChanged: (deger) {
          setState(() {
            _filtrelenmisUrunler = _tumUrunler
                .where((urun) => urun.ad.toLowerCase().contains(deger.toLowerCase()))
                .toList();
          });
        },
        decoration: InputDecoration(
          hintText: "Ürün ara...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  // GridView'ın Column içinde çalışabilmesi için Expanded ile sarılması gerekir (Aşağıda build içinde yapıldı)
  Widget tumUrunler() {
    return _yukleniyor 
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 4,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _filtrelenmisUrunler.length,
      itemBuilder: (context, index) {
        var urun = _filtrelenmisUrunler[index];
        return FadeInRight(
          delay: Duration(milliseconds: index * 100),
          child: InkWell(
            onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Detaysayfa(urun: urun)),
               );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(urun.url),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                   width: double.infinity,
                   padding: const EdgeInsets.all(8),
                   decoration: BoxDecoration(
                     color: Colors.black54,
                     borderRadius: const BorderRadius.only(
                       bottomLeft: Radius.circular(15), 
                       bottomRight: Radius.circular(15)
                     )
                   ),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text(urun.ad, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                       Text("₺${urun.fiyat}", style: const TextStyle(color: Colors.cyanAccent, fontSize: 12)),
                     ]
                   )
                )
              )
            ),
          ),
        );
      },
    );
  }

  Widget popullerCard(double g, double y) {
    if (_tumUrunler.isEmpty) return const SizedBox();
    var urun = _tumUrunler.first;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detaysayfa(urun: urun)),
        );
      },
      child: FadeInDown(
        duration: const Duration(milliseconds: 300),
        child: Container(
          height: y * 0.18, // Yüksekliği biraz optimize ettim
          width: g * 0.9, // Genişliği ekrana daha uygun hale getirdim
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38, // Gölgelendirme rengi yumuşatıldı
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            // Hata vermemesi için örnek bir resim eklendi
            image: DecorationImage(
              image: NetworkImage(urun.url),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black38,
                BlendMode.darken,
              ), // Yazı okunsun diye resmi biraz kararttık
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Sola hizalı yaptık
                  children: const [
                    Text(
                      "Günün Flaş Ürünü",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        // Arka plan resimli olduğu için beyaz yazı daha iyi durur
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "İncelemek için tıkla",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_outlined,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double genislik = MediaQuery.of(context).size.width;
    final double yukseklik = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Arka plan rengi belirledik
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text("Serkan"),
              accountEmail: Text("serkan@ornek.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.cyan, size: 40),
              ),
              decoration: BoxDecoration(color: Colors.cyan),
            ),
            // Buraya ListTile ile diğer menü elemanlarını ekleyebilirsin
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        // PreferredSize yerine bunu kullanmak daha pratiktir
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Çekmece (Drawer) ikonu rengi
        centerTitle: true,
        // Başlığı ortala
        title: const Text(
          "Ana Sayfa",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.cyan,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_2_outlined,
                color: Colors.white,
                size: 30, // İkon boyutu biraz küçültüldü ki taşmasın
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Tüm elemanları sola hizalar
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              "Hoş Geldin,\nSerkan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Yazdığın ama eklemediğin arama çubuğu
          searchBar(genislik, yukseklik),

          const SizedBox(height: 15),

          // Flaş ürün kartı (Center ile ortaladık)
          Center(child: popullerCard(genislik, yukseklik)),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Tüm Ürünler",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Urunlistesisayfa(tumurunler: _tumUrunler)),
                    );
                  },
                  child: Text(
                    "Tüm ürünleri listele",
                    style: TextStyle(color: Colors.black,fontSize: 17),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Yazdığın ama eklemediğin ürünler listesi (Kalan tüm boşluğu kaplaması için Expanded kullanıldı)
          Expanded(child: tumUrunler()),
        ],
      ),
    );
  }
}
