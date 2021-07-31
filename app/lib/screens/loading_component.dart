import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showOverlay(BuildContext context, Function execute) async {
  final spinkit = const SpinKitFadingCircle(color: Colors.black);
  final child = Center(
    child: Container(
      width: 260,
      height: 250,
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: spinkit),
    ),
  );

  OverlayEntry entry = OverlayEntry(builder: (context) => child);
  Overlay.of(context).insert(entry);
  final result = await execute();
  entry.remove();
}
