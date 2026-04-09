class Urunler {
  final int id;
  final String ad;
  final String url;
  final String fiyat;
  final String aciklama;
  final double puan;

  Urunler({
    required this.id,
    required this.ad,
    required this.url,
    required this.fiyat,
    required this.aciklama,
    required this.puan,
  });

  factory Urunler.fromJson(Map<String, dynamic> json) {
    return Urunler(
      id: json['id'] ?? 0,
      ad: json['name'] ?? 'Bilinmeyen',
      url: json['image'] ?? '',
      fiyat: json['price']?.toString() ?? '',
      aciklama: json['description'] ?? '',
      puan: 4.5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': ad,
      'image': url,
      'price': fiyat,
      'description': aciklama,
    };
  }
}
