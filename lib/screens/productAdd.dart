

// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:shop/data/dbHelper.dart';
import 'package:shop/models/product.dart';


class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Yeni ürün ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürünün fiyatı"),
      controller: txtUnitPrice,
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürünün adı"),
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürünün açıklaması"),
      controller: txtDescription,
    );
  }

  buildSaveButton() {
    return TextButton(
      child: Text("Ekle"),
      onPressed: () {
        addProduct();
      },
    );
  }

   void addProduct() async {
     var result = await dbHelper.insert(Product(
         name: txtName.text,
         description: txtDescription.text,
         unitPrice:double.parse(txtUnitPrice.text),));
   }
}
