import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  bool _spinning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    _sizeAnimation = Tween<double>(begin: 100, end: 300).animate(curved);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      body: Center(
        child: Column(
          children: [
            Text('Value ${_controller.value.toStringAsFixed(3)}'),
            Container(
              width: _sizeAnimation.value,
              color: Colors.blue,
              height: 100,
              // width: _controller.value * 300,
              // color: Colors.blue,
              // height: _controller.value * 300,
            ),
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.forward();
                  },
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.stop();
                  },
                  child: Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.reverse();
                  },
                  child: Text('Reverse'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.reset();
                  },
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.repeat();
                  },
                  child: Text('Repeat'),
                ),
              ],
            ),
            // Rotation Transition
            RotationTransition(
              turns: _controller,
              child: FlutterLogo(size: 200),
            ),
          ],
        ),
      ),
    );
  }
}
