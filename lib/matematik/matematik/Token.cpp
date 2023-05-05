#include "Token.h"

std::string getTokenTypeString(TokenType type) {
	std::string result;
	switch (type)
	{
	case number:
		result = "angka";
		break;
	case plus:
		result = "tambah";
		break;
	case minus:
		result = "kurang";
		break;
	case times:
		result = "kali";
		break;
	case divide:
		result = "bagi";
		break;
	case unplus:
		result = "unaryTambah";
		break;
	case unminus:
		result = "unaryKurang";
		break;
	default:
		result = "unknown";
		break;
	}
	return result;
}

std::vector<std::unique_ptr<Token>>* shuntingYard(std::vector<std::unique_ptr<Token>> *tokens) {
	auto outputStream = new std::vector<std::unique_ptr<Token>>;
	std::vector<std::unique_ptr<Token>> operatorBuffer;
	std::unique_ptr<Token> prevToken;
	for(auto it = tokens->begin(); it != tokens->end(); it++){
		Token token = *it->get();

		// If the current Token is a number, put them into the output stream.
		if (token.type == TokenType::number) {
			outputStream->push_back(std::make_unique<Token>(token));
			prevToken = std::make_unique<Token>(token);
			continue;
		}

		/* if the current Tokens type is PLUS or MINUS and the previous Token is an operator 
		*  or we're at the beginning of the expression (prevToken == null) the current Token is
		*  an unary plur or minus, so the tokentype has to be changed. */
		if (
			(token.type == TokenType::minus || token.type == TokenType::plus)&&
			(prevToken==nullptr||prevToken->isOperator==true)
			)
		{
			if (token.type == TokenType::minus) {
				operatorBuffer.push_back(std::make_unique<Token>(Token(token.text, token.value,TokenType::unminus, token.isOperator, token.priority)));
				prevToken = std::make_unique<Token>(Token(token.text, token.value, TokenType::unminus, true, false, 3));
			}
			else {
				operatorBuffer.push_back(std::make_unique<Token>(Token(token.text, token.value,TokenType::unplus, token.isOperator, token.priority)));
				prevToken = std::make_unique<Token>(Token(token.text, token.value,TokenType::unplus, true, false, 3));
			}
			continue;
		}
		/*
		* If the current token is an operator and it's priority is lower than the priority of the last
		* operator in the operator buffer, than put the operators from the operator buffer into the output
		* stream until you find an operator with a priority lower or equal as the current tokens.
		* Then add the current Token to the operator buffer.
		*/
		if (token.isOperator == true) {
			while (operatorBuffer.empty() == false &&
				((token.isLeftAssociative &&
					token.priority <=
					operatorBuffer.back().get()->priority ||
					(!token.isLeftAssociative &&
						token.priority <
						operatorBuffer.back().get()->priority)))){
				auto back = operatorBuffer.back().get();
				outputStream->push_back(std::make_unique<Token>(Token(back->text, back->value,back->type, back->isOperator, back->isLeftAssociative, back->priority)));
				operatorBuffer.pop_back();
			}
			operatorBuffer.push_back(std::make_unique<Token>(token));
			prevToken = std::make_unique<Token>(token);
			continue;
		}
		prevToken = std::make_unique<Token>(token);
	}

	/*
	 * When the algorithm reaches the end of the input stream, we add the
	 * tokens in the operatorBuffer to the outputStream.
	 */
	while (operatorBuffer.empty()==false) {
		auto back = operatorBuffer.back().get();
		outputStream->push_back(std::make_unique<Token>(Token(back->text,back->value, back->type, back->isOperator, back->isLeftAssociative, back->priority)));
		operatorBuffer.pop_back();
	}
	return outputStream;
};