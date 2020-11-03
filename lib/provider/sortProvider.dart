import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../widgets/vertBar.dart';
import '../utils/wait.dart';
import 'dart:async';

final _screenHeight = WidgetsBinding.instance.window.physicalSize.height;
final _screenRatio = WidgetsBinding.instance.window.devicePixelRatio;
final containerSize = (_screenHeight / _screenRatio) * .5;

Random random = Random();

List<int> generateNewArray(int size) {
  return List<int>.generate(size, (index) => random.nextInt(1000));
}

List<int> initialIDS = List<int>.generate(20, (index) => random.nextInt(1000));

class WidgetBarProvider extends StateNotifier<List<Widget>> {
  WidgetBarProvider()
      : super(
            initialIDS.map((id) => VertBar(id, containerSize, false)).toList());

  void createArray(int arraySize) {
    if (state.length < arraySize) {
      var i = arraySize - state.length;
      var newNums = generateNewArray(i);
      state = [
        ...state +
            newNums.map((id) => VertBar(id, containerSize, false)).toList()
      ];
      initialIDS = [...initialIDS, ...newNums];
    }
    if (state.length > arraySize) {
      var i = state.length - arraySize;
      state = [...state].sublist(0, state.length - i);
      initialIDS = [...initialIDS].sublist(0, arraySize);
    }
  }

  //This method rebuilds a new array of random bar widgets.
  void refreshArray(int arraySize) {
    initialIDS = generateNewArray(arraySize);
    state = initialIDS.map((id) => VertBar(id, containerSize, false)).toList();
  }

  //Builds an active state widget
  void buildActiveState(int index) {
    state[index] = VertBar(initialIDS[index], containerSize, true);
    state = [...state];
  }

  //Builds an inactive state widget
  void buildInactiveState(int index) {
    state[index] = VertBar(initialIDS[index], containerSize, false);
    state = [...state];
  }

  void buildFinalState(int index) {
    state[index] = VertBar(initialIDS[index], containerSize, true);
    state = [...state];
  }

  void sortArray([String algorithm]) {
    void bubbleSort() async {
      int n = initialIDS.length;
      for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
          buildActiveState(j);
          buildActiveState(j + 1);
          await wait();
          if (initialIDS[j] > initialIDS[j + 1]) {
            int temp = initialIDS[j];
            initialIDS[j] = initialIDS[j + 1];
            initialIDS[j + 1] = temp;
            var tempWidget = state[j];
            state[j] = state[j + 1];
            state[j + 1] = tempWidget;
            state = [...state];
            buildInactiveState(j);
            buildInactiveState(j + 1);
          }
          buildInactiveState(j);
          buildInactiveState(j + 1);
          // state[j] = VertBar(initialIDS[j], containerSize, false);
          // state[j + 1] = VertBar(initialIDS[j + 1], containerSize, false);
          // state = [...state];
        }
      }
      initialIDS.forEach((element) => {buildFinalState(element)});
    }

    bubbleSort();
  }
}

class SliderProvider extends StateNotifier<int> {
  SliderProvider() : super(20);

  void setSlider(int slideValue) {
    state = slideValue;
  }

  int get slideValue {
    return state;
  }
}
