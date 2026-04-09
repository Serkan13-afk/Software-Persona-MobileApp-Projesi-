import 'dart:convert';
import 'package:softwarepersona_mobileapp_projesi/models/Urunler.dart';

class UrunService {
  // Simüle edilmiş bir JSON veri kaynağı
  static const String dummyJsonData = '''
  [
    {
      "id": 1,
      "ad": "Premium Akıllı Saat",
      "url": "https://picsum.photos/id/11/600/600",
      "fiyat": 1250.0,
      "aciklama": "Günlük hayatınızı kolaylaştırmak için özel olarak tasarlandı. Sağlık takibi ve bildirimler entegre.",
      "puan": 4.5
    },
    {
      "id": 2,
      "ad": "Kablosuz Kulaklık PRO",
      "url": "https://picsum.photos/id/22/600/600",
      "fiyat": 750.0,
      "aciklama": "Gürültü engelleyici teknolojisi ile müzik keyfinizi ikiye katlayın.",
      "puan": 4.8
    },
    {
      "id": 3,
      "ad": "Minimalist Sırt Çantası",
      "url": "https://picsum.photos/id/33/600/600",
      "fiyat": 450.0,
      "aciklama": "Su geçirmez kumaş ve modern tasarımıyla şehre uygun.",
      "puan": 4.2
    },
    {
      "id": 4,
      "ad": "Taşınabilir Şarj Cihazı 10k",
      "url": "https://picsum.photos/id/44/600/600",
      "fiyat": 300.0,
      "aciklama": "Hızlı şarj destekli ince ve hafif tasarım.",
      "puan": 4.0
    },
    {
      "id": 5,
      "ad": "Mekanik Oyuncu Klavyesi",
      "url": "https://picsum.photos/id/55/600/600",
      "fiyat": 1500.0,
      "aciklama": "RGB aydınlatma ve hızlı tepkime süresi ile rakiplerinizin önüne geçin.",
      "puan": 4.9
    }
  ]
  ''';

  static Future<List<Urunler>> urunleriGetir() async {
    // Ağ isteği simülasyonu (1 saniye bekleme)
    await Future.delayed(const Duration(seconds: 1));

    List<dynamic> jsonList = jsonDecode(dummyJsonData);
    return jsonList.map((json) => Urunler.fromJson(json)).toList();
  }
}
