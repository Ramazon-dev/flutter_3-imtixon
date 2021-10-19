import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:imtixon3/ui/second_page.dart';

class Imtixon extends StatelessWidget {
  Imtixon({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController ism = TextEditingController();
  String ismi = '';
  TextEditingController yoshi = TextEditingController();
  int yosh = 0;
  TextEditingController rang = TextEditingController();
  String rangi = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.deepOrange,
              ],
            ),
          ),
        ),
        title: const Text(
          "Log in Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  validator: (text) {
                    if (text!.length < 4) {
                      return "Ism 4 ta belgidan kam bo'lmasligi kerak";
                    }
                  },
                  controller: ism,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    hintText: "Ismingizni kiriting",
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: rang,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    hintText: "Familiyangizni kiriting",
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: yoshi,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    hintText: "Yoshingizni kiriting",
                  ),
                ),
                const SizedBox(height: 350),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    "Next Page",
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    ismi = ism.text;
                    yosh = int.parse(yoshi.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondPage(
                          ismi,
                          yosh,
                          rang.text,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
