import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart' as bw;
import 'package:google_fonts/google_fonts.dart';

import 'caption_icon.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    var inter = GoogleFonts.inter();
    return SizedBox(
      height: 34,
      child: Stack(
        children: [
          Positioned.fill(
            child: bw.MoveWindow(
              child: Row(
                children: [
                  const SizedBox(width: 1 + 20 - 6),
                  const SizedBox(
                    height: 18,
                    child: Image(
                      image: AssetImage('assets/app_icon.png'),
                    ),
                  ),
                  const SizedBox(width: 14 + 6),
                  Text(
                    "Calculator",
                    style: inter.copyWith(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                width: 46,
                height: 34,
                child: IconButton(
                  onPressed: () {
                    bw.appWindow.minimize();
                  },
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    minimumSize: Size.zero,
                    hoverColor: Colors.white.withAlpha(25),
                    //hoverColor: Colors.white.withAlpha(25),
                  ),
                  icon: AccurateCaptionIcon.minimizeToTaskbar(),
                ),
              ),
              SizedBox(
                width: 46,
                height: 34,
                child: IconButton(
                  onPressed: null,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    minimumSize: Size.zero,
                    hoverColor: Colors.white.withAlpha(25),
                    disabledBackgroundColor: Colors.black.withAlpha(40),
                    //hoverColor: Colors.white.withAlpha(25),
                  ),
                  icon: AccurateCaptionIcon.maximize(true),
                ),
              ),
              SizedBox(
                width: 47,
                height: 34,
                child: IconButton(
                  onPressed: () {
                    bw.appWindow.close();
                  },
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    minimumSize: Size.zero,
                    hoverColor: const Color.fromRGBO(196, 43, 28, 1),
                    //hoverColor: Colors.white.withAlpha(25),
                  ),
                  icon: AccurateCaptionIcon.close(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
