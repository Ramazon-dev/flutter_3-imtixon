import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:imtixon3/ui/api.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  int? yoshi;
  String? ismi;
  String? rang;
  SecondPage(this.ismi, this.yoshi, this.rang);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int score = 0;
  int oyinnomeri = 0;
  String apikelishi = "https://opentdb.com/api.php?amount=10";

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
        title: Text(
          widget.ismi.toString(),
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getQuiz(),
          builder: (context, AsyncSnapshot<Quiz> snap) {
            var data = snap.data;
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.teal[100],
                    ),
                    child: Text(
                      "${oyinnomeri}-savol",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.cyan[200],
                    ),
                    child: FutureBuilder(
                      future: getQuiz(),
                      builder: (context, AsyncSnapshot<Quiz> snap) {
                        if (snap.hasData) {
                          return Text(
                            data!.results![0].question.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 25),
                          );
                        } else if (snap.hasError) {
                          return Text(snap.hasError.toString());
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: getQuiz(),
                    builder: (context, AsyncSnapshot<Quiz> snap) {
                      return Container(
                        height: 250,
                        width: double.infinity,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var helperNUmber = 0;
                            var showedList = [];
                            var rSon = Random().nextInt(
                                data!.results![0].incorrectAnswers!.length + 1);
                            for (var i = 0;
                                i <
                                    data.results![0].incorrectAnswers!.length +
                                        1;
                                i++) {
                              if (rSon == i) {
                                showedList.add([
                                  data.results![0].correctAnswer.toString(),
                                  true
                                ]);
                                helperNUmber = 1;
                              } else {
                                showedList.add([
                                  data
                                      .results![0]
                                      .incorrectAnswers![
                                          helperNUmber == 1 ? i - 1 : i]
                                      .toString(),
                                  false
                                ]);
                              }
                            }
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    oyinnomeri += 1;
                                    showedList[index][1]
                                        ? score += 1
                                        : score += 0;
                                  });
                                },
                                tileColor: Colors.teal[50],
                                // showedList[index][1]
                                //     ? Colors.blue
                                //     : Colors.red,
                                title: Text(
                                  showedList[index][0],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            );
                          },
                          itemCount:
                              data!.results![0].incorrectAnswers!.length + 1,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.teal[100],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "to'g'ri javoblar soni-${score}",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Quiz> getQuiz() async {
    var _res = await http.get(Uri.parse(apikelishi));
    if (_res.statusCode == 200) {
      return Quiz.fromJson(json.decode(_res.body));
    } else {
      throw Exception("error in get data from api in my home page !!!!!!!!!");
    }
  }
}
