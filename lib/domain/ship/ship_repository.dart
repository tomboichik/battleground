import 'package:battle_ship/data/ship/model/ship.dart';
import 'package:battle_ship/domain/battleground/battleground_repository.dart';
import 'package:flutter/material.dart';

abstract class ShipRepository {
  createShip(
    List<List<int>> body,
    BattleGroundRepository battleGroundRepository,
    Axis axis,
  );
}

class ShipRepositoryImpl implements ShipRepository {
  @override
  createShip(
    List<List<int>> body,
    BattleGroundRepository battleGroundRepository,
    Axis axis,
  ) {
    battleGroundRepository.addShip(Ship(body, axis));
  }
}
