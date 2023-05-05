part of matematik;

class TokenType {
  final String text;
  final int priority;
  final bool isOperator;
  final bool isLeftAssociative;

  // Number
  static const TokenType number = TokenType._construct('angka', priority: 10);

  // Operators
  static const TokenType plus =
      TokenType._construct('tambah', priority: 1, isOperator: true);
  static const TokenType minus =
      TokenType._construct('kurang', priority: 1, isOperator: true);
  static const TokenType times =
      TokenType._construct('kali', priority: 2, isOperator: true);
  static const TokenType div =
      TokenType._construct('bagi', priority: 2, isOperator: true);
  static const TokenType unplus = TokenType._construct(
    'untambah',
    priority: 3,
    isOperator: true,
    isLeftAssociative: false,
  );
  static const TokenType unminus = TokenType._construct(
    'unaryKurang',
    priority: 3,
    isOperator: true,
    isLeftAssociative: false,
  );

  const TokenType._construct(
    this.text, {
    required this.priority,
    this.isOperator = false,
    this.isLeftAssociative = true,
  });

  @override
  String toString() => text;
}
