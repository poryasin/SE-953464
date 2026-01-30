// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider_counter/main.dart';
import '../lib/counter_model.dart' show CounterModel;

void main() {
  group('CounterModel', () {
    test('initial value should be 0', () {
      final counter = CounterModel();
      expect(counter.count, 0);
    });

    test('increment increases count by 1', () {
      final counter = CounterModel();
      counter.increment();
      expect(counter.count, 1);
      counter.increment();
      expect(counter.count, 2);
    });

    test('reset sets count to 0', () {
      final counter = CounterModel();
      counter.increment();
      counter.increment();
      expect(counter.count, 2);
      counter.reset();
      expect(counter.count, 0);
    });
  });

  // testWidgets('Counter increments smoke test', (tester) async {
  //   // Build our app, provide it with a model, and trigger a frame.
  //   await tester.pumpWidget(
  //     ChangeNotifierProvider(create: (context) => CounterModel(), child: MyApp()),
  //   );

  //   // Verify that our counter starts at 0.
  //   expect(find.text('Count: 0'), findsOneWidget);
  //   expect(find.text('Count: 1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('Count: 0'), findsNothing);
  //   expect(find.text('Count: 1'), findsOneWidget);
  // });
}
