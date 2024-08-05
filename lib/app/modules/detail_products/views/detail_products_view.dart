// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_is_empty, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last, unused_local_variable, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_pas/app/data/models/product.model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_products_controller.dart';

class DetailProductsView extends GetView<DetailProductsController> {
  final ProductModel product = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    codeC.text = product.code;
    nameC.text = product.name;
    qtyC.text = product.qty.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Products'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: QrImageView(
                    data: product.code,
                    size: 200.0,
                    version: QrVersions.auto,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: codeC,
              maxLength: 10,
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Product Code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: nameC,
              maxLength: 10,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: qtyC,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller.isLoadingUpdate.isFalse) {
                    if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                      controller.isLoadingUpdate(true);
                      Map<String, dynamic> hasil =
                          await controller.editProduct({
                        "id": product.productId,
                        "name": nameC.text,
                        "qty": int.tryParse(qtyC.text) ?? 0,
                      });
                      controller.isLoadingUpdate(false);

                      Get.snackbar(
                          hasil["error"] == true ? "Error" : "Berhasil",
                          hasil["message"],
                          //menit 25:47
                          duration: Duration(seconds: 2));
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please fill all fields",
                        duration: Duration(seconds: 2),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                child: Obx(() => Text(controller.isLoadingUpdate.isFalse
                    ? "UPDATE PRODUCT"
                    : "LOADING.."))),
            TextButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Delete Product",
                      middleText: "Are you sure you want to delete product?",
                      actions: [
                        OutlinedButton(
                            onPressed: () => Get.back(), child: Text("Cancel")),
                        ElevatedButton(
                            onPressed: () async {
                              controller.isLoadingDelete(true);
                              //
                              Map<String, dynamic> hasil = await controller
                                  .deleteProduct(product.productId);
                              controller.isLoadingDelete(false);

                              //balik ke page products
                              Get.back(); // tutup dialog
                              Get.back(); //balik ke page products
                              Get.snackbar(
                                  hasil["error"] == true ? "Error" : "Berhasil",
                                  hasil["message"],
                                  duration: Duration(seconds: 2));
                            },
                            child: Obx(() => controller.isLoadingDelete.isFalse
                                ? Text('DELETE')
                                : Container(
                                    padding: EdgeInsets.all(2),
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1,
                                    ),
                                  )))
                      ]);
                },
                child: Text(
                  "Delete Product",
                  style: TextStyle(color: Colors.red.shade900),
                ))
          ],
        ));
  }
}
