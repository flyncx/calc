import 'dart:math';

import 'package:flutter/material.dart';

class AccurateCaptionIcon extends StatelessWidget {
  final Widget icon;

  AccurateCaptionIcon.close({super.key})
      : icon = Stack(
          children: [
            // Use rotated containers instead of a painter because it renders slightly crisper than a painter for some reason.
            Transform.rotate(
                angle: pi * .25,
                child: Center(
                    child:
                        Container(width: 13, height: 1, color: Colors.white))),
            Transform.rotate(
                angle: pi * -.25,
                child: Center(
                    child:
                        Container(width: 13, height: 1, color: Colors.white))),
          ],
        );

  AccurateCaptionIcon.maximize(bool isDisabled, {super.key})
      : icon = Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white.withOpacity(isDisabled ? .4 : 1)),
            borderRadius: BorderRadius.circular(2),
          ),
        );

  AccurateCaptionIcon.minimizeToTaskbar({super.key})
      : icon = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10, height: 5),
            Container(
              width: 10,
              height: 5,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white),
                ),
              ),
            )
          ],
        );

  @override
  Widget build(BuildContext context) {
    return icon;
  }
}
