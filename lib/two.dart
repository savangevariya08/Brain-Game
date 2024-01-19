import 'dart:convert';

import 'package:demo/first.dart';
import 'package:demo/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class game_play extends StatefulWidget {
  int? index;

  game_play([this.index]);

  @override
  State<game_play> createState() => _game_playState();
}

class _game_playState extends State<game_play> {
  List pic = [];
  List pic1 = [];
  List<bool> temp = [];
  int second = 5;
  double count_down = 5;
  int match = 0;
  int pos1 = 0;
  int pos2 = 0;
  int count = 1;
  int i = 0;
  int leval_number = 0;
  int seond_store = 0;
  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    print(widget.index);
    l = List.filled(60, '');
    leval_number = home.prefs!.getInt('leval_number') ?? 0;
    for (int i = 0; i < leval_number; i++) {
      l[i] = home.prefs!.getString('lv_se$i') ?? '';
    }
    print(l);

    temp = List.filled(12, true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("TIME : NO TIME LIMIT"),
            content: Text("YOU HAVE 5 SECONDS TO MEMORIZE ALL IMAGES"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    _initImages();
                    time_second();
                    Navigator.pop(context);
                  },
                  child: Center(child: Text("OK")))
            ],
          );
        },
      );
    });
  }

  time_second() async {
    for (int i = 5; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      second = i;
      count_down = i.toDouble();
      if (i == 0) {
        temp = List.filled(12, false);
      }

      setState(() {});
    }

    while (true) {
      await Future.delayed(Duration(seconds: 1));
      if (match != 6) {
        i++;
        second = i;
        count_down = i.toDouble();
      }
      setState(() {});
    }
  }

  Future _initImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('img/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      pic = imagePaths;
      pic.shuffle();
      for (int i = 0; i < 6; i++) {
        pic1.add(pic[i]);
        pic1.add(pic[i]);
      }
      pic1.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool box=false;
    return Scaffold(
      appBar: AppBar(title: Text("$second")),
      body: Center(
        child: Container(
          height: 600,
          child: Column(
            children: [
              SliderTheme(
                child: Slider(
                  value: count_down,
                  max: 100,
                  min: 0,
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  onChanged: (double value) {
                    if (count_down == 100) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("failed"),
                          );
                        },
                      );
                    }
                  },
                ),
                data: SliderTheme.of(context).copyWith(
                    trackHeight: 15,
                    thumbColor: Colors.transparent,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: pic1.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (!temp[index] && count == 1) {
                          temp[index] = true;
                          count = 2;
                          pos1 = index;
                        }
                        if (!temp[index] && count == 2) {
                          temp[index] = true;
                          count = 1;
                          pos2 = index;

                          if (pic1[pos1] == pic1[pos2]) {
                            match++;
                            if (match == 6) {
                              if (l[widget.index!] == '') {
                                home.prefs!.setString(
                                    'lv_se$leval_number', second.toString());
                                leval_number++;
                                home.prefs!
                                    .setInt('leval_number', leval_number);
                              } else {
                                if (second < int.parse(l[widget.index!])) {
                                  home.prefs!.setString('lv_se${widget.index}',
                                      second.toString());
                                }
                              }
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text((l[widget.index!] != "")
                                        ? (second < int.parse(l[widget.index!])
                                        ? "NEW RECORDS"
                                        : "LEVEL COMPLETED")
                                        : "NEW RECORDS"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return no_time_limit_page();
                                                },
                                              ),
                                            );
                                          },
                                          child: Text("OK"))
                                    ],
                                    content: Container(
                                      alignment: Alignment.center,
                                      height: 200,
                                      width: 200,
                                      child: Column(children: [
                                        Text((l[widget.index!] != '')
                                            ? (second <
                                            int.parse(l[widget.index!])
                                            ? "$second seconds"
                                            : "congrats!!")
                                            : "$second seconds"),
                                        Text((l[widget.index!] != '')
                                            ? (second <
                                            int.parse(l[widget.index!])
                                            ? "NO time limit"
                                            : "")
                                            : "NO time limit"),
                                        Text((l[widget.index!] != '')
                                            ? (second <
                                            int.parse(l[widget.index!])
                                            ? "LEVEL $leval_number"
                                            : "")
                                            : "LEVEL $leval_number"),
                                        Text((l[widget.index!] != '')
                                            ? (second <
                                            int.parse(l[widget.index!])
                                            ? "well done"
                                            : "")
                                            : "well done"),
                                      ]),
                                    ),
                                  );
                                },
                              );
                            }
                          } else {
                            Future.delayed(Duration(milliseconds: 200))
                                .then((value) {
                              temp[pos1] = false;
                              temp[pos2] = false;
                              setState(() {});
                            });
                          }
                        }
                        setState(() {});
                      },
                      child: Visibility(
                        visible: temp[index],
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.teal,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          height: 100,
                          width: 100,
                          child: Image.asset("${pic1[index]}"),
                        ),
                        replacement: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.red.shade100,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
