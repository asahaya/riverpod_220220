import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_220220/data/count_data.dart';
import 'package:riverpod_220220/logic/logic.dart';
import 'package:riverpod_220220/logic/sound_logic.dart';
import 'package:riverpod_220220/provider.dart';

class ViewModel {
  //Riverpodアクセス
  Logic _logic = Logic();

  SoundLogic _soundLogic = SoundLogic();

  late WidgetRef _ref;


  void setRef(WidgetRef ref) {
    this._ref = ref;
    _soundLogic.load();
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp =>
      _ref.watch(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  void onIncrease() {
    _logic.increase();
    // _ref.watch(countDataProvider.state).state = _logic.countData;
    // _soundLogic.playUpSound();
    // _ref.read(countDataProvider.notifier).state = _logic.countData;
    // _soundLogic.playUpSound();
    update();
  }

  void onDecrease() {
    _logic.decrease();
    // _ref.watch(countDataProvider.state).state = _logic.countData;
    // _soundLogic.playDownSound();
    update();
    // _soundLogic.playDownSound();
  }

  void onReset() {
    _logic.reset();
    // _ref.read(countDataProvider.state).state = _logic.countData;
    // _soundLogic.playResetSound();
    update();
    // _soundLogic.playResetSound();
  }

  void update() {
    CountData oldValue = _ref.watch(countDataProvider.notifier).state;

    _ref.watch(countDataProvider.notifier).state = _logic.countData;
    CountData newValue = _ref.watch(countDataProvider.state).state;
    _soundLogic.playResetSound();
    _soundLogic.valueChanged(oldValue, newValue);
  }
}
