class Product {
  /*Durum	Kullanım
Değerler opsiyonel olabilir	int? id; (nullable kullan)
Değerler kesinlikle gelmeli	required this.id, late int id kullanabilirsin
 */

  int? id;
  String? name;
  String? description;
  double? unitPrice;

  //Constructor oluşturalım
  /*Normalde aşağıdaki gibi oluşturuyoruz, dart dilinde bunu daha kısa yapabiliriz
Product(int id, String name, String description, double unitPRice)
{
  this.name=name;
  this.description=description;
  this.unitPrice=unitPrice;
}*/

  //kayıt işlemi için id vermemize gerek yok
  Product({this.name, this.description, this.unitPrice});
  //güncelleme işlemi için idli versiyon
  Product.whitId({thisId, this.name, this.description, this.unitPrice});
}
