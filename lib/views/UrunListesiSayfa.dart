import 'package:flutter/material.dart';
import 'package:softwarepersona_mobileapp_projesi/models/Urunler.dart';
import 'package:softwarepersona_mobileapp_projesi/views/DetaySayfa.dart'; 

class Urunlistesisayfa extends StatefulWidget {
  // 'late' yerine 'final' kullanıyoruz. Dışarıdan gelen veriler final olmalıdır.
  final List<Urunler> tumurunler;

  // Constructor yapısını modern Flutter standartlarına uygun hale getirdik
  const Urunlistesisayfa({super.key, required this.tumurunler});

  @override
  State<Urunlistesisayfa> createState() => _UrunlistesisayfaState();
}

class _UrunlistesisayfaState extends State<Urunlistesisayfa> {
  // Kullanılmayan 'urunsayisi' değişkenini sildim, yerine widget.tumurunler.length kullanacağız.

  Widget urunListesi() {
    // Eğer liste boş gelirse ekranda boş bir sayfa yerine bilgi mesajı gösterelim
    if (widget.tumurunler.isEmpty) {
      return const Center(
        child: Text(
          "Gösterilecek ürün bulunamadı.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: widget.tumurunler.length,
      itemBuilder: (context, index) {
        // Tüm listeyi değil, sadece o an çizilecek olan index'teki ürünü alıyoruz
        var gelenUrun = widget.tumurunler[index];

        // Ekranda listelenecek her bir ürün için şık bir kart tasarımı
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage(gelenUrun.url), fit: BoxFit.cover),
              ),
              child: const SizedBox(),
            ),
            title: Text(
              gelenUrun.ad,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(gelenUrun.aciklama, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Text(
              gelenUrun.fiyat,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
                fontSize: 16,
              ),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  duration: Duration(milliseconds: 2000),
                  content: Text("Eklemeler yapılabilinir"),
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Detaysayfa(urun: gelenUrun)),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Genişlik ve yüksekliği şimdilik kullanmadığımız için sildim, kod kalabalığı yapmasın.

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // Arka planla kartlar arasında zıtlık yaratmak için
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Ürün Listesi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ListView'i Column içinde kullanırken mutlaka Expanded ile sarmalıyız
            // Aksi halde Flutter bu listenin ne kadar uzayacağını bilemez ve çöker.
            Expanded(child: urunListesi()),
          ],
        ),
      ),
    );
  }
}
