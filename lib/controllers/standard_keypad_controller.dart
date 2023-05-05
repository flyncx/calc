import 'package:calc/bridge.dart';
import 'package:ffi/ffi.dart';
import 'package:get/get.dart';

class StandardKeypadController extends GetxController {
  String? _result;
  final List<String> strss = [];

  String? getResult() => _result;
  String getExpression() => strss.join();

  void directAdd(String value) {
    strss.add(value);
  }

  void operatorAdd(String value) {
    if (strss.isEmpty) strss.add("0");
    if (checkIfOperator(strss.last)) strss.removeLast();
    strss.add(value);
  }

  bool checkIfOperator(String target) {
    bool isOp;
    switch (target) {
      case '/':
      case '*':
      case '+':
      case '-':
      case '×':
      case '÷':
        isOp = true;
        break;
      default:
        isOp = false;
        break;
    }
    return isOp;
  }

  void percentAdd() {
    if (strss.isEmpty) return;
    if (checkIfOperator(strss.last)) strss.removeLast();
    if (strss.last == ',') strss.removeLast();
    strss.add('/100');
  }

  void decimalSepAdd() {
    if (strss.isEmpty) strss.add('0');
    bool hitAnother = false;
    for (var token in strss.reversed) {
      if (checkIfOperator(token)) break;
      if (token == ',') hitAnother = true;
    }

    if (hitAnother == false) {
      strss.add(',');
    }
  }

  void clearAll() {
    strss.clear();

    _result = null;
  }

  void backspace() {
    if (strss.isNotEmpty) strss.removeLast();
  }

  void evaluate() {
    if (strss.isEmpty) return;
    while (checkIfOperator(strss.last)) {
      strss.removeLast();
    }
    if (strss.last == ',') strss.removeLast();
    var pstr =
        strss.join().replaceAll('×', '*').replaceAll('÷', '/').toNativeUtf8();
    double precise16 = double.parse(MatematikFFI.evaluateString(
      pstr,
    ).toStringAsPrecision(16));

    _result = removeTrailingZero(precise16.toString()).replaceAll('.', ',');
  }

  String removeTrailingZero(String input) {
    final stack = input.split('.');
    if (stack.length == 2) {
      if (stack[1] == "0") {
        return stack[0];
      }
    }
    return input;
  }
}
