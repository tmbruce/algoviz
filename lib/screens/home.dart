import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import '../provider/sortProvider.dart';

class HomeScreen extends ConsumerWidget {
  static String id = 'HomeScreen';
  final sliderProvider = StateNotifierProvider<SliderProvider>((ref) {
    return SliderProvider();
  });
  final widgetBarProvider = StateNotifierProvider<WidgetBarProvider>((ref) {
    return WidgetBarProvider();
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final slideProvider = watch(sliderProvider.state);
    final barProvider = watch(widgetBarProvider.state);
    var screenSize = MediaQuery.of(context).size;
    var containerSize = screenSize.height * .5;

    return Scaffold(
      appBar: AppBar(
        title: Text('AlgoViz'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: screenSize.height * .05, bottom: screenSize.height * .025),
            height: containerSize,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: barProvider),
          ),
          Slider(
            activeColor: Colors.blueGrey,
            value: slideProvider.toDouble(),
            min: 20,
            max: (screenSize.width / 4).floorToDouble(),
            onChanged: (value) {
              context.read(sliderProvider).setSlider(value.toInt());
              context.read(widgetBarProvider).createArray(value.toInt());
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('Sort'),
                onPressed: () {
                  context.read(widgetBarProvider).sortArray();
                },
              ),
              RaisedButton(
                child: Text('Reset'),
                onPressed: () =>
                    context.read(widgetBarProvider).refreshArray(slideProvider),
              ),
            ],
          )
        ],
      ),
    );
  }
}
