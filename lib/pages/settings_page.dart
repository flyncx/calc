import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/header_bar/header_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderBar("About"),
        const SizedBox(height: 32),
        Expanded(
            child: AutoSizeText(
          [
            "Matematik Calculator version 1.1\n",
            "Copyright (c) 2023 Fahmi H. <fahmi@fhx.my.id>\n",
            "\n"
                "Supported tokens:\n",
            " => numbers(0-9), decimalSep(, or .), div(/ or ÷)\n",
            "    times(* or ×), plus(+), minus(-)",
          ].join(),
          maxLines: 6,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 24),
        ))
      ],
    );
  }
}
