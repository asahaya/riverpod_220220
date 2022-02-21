

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_220220/main.dart';
import 'package:riverpod_220220/provider.dart';
import 'package:riverpod_220220/view_model.dart';

class MockViewModel extends Mock implements ViewModel{}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });
  const iPhone55 =
      Device(size: Size(414, 736), name: 'iPhone55', devicePixelRatio: 3.0);
  List<Device> devices = [iPhone55];


  testGoldens('normal', (tester) async {
    ViewModel viewModel = ViewModel();

    await tester.pumpWidgetBuilder(ProviderScope(child: MyHomePage(viewModel)

    ));

    await multiScreenGolden(tester, 'myHomePage_0init', devices: devices);

    await tester.tap(find.byIcon(Icons.plus_one));
    await tester.tap(find.byIcon(Icons.plus_one));
    await tester.tap(find.byIcon(Icons.exposure_minus_1));
    await tester.pump();

    await multiScreenGolden(
      tester,
      'myHomePage_1tapped',
      devices: devices,
    );
  });

  testGoldens('viewModelTest', (tester) async {
    var mock = MockViewModel();
    when(() => mock.count).thenReturn(1123456789.toString());
    when(() => mock.countUp).thenReturn(2123456789.toString());
    when(() => mock.countDown).thenReturn(3123456789.toString());

    final mockTitleProvider = Provider<String>((ref) => 'mockTitle');

    await tester.pumpWidgetBuilder(
      ProviderScope(
        child: MyHomePage(mock),
        overrides: [
//          titleProvider.overrideWithProvider(mockTitleProvider),
          titleProvider
              .overrideWithProvider(Provider<String>((ref) => 'mockTitle')),
          bodyTextProvider.overrideWithValue('mockMessage'),
        ],
      ),
    );
    await multiScreenGolden(
      tester,
      'myHomePage_mock',
      devices: devices,
    );

  });
}
