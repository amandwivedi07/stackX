import 'package:flutter/material.dart';

import '../../../constant/global_variable.dart';


class SearchContainer extends StatelessWidget {
  IconData? icon;
  String? containerText;
  String? containerHeadText;
  SearchContainer({this.icon, this.containerText,this.containerHeadText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 45;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: GlobalVariables.textColor,
                  size: iconSize,
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  containerText!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                )
              ],
            ),
              const SizedBox(height: 10,),
              Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    containerHeadText!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
            ),
         
          ],
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
