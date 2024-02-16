// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_null_comparison, sort_child_properties_last, use_key_in_widget_constructors, unnecessary_this

import 'package:flutter/material.dart';
import 'package:shop/data/dbHelper.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/productAdd.dart';
import 'package:shop/screens/productDetail.dart';

class ProductList extends StatefulWidget {
  @override
  State createState() => _ProductListState();
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
   List? products;
  int productCount = 0;

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      getProducts();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () {
          gotoProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.blue,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text("P"),
              ),
              title: Text(this.products![position].name),
              subtitle: Text(this.products![position].description),
              onTap: () {
                goToDetail(this.products![position]);
              },
            ),
          );
        });
  }

  void gotoProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result == true) {
        getProducts();
      }
    }
  }

  void getProducts() async { // Ürünleri listeleyen metotların çağırıldığı alan
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      productCount = data.length;
      List<Product> productsData = <Product>[];
      setState(() {
        products = data;
        productCount=productCount;
      });
    });
  }

  void goToDetail(Product product) async {
    bool? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
