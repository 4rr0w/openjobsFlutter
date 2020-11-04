import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color color;

  const Loading({Key key, this.color: Colors.white}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color == Colors.white ? Colors.blueAccent : Colors.white,
      child: Center(
        child: SpinKitWave(
          color: color,
          size: 20.0,
        ),
      ),
    );
  }
}
