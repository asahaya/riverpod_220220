import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_220220/data/count_data.dart';

//Provider=定数
final titleProvider = Provider<String>((ref) => "Riverpod DEMO");

final bodyTextProvider = Provider<String>((ref) => "counterUP!!");

//stateProvider=変数
final countProvider = StateProvider<int>((ref) => 0);

final countDataProvider = StateProvider<CountData>((ref) =>
    CountData(count: 0, countUp: 0, countDown: 0,));