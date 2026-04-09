class Urunler {
  final int id;
  final String ad;
  final String url;
  final double fiyat;
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
      id: json['id'],
      ad: json['ad'],
      url: json['url'],
      fiyat: (json['fiyat'] as num).toDouble(),
      aciklama: json['aciklama'],
      puan: (json['puan'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ad': ad,
      'url': url,
      'fiyat': fiyat,
      'aciklama': aciklama,
      'puan': puan,
    };
  }
}
