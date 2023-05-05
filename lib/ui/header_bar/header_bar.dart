import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderBar extends StatelessWidget {
  final String text;
  const HeaderBar(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 52,
        ),
        Container(
          margin: const EdgeInsets.only(top: 9),
          child: Text(
            text,
            style: GoogleFonts.inter().copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
