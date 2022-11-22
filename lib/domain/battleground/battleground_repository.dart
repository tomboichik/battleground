import 'package:battle_ship/data/attack/enum/attack.dart';
import 'package:battle_ship/data/ship/model/ship.dart';

abstract class BattlegroundRepository {
  List<List<int>> createGroundData(int x, int y);

  addShip(Ship ship);

  ResultType attackOnShip(
    List<int> attackCoords,
  );
}

class BattleGroundRepository implements BattlegroundRepository {
  List<Ship> ships = [];

  List<List<int>> map = [];

  @override
  List<List<int>> createGroundData(int x, int y) {
    List<List<int>> groundData = [];

    for (int i = 0; i < x; i++) {
      List<int> emptyList = [];
      for (int z = 0; z < y; z++) {
        emptyList.add(z);
      }

      map = groundData;
      groundData.add(emptyList);
    }

    print('Board created ${x}x$y');

    return groundData;
  }

  @override
  addShip(
    Ship ship,
  ) {
    try {
      ship.body.forEach((element) {
        map[element.first][element.last];
      });
      ships.add(ship);

      print(
          'Ship ${ship.body.length} placed on ${ship.body} axis ${ship.axis} ');
    } catch (e) {
      print(e);
    }
  }

  List<List<int>> attacks = [];

  @override
  ResultType attackOnShip(List<int> attackCoords) {
    try {
      bool hit = false;

      Ship? attackedShip;

      ships.forEach((ship) {
        ship.body.forEach((element) {
          if (element[0] == attackCoords[0]) {
            if (element[1] == attackCoords[1]) {
              attackedShip = ship;
              hit = true;
            }
          }
        });
      });

      if (hit && attackedShip != null) {
        attacks.add(attackCoords);
        int hits = 0;

        attackedShip!.body.forEach(((element) {
          attacks.forEach((attack) {
            if (element[0] == attackCoords[0]) {
              if (element[1] == attackCoords[1]) {
                hits++;
              }
            }
          });
        }));

        if (hits == attackedShip!.body.length) {
          print(
              'attack on type ${attackCoords[0]},${attackCoords[1]} result ${ResultType.sunk}');
          return ResultType.sunk;
        }

        print(
            'attack on type ${attackCoords[0]},${attackCoords[1]} result ${ResultType.hit}');

        return ResultType.hit;
      } else {
        print(
            'attack on type ${attackCoords[0]},${attackCoords[1]} result ${ResultType.noHit}');
        return ResultType.noHit;
      }
    } catch (e) {
      print(e);

      return ResultType.noHit;
    }
  }
}
