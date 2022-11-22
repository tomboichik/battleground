import 'package:battle_ship/domain/battleground/battleground_repository.dart';
import 'package:battle_ship/domain/ship/ship_repository.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<List<int>> battleground = [];

  final BattleGroundRepository battleGroundRepository =
      BattleGroundRepository();

  final ShipRepository shipRepository = ShipRepositoryImpl();

  addBattleGround() {
    setState(() {
      battleground = battleGroundRepository.createGroundData(5, 5);
    });

    shipRepository.createShip([
      [1, 2],
      [2, 2]
    ], battleGroundRepository, Axis.horizontal);

    shipRepository.createShip([
      [3, 3],
    ], battleGroundRepository, Axis.vertical);

    shipRepository.createShip([
      [1, 1],
      [2, 1],
      [3, 1]
    ], battleGroundRepository, Axis.horizontal);

    battleGroundRepository.attackOnShip([0, 0]);

    battleGroundRepository.attackOnShip([1, 2]);
    battleGroundRepository.attackOnShip([2, 2]);
  }

  @override
  void initState() {
    super.initState();
    addBattleGround();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Flex(
                direction: Axis.horizontal,
                children: battleground
                    .map((e) => Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
