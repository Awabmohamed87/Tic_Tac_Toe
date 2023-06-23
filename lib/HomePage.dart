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
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SwitchListTile.adaptive(
                  title: const Text(
                    "Turn ON/OFF two player mode",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  value: _isTwoPlayersModeOn,
                  onChanged: ((value) => setState(() {
                        _isTwoPlayersModeOn = value;
                      }))),
              const SizedBox(
                height: 20,
              ),
              Text("$trn's turn",
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Schyler')),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: createGameBaord()),
              Text(_status,
                  style: const TextStyle(fontSize: 30, color: Colors.white)),
              ElevatedButton.icon(
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
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).splashColor),
                ),
              )
            ],
          ),
        ));
  }
}
