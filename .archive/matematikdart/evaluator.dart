part of matematik;

class Evaluator {
  Token evaluate(List<Token> rpnTokens) {
    final List<Token> stack = [];
    for (var token in rpnTokens) {
      if (token.type.isOperator == false) {
        stack.add(token);
      }
      if (token.type == TokenType.unminus) {
        if (stack[1].value!.isNegative) {
          var abs = stack[1].value!.abs();
          stack[1] = Token(abs.toString(), stack[1].type, abs);
        } else {
          var negated = -stack[1].value!;
          stack[1] = Token(negated.toString(), stack[1].type, negated);
        }
      }
      if (token.type == TokenType.unplus) {
        // do nothing
      }
      if (token.type.isOperator == true &&
          token.type.isLeftAssociative == true) {
        Token? result;
        if (stack.length == 1) {}
        var second = stack.removeLast();

        var first = stack.removeLast();

        switch (token.type) {
          case TokenType.div:
            result = divide(first, second);
            break;
          case TokenType.minus:
            result = minus(first, second);
            break;
          case TokenType.plus:
            result = plus(first, second);
            break;
          case TokenType.times:
            result = times(first, second);
            break;
          case TokenType.unminus:
          case TokenType.unplus:
          case TokenType.number:
            throw Exception("notimplemented");
        }

        if (result != null) {
          stack.add(result);
        }
      }
    }
    final last = stack.removeLast();

    return last;
  }

  Token evaluateWithPrecision(List<Token> rpnTokens, int precision) {
    var evaluated = evaluate(rpnTokens);
    var fixed = double.parse(evaluated.text).toStringAsPrecision(precision);
    // remove trailing zeros 0.300000000000000 to 0.3
    var rtz = double.parse(fixed);
    var token = Token(rtz.toString(), TokenType.number, rtz);
    return token;
  }

  Token divide(Token a, Token b) {
    if (a.type != TokenType.number || b.type != TokenType.number) {
      throw const FormatException("a or b is not a number token");
    }
    final result = a.value! / b.value!;
    return Token(
        removeUnecessaryDecimal(result.toString()), TokenType.number, result);
  }

  Token times(Token a, Token b) {
    if (a.type != TokenType.number || b.type != TokenType.number) {
      throw const FormatException("a or b is not a number token");
    }
    final result = a.value! * b.value!;
    return Token(
        removeUnecessaryDecimal(result.toString()), TokenType.number, result);
  }

  Token minus(Token a, Token b) {
    if (a.type != TokenType.number || b.type != TokenType.number) {
      throw const FormatException("a or b is not a number token");
    }

    final result = a.value! - b.value!;
    return Token(
        removeUnecessaryDecimal(result.toString()), TokenType.number, result);
  }

  Token plus(Token a, Token b) {
    if (a.type != TokenType.number || b.type != TokenType.number) {
      throw const FormatException("a or b is not a number token");
    }

    final result = a.value! + b.value!;
    return Token(
        removeUnecessaryDecimal(result.toString()), TokenType.number, result);
  }

  String removeUnecessaryDecimal(String str) {
    final splitted = str.split('.');
    if (splitted.length == 2) {
      if (splitted.last == "0") {
        return splitted.first;
      }
    }
    return str;
  }
}
