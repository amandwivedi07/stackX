import 'package:flutter/material.dart';


class ReusableContainer extends StatelessWidget {
  double? height;
  double? width;
  Widget? child;
  ReusableContainer({this.height, this.width, this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
