// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Game game = Game();
  Map<int, Widget> dict = {
    1: const Text(
      "X",
      style: TextStyle(color: Colors.red, fontSize: 60),
    ),
    2: const Text(
      "O",
      style: TextStyle(color: Colors.grey, fontSize: 60),
    ),
    0: const Text('')
  };
  bool _isTwoPlayersModeOn = true;
  String trn = "X";
  String _status = "";

  Widget createGameBaord() => GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2.5,
        crossAxisSpacing: 2.5,
      ),
      itemBuilder: ((context, index) => InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: game.isGameOver
                ? null
                : () {
                    setState(() {
                      game.makePlay(index, trn);
                      _status = game.checkWinning(trn);
                      trn = game.getTurn();
                      if (!_isTwoPlayersModeOn && !game.isGameOver) {
                        game.autoPlay(trn);
                        _status = game.checkWinning(trn);
                        trn = game.getTurn();
                      }
                      if (game.availablePlays == 0 && _status == "") {
                        _status = "Draw..!";
                      }
                    });
                  },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).shadowColor),
                child: Center(
                  child: dict[game.grid[index]],
                )),
          )));

  List<Widget> firstBloc() => [
        const SizedBox(height: 30),
        SwitchListTile.adaptive(
            title: const Text(
              "Multiple players mode",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            value: _isTwoPlayersModeOn,
            onChanged: ((value) => setState(() {
                  _isTwoPlayersModeOn = value;
                }))),
        const SizedBox(
          height: 40,
        ),
        Text("$trn's turn",
            style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Schyler')),
        const SizedBox(
          height: 10,
        )
      ];

  List<Widget> secondBloc() => [
        Text(_status,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.replay,
              color: Colors.white,
            ),
            label: const Text("Restart Game",
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              setState(() {
                game = Game();
                trn = "X";
                _status = "";
              });
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(320, 60)),
              textStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 25)),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).shadowColor),
            ),
          ),
        )
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Text(
            "Tic Tac Toe",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.gamepad, color: Colors.white, size: 30),
          backgroundColor: Theme.of(context).shadowColor,
        ),
        body: SafeArea(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: <Widget>[
                    ...firstBloc(),
                    Expanded(child: createGameBaord()),
                    ...secondBloc()
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [...firstBloc(), ...secondBloc()],
                    )),
                    Expanded(child: createGameBaord())
                  ],
                ),
        ));
  }
}
