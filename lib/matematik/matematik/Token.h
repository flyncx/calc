#pragma once
#include <string>
#include <vector>
#include <memory>

enum TokenType { number, plus, minus, times, divide, unplus, unminus};

std::string getTokenTypeString(TokenType type);


class Token {
public:
	std::string text;
	TokenType type;
	bool isOperator = false;
	bool isCommaHostage = false;
	bool isLeftAssociative = true;
	int priority = 10;
	double value = 0.0;

	Token(std::string txt, double value, TokenType type) : text(txt), value(value), type(type) {}
	Token(std::string txt, double value, TokenType type, bool isCommaHostage) : text(txt), value(value), type(type), isCommaHostage(isCommaHostage) {}
	Token(std::string txt, double value, TokenType type, bool isOp, int priority) : text(txt), value(value), type(type), isOperator(isOp), priority(priority) {}
	Token(std::string txt, double value, TokenType type, bool isOp, bool isLeftAssociative, int priority) : text(txt), value(value), type(type), isOperator(isOp), priority(priority), isLeftAssociative(isLeftAssociative) {}
};

std::vector<std::unique_ptr<Token>>* shuntingYard(std::vector<std::unique_ptr<Token>>* tokens);
