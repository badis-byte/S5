import 'package:flutter/material.dart';
import 'dart:math';

class WaterSortBoard extends StatefulWidget {
  const WaterSortBoard({super.key});

  @override
  State<WaterSortBoard> createState() => _WaterSortBoardState();
}

class _WaterSortBoardState extends State<WaterSortBoard> {
  //Must be reshuffled not hardcoded
  Map<int, Color> colorMap = {
    0: Colors.red,
    1: Colors.green,
    2: Colors.blue,
    3: Colors.yellow,
  };

  List<List<dynamic>> initialBars = [
    [Colors.red, Colors.green, Colors.yellow, Colors.green],
    [Colors.blue, Colors.yellow, Colors.blue],
    [Colors.red, Colors.yellow, Colors.blue],
    [Colors.yellow, Colors.green, Colors.blue, Colors.red],
    [Colors.red, Colors.green],
  ];

  late List<List<dynamic>> bars;

  bool checkwin() {
    for (var bar in bars) {
      if (bar.isEmpty) continue;
      Color firstColor = bar[0];
      for (var color in bar) {
        if (color != firstColor) return false;
      }
    }
    return true;
  }

  void shuffle(){
      List<dynamic> allColors = initialBars.expand((list) => list).toList();
      allColors.shuffle();
      int index = 0;
      for (int i = 0; i < initialBars.length; i++) {
        int listSize = initialBars[i].length;
        initialBars[i] = allColors.sublist(index, index + listSize);
        index += listSize;
      }
      bars = List.from(initialBars)..shuffle();
  }

  @override
  void initState() {
    super.initState();
    shuffle();
  }

  var from_jar = -1;
  var to_jar = -1;
  var selected = -1;

  bool handleClickJar(int jarIndex) {
    if (from_jar == -1) {
      from_jar = jarIndex;
    } else {
      to_jar = jarIndex;
      moveWaterIfPossible();
    }
    print('from: $from_jar, to: $to_jar');
    return true;
  }

  bool moveWaterIfPossible() {
    if (bars[from_jar].isEmpty) {
      resetFromTo();
      return false;
    }
    if (bars[to_jar].isEmpty || bars[to_jar].first == bars[from_jar].first) {
      if (bars[to_jar].length < 4) {
        bars[to_jar].insert(0, bars[from_jar][0]);
        bars[from_jar].removeAt(0);
        setState(() {resetFromTo();});
        if(checkwin()){
          print("The player just won!!");
        }
      }
    }
    
    return true;
  }

  bool resetFromTo() {
    from_jar = -1;
    to_jar = -1;
    return true;
  }


  @override
  Widget build(BuildContext context) {
    bool s;
    return Scaffold(
      appBar: AppBar(title: const Text('Water Sort Puzzle')),
      body: Center(
        child: Column(
          children: [
            Text('Water Sort Puzzle Game Board'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int b = 0; b < bars.length; b++)
                  GestureDetector(
                    onTap: () {
                        selected=b;
                        s= b == selected;
                      handleClickJar(b);
                      setState(() {});
                    },
                    child: Container(
                      width: 60,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 160,
                      decoration: BoxDecoration(
                        boxShadow:[ BoxShadow(
                          color: b == selected ? Colors.orange : Colors.transparent,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),],
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int i = 0; i < bars[b].length; i++)
                            Container(
                              width: 60,
                              height: 150 / 4,
                              color: bars[b][i],
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  shuffle();
                  selected = -1;
                });
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('Restart'),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}