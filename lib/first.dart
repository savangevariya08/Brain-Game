import 'package:demo/level.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: home(),
  ));
}

class home extends StatefulWidget {

  static SharedPreferences? prefs;
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int leval_number=0;

  List l = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_prefer();
  }
  get_prefer()
  async {
    home.prefs= await SharedPreferences.getInstance();
    leval_number = home.prefs!.getInt("leval_number")??0;
    l= List.filled(60, '');
    for(int i=0;i<leval_number;i++)
    {
      l[i]=home.prefs!.getString('lv_se$i')??'';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("select mode"),
            Row(
              children: [
                Icon(Icons.volume_up_sharp),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.menu),
              ],
            )
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("myassets/img/background.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Expanded(
                  child: SizedBox(
                    height: 100,
                  )),
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    border: Border.all(color: Colors.teal, width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return no_time_limit_page();
                          },));
                        },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            color: Colors.teal,
                            alignment: Alignment.center,
                            child: Text("NO TIME LIMIT",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          color: Colors.teal,
                          alignment: Alignment.center,
                          child: Text("NORMAL",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          color: Colors.teal,
                          alignment: Alignment.center,
                          child: Text("HARD",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white)),
                        ),
                      ),
                    ]),
              ),
              // Expanded(child: Container(color: Colors.lightGreenAccent,)),
              Expanded(
                  child: SizedBox(
                    height: 10,
                  )),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      border: Border.all(color: Colors.teal, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    height: 45,
                    width: 130,
                    color: Colors.teal,
                    alignment: Alignment.center,
                    child: Text("REMOVE ADS",
                        style: TextStyle(fontSize: 13, color: Colors.white)),
                  ),
                ),),
              Expanded(
                  child: SizedBox(
                    height: 10,
                  )),
              Expanded(
                  child: Container(
                    height: 50,
                    width: 275,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        border: Border.all(color: Colors.teal, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 35,
                          width: 80,
                          color: Colors.teal,
                          alignment: Alignment.center,
                          child: Text("SHARE",
                              style: TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 35,
                          width: 90,
                          color: Colors.teal,
                          alignment: Alignment.center,
                          child: Text("MORE GAMES",
                              style: TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                    color: Colors.transparent,
                  )),
            ],
          )),
    );
  }
}