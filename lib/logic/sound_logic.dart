import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_220220/data/count_data.dart';

class SoundLogic {
  static const SOUND_DATA_UP = 'assets/sounds/O.mp3';
  static const SOUND_DATA_DOWN = 'assets/sounds/X.mp3';
  static const SOUND_DATA_RESET = 'assets/sounds/Q.mp3';

  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  void valueChanged(CountData oldValue, CountData newValue) {
    if (newValue.countUp == 0 &&
        newValue.countDown == 0 &&
        newValue.count == 0) {
      playResetSound();
    } else if (oldValue.countUp + 1 == newValue.countUp) {
      playUpSound();
    } else if (oldValue.countDown + 1 == newValue.countDown) {
      playDownSound();
    }
  }

  void playUpSound() {
    _cache.play(SOUND_DATA_UP);
  }

  void playDownSound() {
    _cache.play(SOUND_DATA_DOWN);
  }

  void playResetSound() {
    _cache.play(SOUND_DATA_RESET);
  }
}
