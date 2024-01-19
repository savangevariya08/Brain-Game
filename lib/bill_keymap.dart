import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> l = [
    {'name': 'Computer', 'rate': 15000, 'qty': 1, 'ischeck': false, 'amt': 0},
    {'name': 'Mouse', 'rate': 350, 'qty': 1, 'ischeck': false, 'amt': 0},
    {'name': 'KeyBoard', 'rate': 800, 'qty': 1, 'ischeck': false, 'amt': 0},
    {'name': 'PenDrive', 'rate': 850, 'qty': 1, 'ischeck': false, 'amt': 0},
  ];
  dynamic total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Book"),
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
          itemCount: l.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Wrap(alignment: WrapAlignment.spaceEvenly, children: [
                Checkbox(
                  value: l[index]['ischeck'],
                  onChanged: (value) {
                    total=0;
                    l[index]['ischeck'] = value;

                   if(l[index]['ischeck']==true){
                     l[index]['amt'] = l[index]['rate'] * l[index]['qty'];
                   }
                    setState(() {});
                  },
                ),
                Text("${l[index]['name']}"),
                Text("${l[index]['rate']}"),
                DropdownButton(
                  value: l[index]['qty'],
                  items: const [
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
                  ],
                  onChanged: (value) {
                    total=0;
                    l[index]['qty'] = value;
                    l[index]['amt'] = l[index]['rate'] * l[index]['qty'];
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
              "item",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Rate",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "qty",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "amount",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        Expanded(
            child: ListView(
                children:
                    l.where((element) => element['ischeck'] == true).map((l) {
                      total+=l['amt'];
          return ListTile(
            title: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Text("${l['name']}"),
                Text("${l['rate']}"),
                Text("${l['qty']}"),
                 Text("${l['amt']}"),
              ],
            ),
          );
        }).toList())),
        Text(
          "Total : $total",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
