import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: demo(),
  ));
}

class demo extends StatefulWidget {
  const demo({super.key});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  List l = [];
  List item = ["Computer", "mouse", "keyboard", "pendrive"];
  List ischeck = [false, false, false, false];
  List rate = [15000, 200, 800, 400];
  List rate1 = [];
  List qty = [1, 1, 1, 1];
  List qty1 = [];
  List amt = [];
 dynamic total=0;
  List<DropdownMenuItem> qty_list = [
    DropdownMenuItem(
      child: Text("Qty"),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text("1"),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text("2"),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text("3"),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text("4"),
      value: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //total=0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill"),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "select",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "item",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Rate",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Qty",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemCount: item.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Wrap(alignment: WrapAlignment.spaceEvenly, children: [
                Checkbox(
                  value: ischeck[index],
                  onChanged: (value) {
                    ischeck[index] = value;
                    if (ischeck[index] == true) {
                      l.add(item[index]);
                      rate1.add(rate[index]);
                      qty1.add(qty[index]);
                      // amt[index] = rate1[index] * qty1[index];
                      // total=total+amt[index];
                      for (int i = 0; i < rate1.length; i++) {
                        if (rate1[i] == rate[index]) {
                         amt.add(rate1[i]*qty1[i]);
                         total=total+amt[i];
                        }
                      }
                    } else if (ischeck[index] == false) {
                      dynamic tot;
                      for (int i = 0; i < rate1.length; i++) {
                        if (rate1[i] == rate[index]) {
                           amt.removeAt(i);
                          tot=rate1[i]*qty1[i];
                          total=total-tot;
                        }
                      }
                      l.remove(item[index]);
                      rate1.remove(rate[index]);
                      qty1.remove(qty[index]);
                    }
                    setState(() {});
                  },
                ),
                Text(
                  "${item[index]}",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "${rate[index]}",
                  style: TextStyle(fontSize: 15),
                ),
                DropdownButton(
                  value: qty[index],
                  items: qty_list,
                  onChanged: (value) {
                    total=0;
                    qty[index] = value;
                    //qty1[index]=value;
                    for (int i = 0; i < l.length; i++) {
                      if (l[i] == item[index]) {
                        qty1[i] = value;
                      }
                    }
                    for (int i = 0; i < rate1.length; i++) {
                        amt[i]=rate1[i]*qty1[i];
                        total=total+amt[i];
                    }
                    setState(() {});
                  },
                ),
              ]),
            );
          },
        )),
        Divider(
          thickness: 5,
          color: Colors.brown,
        ),
        Container(
          child: Text("purch list"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "select",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "item",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Rate",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Amount",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemCount: l.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Text("${l[index]}"),
                Text("${rate1[index]}"),
                Text("${qty1[index]}"),
                Text("${amt[index]}"),
              ],
            ));
          },
        )),
        Text("Total : $total",style: TextStyle(fontSize: 25),),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}