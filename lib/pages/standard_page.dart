import 'package:calc/controllers/standard_keypad_controller.dart';
import 'package:calc/ui/header_bar/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/display/standard_display.dart';
import '../ui/keypad/standard_keypad.dart';

class StandardPage extends StatefulWidget {
  const StandardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StandardPageState();
  }
}

class _StandardPageState extends State<StandardPage> {
  String expression = '';
  String result = '';
  bool isResultHidden = true;
  @override
  void initState() {
    var standardKeypadController = Get.find<StandardKeypadController>();
    var rn = standardKeypadController.getResult();
    expression = standardKeypadController.getExpression();

    result = rn ?? "";
    isResultHidden = rn == null ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const HeaderBar("Standard"),
      Expanded(
        flex: 4,
        child: StandardDisplay(
          expression: expression,
          isResultHidden: isResultHidden,
          result: result,
        ),
      ),
      Expanded(
        flex: 6,
        child: StandardKeypad(
          onExpressionUpdate: (String value) {
            if (isResultHidden == false) {
              setState(() {
                isResultHidden = true;
              });
            }
            setState(() {
              expression = value;
            });
          },
          onResultUpdate: (String? value) {
            if (value == null) {
              setState(() {
                isResultHidden = true;
              });
              return;
            }
            setState(() {
              result = value;
              isResultHidden = false;
            });
          },
        ),
      ),
    ]);
  }
}
