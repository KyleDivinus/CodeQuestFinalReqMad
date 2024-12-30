import 'package:flame/components.dart';


class Health extends SpriteComponent {
  int healthPoints;

  Health(this.healthPoints) {
    // Initialize the health sprite
    updateHealthSprite();
  }

  // Make this method asynchronous
  Future<void> updateHealthSprite() async {
    switch (healthPoints) {
      case 4:
        sprite = await Sprite.load('assets/images/UI/fullheart.png');
        break;
      case 3:
        sprite = await Sprite.load('assets/images/UI/twoheart.png');
        break;
      case 2:
        sprite = await Sprite.load('assets/images/UI/oneheart.png');
        break;
      case 1:
        sprite = await Sprite.load('assets/images/UI/noheart.png');
        break;
      default:
        sprite = await Sprite.load('assets/images/UI/noheart.png');
    }
  }

  Future<void> decreaseHealth() async {
    if (healthPoints > 0) {
      healthPoints--;
      await updateHealthSprite(); // Await the sprite update
    }
  }
}