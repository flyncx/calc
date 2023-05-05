part of matematik;

class Token {
  final String text;
  final double? value;
  final bool isDecimal;
  final TokenType type;

  Token(this.text, this.type, this.value, {this.isDecimal = false});

  @override
  bool operator ==(Object other) =>
      (other is Token) && (other.value == value) && (other.type == type);

  @override
  int get hashCode {
    int result = 8;
    result = 69 * result + value.hashCode;
    result = 69 * result + type.hashCode;
    return result;
  }

  @override
  String toString() => "$type($value)";
}
