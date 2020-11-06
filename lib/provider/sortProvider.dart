import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../widgets/vertBar.dart';
import '../utils/wait.dart';

final _screenHeight = WidgetsBinding.instance.window.physicalSize.height;
final _screenRatio = WidgetsBinding.instance.window.devicePixelRatio;
final containerSize = (_screenHeight / _screenRatio) * .5;
bool _processing = false;
int speed = 150;

Random random = Random();

//Generates random array of integers
List<int> generateNewArray(int size) {
  return List<int>.generate(size, (index) => random.nextInt(1000));
}

List<int> initialIDS = List<int>.generate(20, (index) => random.nextInt(1000));

class WidgetBarProvider extends StateNotifier<List<Widget>> {
  WidgetBarProvider()
      : super(
            initialIDS.map((id) => VertBar(id, containerSize, false)).toList());

  //Creates an array of intiger ids to be sorted, builds visual array
  void createArray(int arraySize) {
    _processing = false;
    if (state.length < arraySize) {
      var i = arraySize - state.length;
      var newNums = generateNewArray(i);
      state =
          initialIDS.map((id) => VertBar(id, containerSize, false)).toList() +
              newNums.map((id) => VertBar(id, containerSize, false)).toList();
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
    _processing = false;
    initialIDS = generateNewArray(arraySize);
    state = initialIDS.map((id) => VertBar(id, containerSize, false)).toList();
  }

  //Builds an active state widget (red bars)
  void buildActiveState(int index) {
    state[index] = VertBar(initialIDS[index], containerSize, true);
    state = [...state];
  }

  //Builds an inactive state widget (blue-gray bars)
  void buildInactiveState(int index) {
    state[index] = VertBar(initialIDS[index], containerSize, false);
    state = [...state];
  }

  //Builds a final state widget indicating array is sorted (green bars)
  void buildFinalState(int index) {
    state[index] = VertBar(initialIDS[index], containerSize);
    state = [...state];
  }

  //Swaps the position of bars that have been sorted
  void swapBarPositions(int j) {
    int temp = initialIDS[j];
    initialIDS[j] = initialIDS[j + 1];
    initialIDS[j + 1] = temp;
    var tempWidget = state[j];
    state[j] = state[j + 1];
    state[j + 1] = tempWidget;
    state = [...state];
  }

  void sortArray([String algorithm]) {
    void bubbleSort() async {
      _processing = true;
      int n = initialIDS.length;
      for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
          if (_processing == false) {
            break;
          }
          buildActiveState(j);
          buildActiveState(j + 1);
          await wait(speed);
          if (initialIDS[j] > initialIDS[j + 1]) {
            swapBarPositions(j);
            buildInactiveState(j);
            buildInactiveState(j + 1);
          }
          buildInactiveState(j);
          buildInactiveState(j + 1);
        }
      }
      _processing = false;
      state = initialIDS.map((id) => VertBar(id, containerSize)).toList();
    }

    if (_processing == false) {
      bubbleSort();
    }
  }
}

//Controls the number of VertBar widgets being displayed
class SliderProvider extends StateNotifier<int> {
  SliderProvider() : super(20);

  void setSlider(int slideValue) {
    state = slideValue;
  }

  int get slideValue {
    return state;
  }
}

class SortSpeedProvider extends StateNotifier<int> {
  SortSpeedProvider() : super(-100);

  void setSlider(int slideValue) {
    speed = slideValue.abs();
    state = slideValue;
  }

  int get slideValue {
    return state;
  }
}
