import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Load extends StatelessWidget {
  Color color;
  Load({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDualRing(
        color: color,
        size: 100,
        ),
    );
  }
}