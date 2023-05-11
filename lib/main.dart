import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool yTrun = false;
  List<String> displayxy = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  var myTextStyle = const TextStyle(
      color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500);
  int yScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Player A",
                      style: myTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      yScore.toString(),
                      style: myTextStyle,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Player B",
                      style: myTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      xScore.toString(),
                      style: myTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 90, 87, 87)),
                      ),
                      child: Center(
                        child: Text(
                          displayxy[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "TIC TAC TOE",
                style: myTextStyle,
              ),
              Text(
                "@CREATEDBYBENI",
                style: myTextStyle,
              ),
            ],
          ))),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (yTrun && displayxy[index] == '') {
        displayxy[index] = 'A';
        filledBoxes += 1;
      } else if (!yTrun && displayxy[index] == '') {
        displayxy[index] = 'B';
        filledBoxes += 1;
      }

      yTrun = !yTrun;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayxy[0] == displayxy[1] &&
        displayxy[0] == displayxy[2] &&
        displayxy[0] != '') {
      _showDialog(displayxy[0]);
    }
    if (displayxy[3] == displayxy[4] &&
        displayxy[3] == displayxy[5] &&
        displayxy[3] != '') {
      _showDialog(displayxy[3]);
    }
    if (displayxy[6] == displayxy[7] &&
        displayxy[6] == displayxy[8] &&
        displayxy[6] != '') {
      _showDialog(displayxy[6]);
    }
    if (displayxy[0] == displayxy[3] &&
        displayxy[0] == displayxy[6] &&
        displayxy[0] != '') {
      _showDialog(displayxy[0]);
    }
    if (displayxy[1] == displayxy[4] &&
        displayxy[1] == displayxy[7] &&
        displayxy[1] != '') {
      _showDialog(displayxy[1]);
    }
    if (displayxy[2] == displayxy[5] &&
        displayxy[2] == displayxy[8] &&
        displayxy[2] != '') {
      _showDialog(displayxy[2]);
    }
    if (displayxy[0] == displayxy[4] &&
        displayxy[0] == displayxy[8] &&
        displayxy[0] != '') {
      _showDialog(displayxy[0]);
    }
    if (displayxy[2] == displayxy[4] &&
        displayxy[2] == displayxy[6] &&
        displayxy[2] != '') {
      _showDialog(displayxy[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play Again")),
            ],
          );
        });
  }

  void _showDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner is $winner"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play Again")),
            ],
          );
        });
    if (winner == 'A') {
      yScore += 1;
    } else if (winner == 'B') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayxy[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
