import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/standard_keypad_controller.dart';

class StandardKeypad extends StatelessWidget {
  final Function(String?) onResultUpdate;
  final Function(String) onExpressionUpdate;
  const StandardKeypad({
    super.key,
    required this.onResultUpdate,
    required this.onExpressionUpdate,
  });

  @override
  Widget build(BuildContext context) {
    var standardKeypadController = Get.find<StandardKeypadController>();
    var inter = GoogleFonts.inter(color: Colors.white);

    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
      child: Column(children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GlassButtonA(() {
                  standardKeypadController.clearAll();
                  onExpressionUpdate(standardKeypadController.getExpression());
                  onResultUpdate(standardKeypadController.getResult());
                },
                    Text(
                      "AC",
                      style: inter.copyWith(fontSize: 16),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonA(() {
                  standardKeypadController.backspace();
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "⌫",
                      style: inter.copyWith(fontSize: 16),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonA(() {
                  standardKeypadController.percentAdd();
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "%",
                      style: inter.copyWith(fontSize: 20),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonA(() {
                  standardKeypadController.operatorAdd("÷");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "÷",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("7");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "7",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("8");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "8",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("9");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "9",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonA(() {
                  standardKeypadController.operatorAdd("×");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "×",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("4");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "4",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("5");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "5",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("6");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "6",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonA(() {
                  standardKeypadController.operatorAdd("-");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "-",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("1");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "1",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("2");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "2",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("3");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "3",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonA(() {
                  standardKeypadController.operatorAdd("+");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "+",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("0");
                  standardKeypadController.directAdd("0");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "00",
                      style: inter.copyWith(fontSize: 20),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.directAdd("0");
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      "0",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonB(() {
                  standardKeypadController.decimalSepAdd();
                  onExpressionUpdate(standardKeypadController.getExpression());
                },
                    Text(
                      ",",
                      style: inter.copyWith(fontSize: 24),
                    )),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: GlassButtonC(() {
                  standardKeypadController.evaluate();
                  onExpressionUpdate(standardKeypadController.getExpression());
                  onResultUpdate(standardKeypadController.getResult());
                },
                    Text(
                      "=",
                      style: inter.copyWith(fontSize: 24, color: Colors.black),
                    )),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class GlassButtonA extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const GlassButtonA(this.onPressed, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        minimumSize: Size.zero,
        backgroundColor: Colors.white.withAlpha(21),
        hoverColor: Colors.white.withAlpha(12),
      ),
      icon: icon,
    );
  }
}

class GlassButtonB extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const GlassButtonB(this.onPressed, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        minimumSize: Size.zero,
        backgroundColor: Colors.white.withAlpha(31),
        hoverColor: Colors.black.withAlpha(37),
      ),
      icon: icon,
    );
  }
}

class GlassButtonC extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const GlassButtonC(this.onPressed, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        minimumSize: Size.zero,
        backgroundColor: Theme.of(context).primaryColorLight,
        hoverColor: Colors.black.withAlpha(37),
      ),
      icon: icon,
    );
  }
}
