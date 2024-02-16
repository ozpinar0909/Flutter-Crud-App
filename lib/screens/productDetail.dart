// ignore_for_file: prefer_const_constructors, must_be_immutable, no_logic_in_create_state, use_key_in_widget_constructors, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:shop/data/dbHelper.dart';
import 'package:shop/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text = product.name.toString();
    txtDescription.text = product.description.toString();
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(" Ürün detayı : ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() { // Ürün detayındaki textfield alanlarının çağırıldığı metot
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField()
        ],
      ),
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün fiyatı"),
      controller: txtUnitPrice,
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün adı"),
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün açıklaması"),
      controller: txtDescription,
    );
  }

  void selectProcess(Options options) async { // Ürün detayındaki sil ve güncelle fonksiyonlarının çağırıldığı alan
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id!);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.widthId(
            id: product.id!,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
