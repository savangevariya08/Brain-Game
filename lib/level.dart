import 'package:demo/data_class.dart';
import 'package:demo/first.dart';
import 'package:demo/two.dart';
import 'package:flutter/material.dart';

class no_time_limit_page extends StatefulWidget {
  @override
  State<no_time_limit_page> createState() => _no_time_limit_pageState();
}

class _no_time_limit_pageState extends State<no_time_limit_page> {
  int leval_number = 0;
  List l = [];

  @override
  void initState() {
    leval_number = home.prefs!.getInt("leval_number") ?? 0;
    l = List.filled(60, '');
    for (int i = 0; i < leval_number; i++) {
      l[i] = home.prefs!.getString('lv_se$i') ?? '';
    }
    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select Level", style: TextStyle(fontSize: 20)),
              Row(
                children: [
                  Text("NO TIME LIMIT",
                      style: TextStyle(fontSize: 15, color: Colors.white70)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                ],
              ),
            ],
          )),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("myassets/img/background.jpg"),
                fit: BoxFit.fill)),
        child: ListView.builder(
          itemCount: data_class.title_name.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, myindex) {
            return Center(
              child: Container(
                width: 200,
                height: 450,
                margin: EdgeInsets.only(left: 60),
                decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 4, color: Colors.teal.shade800)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: ListTile(
                        trailing: Icon(Icons.question_mark_outlined),
                        title: Text(
                          "${data_class.title_name[myindex]}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.black),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              tileColor: ((myindex * 10) + index + 1 <= leval_number + 1)?Colors.teal:Colors.teal.shade300,
                              onTap: () {
                                if ((myindex * 10) + index + 1 <= leval_number + 1) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return game_play(
                                            myindex * 10 + index);
                                      },
                                    ),
                                  );
                                }
                              },
                              title: Text("Level ${(myindex * 10) + index + 1}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              trailing:Text("${l[(myindex * 10) + index]}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
