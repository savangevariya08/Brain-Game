import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: stopwatch(),
    debugShowCheckedModeBanner: false,
  ));
}

class stopwatch extends StatefulWidget {
  const stopwatch({super.key});

  @override
  State<stopwatch> createState() => _stopwatchState();
}

class _stopwatchState extends State<stopwatch> {
  bool but_status = false;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  Stream get_time() async* {
    while (true) {
      seconds++;
      await Future.delayed(
        Duration(seconds: 1),
      );
      if (seconds > 9) {
        minutes++;
        seconds = 0;
      }
      if (minutes > 1) {
        hours++;
        minutes = 0;
      }
      // time = "$hours : $minutes : $seconds";
      // print(time);
      yield seconds;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (but_status)
                  ? StreamBuilder(
                      stream: get_time(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            "$hours : $minutes : ${snapshot.data}",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Text(
                            "$hours : $minutes :  $seconds",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          );
                        }
                      },
                    )
                  : Text(
                      "$hours : $minutes :  $seconds",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (but_status == true) {
                    but_status = false;
                  } else {
                    but_status = true;
                  }
                  setState(() {});
                },
                child: Text((but_status) ? "Stop" : "Start"),
              ),
              ElevatedButton(
                  onPressed: () {
                    seconds = 0;
                    minutes = 0;
                    hours = 0;
                    but_status = false;
                    setState(() {});
                  },
                  child: Text("Reset"))
            ],
          )
        ],
      ),
    );
  }
}
