import 'package:flutter/material.dart';
import 'package:locale_db/data/dbHelper.dart';
import 'package:locale_db/models/Product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  //DbHelper instance
  var dbHelper = DbHelper();

  //TextEditingController
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Ürün Ekle")),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ), //burada daha önceden yapmış olduğumuz gibi form yapısı da kullanabiliriz, burada TextField kullanalım, TextEditingController ı görelim
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller:
          txtName, //yukarda TextEditingController tanımlayıp eşleştirelim
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması"),
      controller:
          txtDescription, //yukarda TextEditingController tanımlayıp eşleştirelim
    );
  }

  TextField buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Birim Fiyatı"),
      controller:
          txtUnitPrice, //yukarda TextEditingController tanımlayıp eşleştirelim
    );
  }

  OutlinedButton buildSaveButton() {
    return OutlinedButton(
      onPressed: () {
        addProduct();
      },
      child: Text("Ürün Ekle"),
    );
  }

  //ürün ekleme yapacağı için async olması gerekir
  void addProduct() async {
    //burada da bir db helper a ihtiyacım var, yukarıda DbHelper instance oluştururz
    var result = await dbHelper.insertProduct(
      Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(
          txtUnitPrice.text.toString(),
        ), //tip sorunu olmasın diye önce stringe sonra double a çevirdik
      ),
    ); //PRoduct constructor da product oluşturmada, withId olmayan constructor u kullanırız

    Navigator.pop(context, true);
  }
}
