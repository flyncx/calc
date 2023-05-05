#pragma once

#include "Token.h"


Token evaluateRPNToken(std::vector<std::unique_ptr<Token>> *tokens);
Token evaluateStringToken(char* strfx);

Token dividex(double a, double b);
Token timesx(double a, double b);
Token plusx(double a, double b);
Token minusx(double a, double b);
