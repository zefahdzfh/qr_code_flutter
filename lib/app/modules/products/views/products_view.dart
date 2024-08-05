// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_is_empty, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last, unused_local_variable, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_pas/app/data/models/product.model.dart';
import 'package:qr_code_pas/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamProducts(),
            builder: (context, snapProducts) {
              if (snapProducts.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapProducts.data!.docs.isEmpty) {
                return Center(
                  child: Text("No Products available"),
                );
              }

              List<ProductModel> allProducts = [];

              for (var element in snapProducts.data!.docs) {
                allProducts.add(ProductModel.fromJson(element.data()));
              }
              return ListView.builder(
                  itemCount: allProducts.length,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (content, index) {
                    ProductModel product = allProducts[index];
                    return Card(
                        elevation: 5,
                        margin: EdgeInsets.only(bottom: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.detailProducts, arguments: product);
                          },
                          child: Container(
                            height: 100,
                            padding: EdgeInsets.all(20),
                            color: Colors.grey.shade100,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.code,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Text(product.name),
                                      Text('Jumlah : ${product.qty}'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: QrImageView(
                                      data:product.code,
                                      size: 200.0,
                                      version: QrVersions.auto,
                                    ))
                              ],
                            ),
                          ),
                        ));
                  });
            }));
  }
}
