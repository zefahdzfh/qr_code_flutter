// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_is_empty, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last, unused_local_variable, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_pas/app/controllers/auth_controller.dart';
import 'package:qr_code_pas/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController(
    text: "admin@gmail.com",
  );
  final TextEditingController passC = TextEditingController(text: "admin123");

  final AuthController authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => TextField(
                  autocorrect: false,
                  controller: passC,
                  obscureText: controller.isHidden.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.isHidden.toggle();
                          },
                          icon: Icon(controller.isHidden.isFalse
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                )),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    if (emailC.text.isNotEmpty && emailC.text.isNotEmpty) {
                      controller.isLoading(true);
                      Map<String, dynamic>  hasil = await authC.login(emailC.text, passC.text);
                      controller.isLoading(false);
                      if(hasil["error"]== true){
                        Get.snackbar("Error", hasil["Message"]);
                      }else{
                        Get.offAllNamed(Routes.home);
                      }
                    } else {
                      Get.snackbar("Error", "Email dan pw wajib diisi");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                child: Obx(() =>
                    Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..")))
          ],
        ));
  }
}
