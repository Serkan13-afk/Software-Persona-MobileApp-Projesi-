import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:softwarepersona_mobileapp_projesi/models/Urunler.dart';

class UrunService {
  static const String apiUrl = 'https://wantapi.com/products.php';

  static Future<List<Urunler>> urunleriGetir() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['status'] == 'success') {
          List<dynamic> jsonList = decodedData['data'];
          return jsonList.map((json) => Urunler.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      // Hata durumunda boş liste dönüyoruz
      return [];
    }
  }
}
