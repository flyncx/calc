part of matematik;

/// The lexer creates tokens (see [TokenType] and [Token]) from an input string.
/// The input string is expected to be in
/// [infix notation form](https://en.wikipedia.org/wiki/Infix_notation).
/// The lexer can convert an infix stream into a
/// [postfix stream](https://en.wikipedia.org/wiki/Reverse_Polish_notation)
/// (Reverse Polish Notation) for further processing by a [Parser].
class Lexer {
  final Map<String, TokenType> keywords = <String, TokenType>{};

  /// Buffer for numbers
  String intBuffer = '';

  /// Buffer for variable and function names
  String varBuffer = '';

  /// Creates a new lexer.
  Lexer() {
    keywords['+'] = TokenType.plus;
    keywords['-'] = TokenType.minus;
    keywords['*'] = TokenType.times;
    keywords['×'] = TokenType.times;
    keywords['÷'] = TokenType.div;
    keywords['/'] = TokenType.div;
    //keywords['%'] = TokenType.MOD;
    //keywords['^'] = TokenType.POW;
    //keywords['!'] = TokenType.FACTORIAL;
    //keywords['nrt'] = TokenType.ROOT;
    //keywords['sqrt'] = TokenType.SQRT;
    //keywords['log'] = TokenType.LOG;
    //keywords['cos'] = TokenType.COS;
    //keywords['sin'] = TokenType.SIN;
    //keywords['tan'] = TokenType.TAN;
    //keywords['arccos'] = TokenType.ACOS;
    //keywords['arcsin'] = TokenType.ASIN;
    //keywords['arctan'] = TokenType.ATAN;
    //keywords['abs'] = TokenType.ABS;
    //eywords['ceil'] = TokenType.CEIL;
    //keywords['floor'] = TokenType.FLOOR;
    //keywords['sgn'] = TokenType.SGN;
    //keywords['ln'] = TokenType.LN;
    //keywords['e'] = TokenType.EFUNC;
    //keywords['('] = TokenType.LBRACE;
    //keywords[')'] = TokenType.RBRACE;
    //keywords['{'] = TokenType.LBRACE;
    //keywords['}'] = TokenType.RBRACE;
    //keywords[','] = TokenType.SEPAR;
  }

  /// Tokenizes a given input string.
  /// Returns a list of [Token] in infix notation.
  List<Token> tokenize(String inputString) {
    final List<Token> tempTokenStream = <Token>[];
    final String clearedString = inputString.replaceAll(' ', '').trim();
    final RuneIterator iter = clearedString.runes.iterator;

    while (iter.moveNext()) {
      final String si = iter.currentAsString;

      /*
       * Check if the current Character is a keyword. If it is a keyword, check if the intBuffer is not empty and add
       * a Value Token for the intBuffer and the corresponding Token for the keyword.
       */
      bool keywordsContainsKey = keywords.containsKey(si);

      /*
      * There's a situation that 'ceil' conflict with 'e', we use this to look back the buffer and decide
      * which way should go.
      */
      if (si == 'e' && varBuffer.isNotEmpty) {
        keywordsContainsKey = false;
      }

      if (keywordsContainsKey) {
        // check and or do intBuffer and varBuffer
        if (intBuffer.isNotEmpty) {
          _doIntBuffer(tempTokenStream);
        }
        if (varBuffer.isNotEmpty) {
          _doVarBuffer(tempTokenStream);
        }
        //// MH - Bit of a hack here to handle exponentials of the form e^x rather than e(x)
        //if (keywords[si] == TokenType.POW &&
        //    tempTokenStream.last.type == TokenType.EFUNC) {
        //  // Clear varBuffer since we have nothing to add to the stream as EFUNC is already in it
        //  //_doVarBuffer(tempTokenStream);
        //  varBuffer = '';
        //} else {
        // Normal behaviour
        tempTokenStream.add(Token(si, keywords[si]!, null));
        //}
      } else {
        // Check if the current string is a Number. If it's the case add the string to the intBuffer.
        StringBuffer sb = StringBuffer(intBuffer);
        try {
          int.parse(si);
          // The current string is a number and it is added to the intBuffer.
          sb.write(si);
          intBuffer = sb.toString();
          if (varBuffer.isNotEmpty) {
            _doVarBuffer(tempTokenStream);
          }
        } on FormatException {
          // Check if the current string is part of a floating point input
          if (si == '.') {
            sb.write(si);
            intBuffer = sb.toString();
            continue;
          }

          // The current string is not a number and not a simple keyword, so it has to be a variable or function.
          sb = StringBuffer(varBuffer);
          if (intBuffer.isNotEmpty) {
            /*
             * The intBuffer contains a string and the current string is a
             * variable or part of a complex keyword, so the value is added
             * to the token stream and the current string is added to the
             * var buffer.
             */
            _doIntBuffer(tempTokenStream);
            sb.write(si);
            varBuffer = sb.toString();
          } else {
            // intBuffer contains no string and the current string is a variable, so both Tokens are added to the tokenStream.
            sb.write(si);
            varBuffer = sb.toString();
          }
        }
      }
    }

    if (intBuffer.isNotEmpty) {
      // There are no more symbols in the input string but there is still an int in the intBuffer
      _doIntBuffer(tempTokenStream);
    }
    if (varBuffer.isNotEmpty) {
      // There are no more symbols in the input string but there is still a variable or keyword in the varBuffer
      _doVarBuffer(tempTokenStream);
    }
    return tempTokenStream;
  }

  /// Checks if the intBuffer contains a number and adds it to the tokenStream.
  /// Then clears the intBuffer.
  void _doIntBuffer(List<Token> stream) {
    stream.add(Token(intBuffer, TokenType.number, double.parse(intBuffer)));
    intBuffer = '';
  }

  /// Checks if the varBuffer contains a keyword or a variable and adds them to the tokenStream.
  /// Then clears the varBuffer.
  void _doVarBuffer(List<Token> stream) {
    if (keywords.containsKey(varBuffer)) {
      stream.add(Token(varBuffer, keywords[varBuffer]!, null));
    } else {
      //stream.add(Token(varBuffer, TokenType.VAR));
    }
    varBuffer = '';
  }

  /// Transforms the lexer's token stream into RPN using the Shunting-yard
  /// algorithm. Returns a list of [Token] in RPN form. Throws an
  /// [ArgumentError] if the list is empty.
  List<Token> shuntingYard(List<Token> stream) {
    if (stream.isEmpty) {
      throw FormatException('The given tokenStream was empty.');
    }

    final List<Token> outputStream = <Token>[];
    final List<Token> operatorBuffer = <Token>[];

    Token? prevToken;

    for (Token curToken in stream) {
      // If the current Token is a value or a variable, put them into the output stream.
      if (curToken.type == TokenType.number) {
        //|| curToken.type == TokenType.VAR) {
        outputStream.add(curToken);
        prevToken = curToken;
        continue;
      }

      /* // If the current Token is a function, put it onto the operator stack.
      if (curToken.type.function) {
        curToken.argCount = 1;
        operatorBuffer.add(curToken);
        prevToken = curToken;
        continue;
      } */

      /* /*
       *  If the current Token is a function argument separator, pop operators
       *  to output stream until a left brace is encountered.
       */
      if (curToken.type == TokenType.SEPAR) {
        while (operatorBuffer.isNotEmpty &&
            operatorBuffer.last.type != TokenType.LBRACE) {
          outputStream.add(operatorBuffer.removeLast());
        }

        if (operatorBuffer.length > 1) {
          var func = operatorBuffer[operatorBuffer.length - 2];
          if (func.type.function) {
            ++func.argCount;
          }
        }

        // If no left brace is encountered, separator was misplaced or parenthesis mismatch
        if (operatorBuffer.isNotEmpty &&
            operatorBuffer.last.type != TokenType.LBRACE) {
          //TODO never reached, check this.
          throw FormatException(
              'Misplaced separator or mismatched parenthesis.');
        }
        prevToken = curToken;
        continue;
      } */

      /* if the current Tokens type is PLUS or MINUS and the previous Token is an operator or type LBRACE
       * or we're at the beginning of the expression (prevToken == null) the current Token is
       * an unary plur or minus, so the tokentype has to be changed.
       */
      if ((curToken.type == TokenType.minus ||
              curToken.type == TokenType.plus) &&
          (prevToken == null ||
              //prevToken.type == TokenType.SEPAR ||
              //prevToken.type == TokenType.LBRACE ||
              prevToken.type.isOperator)) {
        final Token newToken = Token(
            curToken.text,
            curToken.type == TokenType.minus
                ? TokenType.unminus
                : TokenType.unplus,
            null);
        operatorBuffer.add(newToken);
        prevToken = newToken;
        continue;
      }

      /*
       * If the current token is an operator and it's priority is lower than the priority of the last
       * operator in the operator buffer, than put the operators from the operator buffer into the output
       * stream until you find an operator with a priority lower or equal as the current tokens.
       * Then add the current Token to the operator buffer.
       */
      if (curToken.type.isOperator) {
        while (operatorBuffer.isNotEmpty &&
            ((curToken.type.isLeftAssociative &&
                    curToken.type.priority <=
                        operatorBuffer.last.type.priority) ||
                (!curToken.type.isLeftAssociative &&
                    curToken.type.priority <
                        operatorBuffer.last.type.priority))) {
          outputStream.add(operatorBuffer.removeLast());
        }
        operatorBuffer.add(curToken);
        prevToken = curToken;
        continue;
      }

      /* // If the current Token is a left brace, put it on the operator buffer.
      if (curToken.type == TokenType.LBRACE) {
        operatorBuffer.add(curToken);
        prevToken = curToken;
        continue;
      } */

      /* // If the current Token is a right brace, empty the operator buffer until you find a left brace.
      if (curToken.type == TokenType.RBRACE) {
        while (operatorBuffer.isNotEmpty &&
            operatorBuffer.last.type != TokenType.LBRACE) {
          outputStream.add(operatorBuffer.removeLast());
        }

        // Expect next token on stack to be left parenthesis and pop it
        if (operatorBuffer.isEmpty ||
            operatorBuffer.removeLast().type != TokenType.LBRACE) {
          throw FormatException('Mismatched parenthesis.');
        }

        // If the token at the top of the stack is a function token, pop it onto the output queue.
        if (operatorBuffer.isNotEmpty && operatorBuffer.last.type.function) {
          outputStream.add(operatorBuffer.removeLast());
        }
      } */

      prevToken = curToken;
    }

    /*
     * When the algorithm reaches the end of the input stream, we add the
     * tokens in the operatorBuffer to the outputStream. If the operator
     * on top of the stack is a parenthesis, there are mismatched parenthesis.
     */
    while (operatorBuffer.isNotEmpty) {
      /* if (operatorBuffer.last.type == TokenType.LBRACE ||
          operatorBuffer.last.type == TokenType.RBRACE) {
        throw FormatException('Mismatched parenthesis.');
      } */
      outputStream.add(operatorBuffer.removeLast());
    }

    return outputStream;
  }

  /// This method invokes the createTokenStream methode to create an infix token
  /// stream and then invokes the shunting yard method to transform this stream
  /// into a RPN (reverse polish notation) token stream.
  List<Token> tokenizeToRPN(String inputString) {
    final List<Token> infixStream = tokenize(inputString);
    return shuntingYard(infixStream);
  }
}