//veri yönetimi yapacağımız için StatefulWidget olarak oluşturuyoruz
//state yönetimi için override createstate
//state döndüren bir widget yazalım (return _ProductListState();)
import 'package:flutter/material.dart';
import 'package:locale_db/data/dbHelper.dart';
import 'package:locale_db/models/Product.dart';
import 'package:locale_db/screens/product_add.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  //Bu classıb state yönetimi yapabilmesi (SetState) için extends State sınıfı olması gerekir, override build
  //Scaffoldla bu işlemi yapalım
  //bodyde buildProductListte ürün listeleme işlemlerimizi yapalım
  // buildProductList() bir listview dönderecek, kod okunurluğu için döndürdüğü classı yazarız->ListView buildProductList() {}, bir şey yazmasak da sorun olmaz ama kod okunurluğu açısından bu yazım iyi
  //1-DbHelper
  //DbHelper dbHelper=new DbHelper(); bunun yerine aşağıdaki gibi yazabiliriz
  var dbHelper =
      DbHelper(); //burada dbHelper ı instance oluşturarak kurduk ama aslında, statik fabrika deseni alyapılarıyla oluşturmak gerekir, ancak biz şimdi temeli öğrenmek için böyle yapıyoruz
  List<Product> products = [];
  //listviewde gezebilmek için counter
  int productCount = 0;
  //2-buildProductList te listview i yapalım
  //3-DBHelperdan productlisti dolduralım, bunun için initState() fonksiyonunu kullanırız
  @override
  void initState() {
    //ürünleri burada set edebilirim, state i başlatabilirim, setState gibi
    //dbHelper.getProducts(); bir Future dönderir

    ///ürünleri getirmek için method
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ürün Listesi")),
      body: buildProductList(),
      //Ürün eklemek için scaffoldun floatingactionbutton ını kullanırız
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  //**2-buildProductList te listview i dolduralım
  //burada product dönderebilmek için yukarda **1-DbHelper a ihtiyacımız var
  ListView buildProductList() {
    //print(products); deneme
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.cyan,
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text("P"),
            ),
            title: Text(this.products[position].name ?? ""),
            subtitle: Text(this.products[position].description ?? ""),

            onTap: () {},
          ),
        );
      },
    );
  }

  //add sayfasına gideceğiz, async yaparız
  void goToProductAdd() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductAdd()),
    );
    //sayfaya gidip, işlem yapmadan geri dönersem burada result null olmuş olur, result nulldan farklıysa yani gerçekten ekleme yapılmışsa
    if (result != null) {
      if (result == true) {
        //ekleme yapıldıysa ürünleri yeniden listelememiz gerekir
        getProducts();
      }
    }
  }

  void getProducts() async {
    //async
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        // products verisini aldığımızda UI'nin yeniden render edilmesini sağlıyoruz.
        this.products = data;
        productCount = data.length; // ürün sayısını güncelle
      });
    }); //productsFuture.then ->data geldiğinde
    //super.initState(); bunu çalıştırmamıza gerek yok,
  }
}
