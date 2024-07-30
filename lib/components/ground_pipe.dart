import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import './pipe.dart';
import '../utility/config.dart';
import 'item.dart';

class GroundPipe extends PositionComponent with HasGameReference {
  GroundPipe();
  final random = Random();

  @override
  FutureOr<void> onLoad() async {
    position.x = game.size.x;
    const space = 200;
    double centerY = random.nextDouble()*(game.size.y - Config.heightGround - space) + space*0.5;
    if(centerY < 110) {
      centerY = 110;
    }
    const minHeight = 120 + space*0.5;
    double height = max(centerY - space*0.5, minHeight);
    Pipe topPipe = Pipe(isTop: true, height: height);
    Pipe bottomPipe = Pipe(isTop: false, height: game.size.y - Config.heightGround - height - space*0.5);
    Item item = Item(mSize: Vector2(70, 120))
    ..position.y = height;

    addAll([
      topPipe,
      bottomPipe,
      item
    ]);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= Config.speedGame*dt;
    if(position.x < -60) {
      removeFromParent();
    }
    super.update(dt);
  }
}