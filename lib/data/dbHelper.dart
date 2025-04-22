import 'package:locale_db/models/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// sqflite paketi veritabanı işlemleri için gerekli
// path paketi, dosya yollarını birleştirmek için kullanılır

// Veritabanı işlemleri için yardımcı sınıf tanımlıyoruz
class DbHelper {
  // Veritabanı nesnesini tutacak değişken (başlangıçta null olabilir)
  Database? _db;

  // Veritabanını çağırmak için bir getter tanımlıyoruz
  Future<Database> get db async {
    // Eğer veritabanı daha önce açılmadıysa (null ise)
    if (_db == null) {
      // Veritabanını başlatıyoruz
      _db = await initializeDb();
    }

    // Artık veritabanı nesnesi null değildir, onu döndürüyoruz
    return _db!;
  }

  // Veritabanını başlatan fonksiyon
  Future<Database> initializeDb() async {
    // Cihazın veritabanı dosyalarının tutulduğu yolu alıyoruz
    String path = await getDatabasesPath();

    // Veritabanı dosyasının tam yolunu oluşturuyoruz (örnek: /data/data/uygulama/databases/etrade.db)
    String dbPath = join(path, "etrade.db");

    // Veritabanını açıyoruz (eğer yoksa oluşturuluyor)
    var eTradeDB = await openDatabase(
      dbPath, // veritabanı yolu
      version: 1, // versiyon (güncelleme için önemli)
      onCreate: _createDb, // veritabanı ilk kez oluşturulursa tabloyu da kur
    );

    // Açılmış olan veritabanını döndürüyoruz
    return eTradeDB;
  }

  // Veritabanı ilk kez oluşturulursa çalışacak fonksiyon (tablo oluşturma burada yapılır)
  void _createDb(Database db, int version) async {
    // SQL komutu ile "products" adlı tabloyu oluşturuyoruz
    await db.execute('''
  CREATE TABLE products(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    unitPrice REAL
  )
''');
  }

  //Tüm verileri getirme
  //db adını verdiğimizde tüm verileri getirir
  Future<List> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    return result;
  }

  //Ekleme: int dönderelim: eklenip eklenmediğini 0 ya da 1 döndererek anlayalım
  //dbye direkt insert product olarak gönderemeyizi product ı map şeklinde istiyor
  //nesneyi map e çevirip gönderiyoruz
  //bu mape çevirme işlemini sık sık yapacağımız için ayrı bi yerde toMap() fonksiyonu tanımlarız
  // bu toMap() operasyonunu Product nesnesi içerisinde yazalım
  Future<int> insertProduct(Product product) async {
    Database db = await this.db;
    db.insert("products", product.toMap());
  }
}
