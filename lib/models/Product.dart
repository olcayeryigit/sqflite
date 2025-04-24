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
  Product.whithId({this.id, this.name, this.description, this.unitPrice});

  //DB için Productı Map olarak döndüren fonksiyon
  //sqflite da ekleme yaparken id vermemeiz gerekmez, bu yüzden eğer id nulldan farklı ise id yi mapleriz, id null ise herhangi bir şey yapma deriz
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  /*
var urun=new Product(name:"Laptop",description:"Açıklama",unitPrice:500);
varMapUrun=urun.toMap();
*/

  Product.fromObject(dynamic o) {
    this.id = int.tryParse(
      o["id"],
    ); //gelen stringi int olarak çevirmemiz gerekir
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(
      o["unitPrice"],
    ); //gelen stringi double olarak çevirmemiz gerekir
  }
}
