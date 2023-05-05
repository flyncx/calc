import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MenuButton(this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4, top: 4),
      width: 40,
      height: 36,
      child: IconButton(
        onPressed: () => onPressed(),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          minimumSize: Size.zero,
          hoverColor: Colors.white.withAlpha(12),
        ),
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 5,
              decoration: BoxDecoration(
                border: Border(
                    top: const BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white.withOpacity(.5))),
              ),
            ),
            Container(
              width: 16,
              height: 5,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(.5)),
                  bottom: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
