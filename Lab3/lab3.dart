// 1) Class แม่: Product
class Product {
  final String _id; 
  String name;
  double _price;
  int? stock;

  Product({
    required String id,
    required this.name,
    required double price,
    this.stock,
  }) : _id = id, _price = price;

  String get id => _id;

  set updatePrice(double newPrice) {
    if (newPrice > 0) {
      _price = newPrice;
    } else {
      print("⚠️ [Error] การตั้งราคา $newPrice: ไม่สำเร็จ! (ราคาต้องมากกว่า 0)");
    }
  }

  double get price => _price;

  void applyDiscount(double percent) {
    if (percent >= 0 && percent <= 100) {
      _price -= (_price * (percent / 100));
    }
  }

  void restock(int amount) {
    stock = (stock ?? 0) + amount;
  }

  void showInfo() {
    print("---------------------------------");
    print("รหัสไอเทม: $_id");
    print("ชื่อไอเทม: $name");
    print("ราคาขาย: ${_price.toStringAsFixed(2)} Zeny");
    print("จำนวนในคลัง: ${stock ?? 'ยังไม่ระบุสต็อก'} ชิ้น");
  }
}

// 2) Class ลูก: DigitalProduct
class DigitalProduct extends Product {
  double fileSizeMB;

  DigitalProduct({
    required String id,
    required String name,
    required double price,
    int? stock,
    required this.fileSizeMB,
  }) : super(id: id, name: name, price: price, stock: stock);

  @override
  void showInfo() {
    super.showInfo();
    print("ประเภท: 📥 สินค้าดิจิทัล (Downloadable Content)");
    print("ขนาดไฟล์: $fileSizeMB MB");
  }
}

// 3) Class ลูก: FoodProduct
class FoodProduct extends Product {
  String expireDate;

  FoodProduct({
    required String id,
    required String name,
    required double price,
    int? stock,
    required this.expireDate,
  }) : super(id: id, name: name, price: price, stock: stock);

  @override
  void showInfo() {
    super.showInfo();
    print("ประเภท: 🍖 สินค้าอุปโภคบริโภค");
    print("วันหมดอายุ: $expireDate");
  }
}

void main() {
  print("=== ⚔️ ระบบจัดการคลังสินค้า MonsterHunter Guild Shop ⚔️ ===\n");

  var gear = Product(id: "G-001", name: "Iron Greatsword", price: 1500);
  var gameDlc = DigitalProduct(id: "D-007", name: "Monster Hunter expansion", price: 800, fileSizeMB: 45000);
  var potion = FoodProduct(id: "F-101", name: "Mega Potion", price: 150, stock: 20, expireDate: "2026-12-31");

  gear.restock(5);
  gear.applyDiscount(15);
  gameDlc.updatePrice = -55; // จุดที่จะโชว์ Error [Validation]
  potion.updatePrice = 120;

  List<Product> shopInventory = [gear, gameDlc, potion];

  print("\n📦 รายการสินค้าที่มีการอัปเดตล่าสุด:");
  for (var item in shopInventory) {
    item.showInfo();
  }
}