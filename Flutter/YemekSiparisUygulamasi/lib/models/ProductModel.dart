class Product {
  int miktar;
  final int LOGICALREF;
  final String NAME, DESCRIPTION;
  final String IMAGE;
  final double RATING, PRICE;
  final bool ISPOPULAR;
  final String EXTRAINFO;
  final int CATEGORYREF;

  Product({
    required this.LOGICALREF,
    required this.IMAGE,
    required this.RATING,
    required this.ISPOPULAR,
    required this.NAME,
    required this.PRICE,
    required this.DESCRIPTION,
    required this.EXTRAINFO,
    required this.CATEGORYREF,
    this.miktar = 0,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    double parsedouble(dynamic value) {
      if (value is double) return value;
      if (value is int)
        return value.toDouble();
      else {
        return 0.0;
      }
    }

    bool parsebool(dynamic value) {
      if (value is bool) return value;
      if (value is String) return value.toLowerCase() == 'true';

      return false;
    }

    print("RATING veri türü: ${json['RATING'].runtimeType}");
    print("PRICE veri türü: ${json['PRICE'].runtimeType}");
    print("NAME veri türü: ${json['NAME'].runtimeType}");
    print("LOGICALREF veri türü: ${json['LOGICALREF'].runtimeType}");
    print("IMAGE veri türü: ${json['IMAGE'].runtimeType}");
    print("ISFAVORITE veri türü: ${json['ISFAVORITE'].runtimeType}");
    print("ISPOPULAR veri türü: ${json['ISPOPULAR'].runtimeType}");
    print("EXTRAINFO veri türü: ${json['EXTRAINFO'].runtimeType}");
    print("DESCRIPTION veri türü: ${json['DESCRIPTION'].runtimeType}");
    print("CATEGORYREF veri türü: ${json['CATEGORYREF'].runtimeType}");
    print("JSON VERİSİ :$json");

    return Product(
        LOGICALREF: json['LOGICALREF'] ?? 0,
        NAME: json['NAME'] ?? "İsim Yok",
        PRICE: parsedouble(json['PRICE']),
        DESCRIPTION: json['DESCRIPTION'] ?? "",
        IMAGE: json['IMAGE'] ?? "",
        RATING: parsedouble(json['RATING']),
        ISPOPULAR: parsebool(json['ISPOPULAR']),
        EXTRAINFO: json['EXTRAINFO'] ?? "",
        CATEGORYREF: json['CATEGORYREF'] ?? 0);
  }
  Map<String, dynamic> toJson() => {
        "LOGICALREF": LOGICALREF,
        "NAME": NAME,
        "PRICE": PRICE,
        "DESCRIPTION": DESCRIPTION,
        "IMAGE": IMAGE,
        "RATING": RATING,
        "ISPOPULAR": ISPOPULAR,
        "EXTRAINFO": EXTRAINFO,
        "CATEGORYREF": CATEGORYREF
      };
}

const String DESCRIPTION_mercimekCorba =
    "Günlük yemeklerinizi sıcak bir başlangıçla taçlandırmak için ideal olan lezzetli mercimek çorbamız, sağlıklı ve besleyici bir seçenektir. ";
const String mercimek_deger = '''
İçerikler:

Taze yeşilliklerle zenginleştirilmiş taze mercimek
Doğal sebze suyu
Özenle seçilmiş baharatlar

Hazırlanış:

Taze mercimeklerimiz özenle temizlenir ve yıkanır.
Tencerede sebzelerimizle birlikte kısık ateşte pişirilir.
Baharatlar eklenerek aroması zenginleştirilir.
Son olarak pürüzsüz kıvam alana kadar blender'dan geçirilir ve sıcak servis edilir.

Tüketim Önerisi:

Öğle veya akşam yemeği başlangıcında sıcak olarak servis edilir.
Yanında taze ekmek veya salata ile mükemmel bir uyum sağlar.

Sağlık Yararları:

Yüksek lif içeriği sindirim sağlığını destekler.
Protein açısından zengin yapısıyla enerji verir.
Vitamin ve minerallerle beslenme ihtiyacını karşılar.

Not:

Vegan ve vejetaryen dostudur.
Katkı maddesi içermez, doğal ve sağlıklı bir seçenektir.
''';

const String DESCRIPTION_karniyarik =
    "Karnıyarık, Türk mutfağının sevilen ve klasik yemeklerinden biridir.  ";
const String karniyarik_deger = '''
Malzemeler:

4 adet orta boy patlıcan
250 gram kıyma
1 büyük soğan
2 diş sarımsak
2 adet domates
2 adet yeşil biber
1 yemek kaşığı salça
3 yemek kaşığı zeytinyağı
Tuz, karabiber, kırmızı biber
Maydanoz (isteğe bağlı)
Hazırlanışı:

Patlıcanlar yıkanır ve alacalı soyulur. Ardından, kızartma işlemi için bir süre tuzlu suda bekletilir.
Kızgın yağda patlıcanlar hafifçe kızartılır ve kağıt havlu üzerine alınarak fazla yağı süzdürülür.
Bir tavada zeytinyağı ısıtılır, ince doğranmış soğan ve sarımsak eklenerek kavrulur. Ardından kıyma eklenir ve kavurma işlemine devam edilir.
Küçük doğranmış domatesler ve biberler eklenir. Salça, tuz ve baharatlar ilave edilerek karıştırılır ve kıymalı harç pişirilir.
Kızarmış patlıcanlar ortadan yarılarak bir fırın kabına dizilir. Hazırlanan kıymalı harç patlıcanların içine doldurulur.
Üzerine dilimlenmiş domates ve biberler yerleştirilir. Fırın kabına biraz su eklenir ve önceden ısıtılmış 180 derece fırında 20-25 dakika pişirilir.
Pişen karnıyarıklar sıcak olarak servis edilir. İsteğe bağlı olarak ince doğranmış maydanoz ile süslenebilir.
Karnıyarık, genellikle pilav ve cacık ile birlikte servis edilir. Hem doyurucu hem de lezzetli olan bu yemek, Türk sofralarının vazgeçilmezleri arasında yer alır. Afiyet olsun!
''';

const String DESCRIPTION_baklava =
    "Baklava, Türk mutfağının vazgeçilmez tatlılarından biridir. İnce yufkalar arasına serpiştirilen ceviz, fıstık veya fındıkla hazırlanan ve şerbetle tatlandırılan bu tatlı, özel günlerde ve bayramlarda sıklıkla tercih edilir.";
const String baklava_deger = '''
Malzemeler:

1 paket baklava yufkası
500 gram ceviz içi
250 gram tereyağı
2 su bardağı toz şeker
2 su bardağı su
1 dilim limon

Hazırlanışı:

Baklava yufkalarını tepsiye aralarına tereyağı sürerek üst üste dizin.
Her birkaç kat yufkanın arasına ceviz serpiştirin.
En üst kata tereyağı sürün ve baklavayı dilimleyin.
Önceden ısıtılmış 180 derece fırında altın rengi olana kadar pişirin.
Şerbet için şeker ve suyu kaynatın, limon dilimi ekleyin ve biraz daha kaynatın.
Fırından çıkan baklavanın üzerine ılık şerbeti dökün.
Baklava şerbeti çektikten sonra servis yapın.
Bu tarif, klasik baklavanın lezzetini ve dokusunu sunar. Afiyet olsun!
''';

const String DESCRIPTION_tavukSote =
    "Tavuk sote, pratik ve lezzetli bir yemektir. Tavuk etinin sebzelerle birlikte sotelenmesiyle hazırlanan bu yemek, hızlı ve doyurucu bir öğün arayanlar için ideal bir seçenektir.";
const String tavukSote_deger = '''
Malzemeler:

500 gram tavuk göğsü
2 adet soğan
2 adet biber
2 adet domates
3 yemek kaşığı zeytinyağı
Tuz, karabiber, kırmızı biber
Hazırlanışı:

Tavuk göğsü kuşbaşı doğranır ve bir tavada zeytinyağı ile sotelenir.
Doğranmış soğan ve biber eklenerek kavurmaya devam edilir.
Domatesler eklenir ve sebzeler yumuşayana kadar pişirilir.
Baharatlar eklenir ve karıştırılır.
Sıcak olarak servis edilir.
Bu tarif, pratik ve besleyici bir yemek arayanlar için idealdir. Afiyet olsun!
''';

const String DESCRIPTION_nohutYemegi =
    "Etli nohut yemeği, Türk mutfağının sevilen klasiklerinden biridir. Protein ve lif açısından zengin olan bu yemek, özellikle soğuk kış günlerinde sıklıkla tercih edilir.";
const String nohutYemegi_deger = '''
Malzemeler:

2 su bardağı nohut
250 gram kuşbaşı et
1 büyük soğan
2 diş sarımsak
2 yemek kaşığı domates salçası
3 yemek kaşığı zeytinyağı
Tuz, karabiber, kimyon
Hazırlanışı:

Nohutlar bir gece önceden ıslatılır.
Tencerede etler zeytinyağında kavrulur.
Soğan ve sarımsak eklenerek kavurmaya devam edilir.
Salça eklenir ve karıştırılır.
Nohutlar eklenir ve üzerini geçecek kadar su eklenir.
Baharatlar eklenir ve nohutlar yumuşayana kadar pişirilir.
Sıcak olarak servis edilir.
Bu tarif, besleyici ve lezzetli bir yemek arayanlar için idealdir. Afiyet olsun!
''';

const String DESCRIPTION_ekmekArasiKofte =
    "Ekmek arası köfte, hızlı ve lezzetli bir atıştırmalık veya öğle yemeği seçeneğidir. Izgara köftelerin taze ekmek arasında servis edilmesiyle hazırlanan bu yemek, yanında domates, biber ve soğan gibi garnitürlerle tamamlanır.";
const String ekmekArasiKofte_deger = '''
Malzemeler:

500 gram kıyma
1 soğan
2 diş sarımsak
1 dilim bayat ekmek içi
1 yumurta
Tuz, karabiber, kimyon
Ekmek, domates, biber, soğan
Hazırlanışı:

Kıyma, rendelenmiş soğan, sarımsak, bayat ekmek içi, yumurta ve baharatlar bir kapta yoğrulur.
Köfte şekli verilir ve ızgarada pişirilir.
Ekmek arasına köfteler konur, domates, biber ve soğan ile servis edilir.
Bu tarif, lezzetli ve doyurucu bir seçenek sunar. Afiyet olsun!
''';
