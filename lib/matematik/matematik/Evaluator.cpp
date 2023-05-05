#include "Evaluator.h"
#include <algorithm>
#include <iostream>


Token evaluateStringToken(char *strfx){
	std::string expression(strfx);
    std::vector<std::unique_ptr<Token>>* _tokens = new std::vector<std::unique_ptr<Token>>();
    for (char &karakter : expression) {
        bool isDigit = std::isdigit(karakter);
        if (isDigit) {
            if (_tokens->empty() == true) {
                _tokens->push_back(std::make_unique<Token>(Token(std::string(1, karakter),std::stod(std::string(1, karakter)), TokenType::number)));
            }
            else {
                auto back = _tokens->back().get();
                if (back->type == TokenType::number)
                {
					back->text = back->text + std::string(1, karakter);
					
					if (back->isCommaHostage == true) {
						std::replace(back->text.begin(), back->text.end(), ',', '.');
					}
					back->value = std::stod(back->text);
                }
                else
                {
                    _tokens->push_back(std::make_unique<Token>(Token(std::string(1, karakter),std::stod(std::string(1, karakter)), TokenType::number)));
                }
            }
            
        }
        else {
            switch (karakter) {
			case ',' :
				if (_tokens->empty()==false) {
					auto ref = _tokens->back().get();
					if (ref->type != number) {
						_tokens->push_back(std::make_unique<Token>(Token(std::string(1, '0'), std::stod(std::string(1, '0')), TokenType::number)));
						ref = _tokens->back().get();
					}
					if (ref->isCommaHostage == false) {
						ref->text = ref->text + ",";
						ref->isCommaHostage = true;
					}
				}
				break;
            case '-':
                _tokens->push_back(std::make_unique<Token>(Token(std::string(1, karakter), 0.0, TokenType::minus, true, 1)));
                break;
            case '+':
                _tokens->push_back(std::make_unique<Token>(Token(std::string(1, karakter), 0.0, TokenType::plus, true, 1)));
                break;
            case '/':
                _tokens->push_back(std::make_unique<Token>(Token(std::string(1, karakter), 0.0, TokenType::divide, true, 2)));
                break;
            case '*':
                _tokens->push_back(std::make_unique<Token>(Token(std::string(1, karakter), 0.0, TokenType::times, true, 2)));
                break;
			case ' ':
				break;
            default:
				std::cout << "ignored -> " << karakter << std::endl;
                break;
            }
        } 
    }
	auto shunted = shuntingYard(_tokens);
	auto result = evaluateRPNToken(shunted);
    return result;
}

Token evaluateRPNToken(std::vector<std::unique_ptr<Token>> *rpn) {
	std::vector<Token> stackfz;
	for (auto it = rpn->begin(); it != rpn->end(); it++) {
		Token token = *it->get();
		// push non-op to stack
		if (token.isOperator == false) {
			stackfz.push_back(token);
			continue;
		}
		if (token.type == TokenType::unminus) {
			bool isNegative = (stackfz[1].value >= 0.0) == false;
			if (isNegative) {
				stackfz[1].value = std::abs(stackfz[1].value);
				stackfz[1].text = stackfz[1].text.erase(0, 1);
			}
			else {
				stackfz[1].value = -(stackfz[1].value);
				stackfz[1].text = "-" + stackfz[1].text;
			}
			continue;
		}
		if (token.type == TokenType::unplus) {
			// do nothing
			continue;
		}
		if (token.isOperator == true &&
			token.isLeftAssociative == true) {
			auto sb = stackfz.back();
			auto second = sb;
			stackfz.pop_back();

			auto fb = stackfz.back();
			auto first = fb;
			stackfz.pop_back();

			switch (token.type) {
			case TokenType::divide:
				stackfz.push_back(dividex(first.value, second.value));
				break;
			case TokenType::minus:
				stackfz.push_back(minusx(first.value, second.value));
				break;
			case TokenType::plus:
				stackfz.push_back(plusx(first.value, second.value));
				break;
			case TokenType::times:
				stackfz.push_back(timesx(first.value, second.value));
				break;
			case TokenType::unminus:
			case TokenType::unplus:
			case TokenType::number:
				throw std::exception("notimplemented");
			}
		}
	}
	
	return stackfz[0];
}

Token dividex(double a, double b) {
	double res = a / b;
	return Token(std::to_string(res), res, TokenType::number);
}
Token timesx(double a, double b) {
	double res = a * b;
	return Token(std::to_string(res), res, TokenType::number);
}
Token plusx(double a, double b) {
	double res = a + b;
	return Token(std::to_string(res), res, TokenType::number);
}
Token minusx(double a, double b) {
	double res = a - b;
	return Token(std::to_string(res), res, TokenType::number);
}