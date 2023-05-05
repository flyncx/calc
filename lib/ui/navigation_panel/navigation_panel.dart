import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationPanel extends StatefulWidget {
  final Function(String settings) close;
  const NavigationPanel({super.key, required this.close});

  @override
  State<StatefulWidget> createState() {
    return _NavigationPanelState();
  }
}

class _NavigationPanelState extends State<NavigationPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.alphaBlend(
            Colors.white.withAlpha(10), const Color.fromRGBO(32, 32, 32, 1)),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 40, bottom: 46),
              child: Column(children: [
                const PanelLabel("Calculator"),
                PanelButton(
                  "Standard Mode",
                  FluentIcons.calculator_16_regular,
                  onPressed: () => widget.close("/standard"),
                )
              ]),
            ),
          ),
          Positioned.fill(
              child: Column(
            children: [
              Container(
                height: 40,
                color: Color.alphaBlend(Colors.white.withAlpha(10),
                    const Color.fromRGBO(32, 32, 32, 1)),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  widget.close('/settings');
                },
                style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.zero,
                            topRight: Radius.zero,
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.circular(16)))),
                child: Row(children: [
                  const SizedBox(width: 4),
                  const Icon(
                    FluentIcons.question_circle_20_regular,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "About",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter()
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),
                ]),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class PanelLabel extends StatelessWidget {
  final String text;

  const PanelLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 40,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.inter().copyWith(color: Colors.white),
      ),
    );
  }
}

class PanelButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const PanelButton(this.label, this.icon,
      {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.alphaBlend(
          Colors.white.withAlpha(10), const Color.fromRGBO(32, 32, 32, 1)),
      height: 42,
      width: double.infinity,
      child: TextButton(
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: Row(children: [
          const SizedBox(width: 4),
          Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 13),
          ),
        ]),
      ),
    );
  }
}
