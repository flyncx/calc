import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardDisplay extends StatelessWidget {
  final bool isResultHidden;
  final String expression;
  final String result;
  const StandardDisplay({
    super.key,
    required this.isResultHidden,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 125),
          height: isResultHidden ? 70 : 50,
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  expression,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.inter()
                      .copyWith(color: Colors.white, fontSize: 40),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 125),
          height: isResultHidden ? 0 : 70,
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  "=$result",
                  textAlign: TextAlign.end,
                  style: GoogleFonts.inter().copyWith(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
