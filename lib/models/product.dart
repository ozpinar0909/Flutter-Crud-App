// ignore_for_file: unnecessary_null_comparison, unnecessary_this, prefer_collection_literals

class Product {
   int? id;
  late String name;
  late String description;
   double? unitPrice;

  Product.widthId({required this.id,required this.name, required this.description, required this.unitPrice});
  Product({required this.name, required this.description, required this.unitPrice});

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

  Product.fromObject(dynamic o) {
    this.id = o["id"];
    this.name = o["name"].toString();
    this.description = o["description"].toString();
    this.unitPrice =o["unitprice"];
  }
}
