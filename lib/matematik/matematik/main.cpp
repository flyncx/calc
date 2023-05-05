// main.cpp : Defines the entry point for the application.
//

#include "main.h"
#include <ostream>
#include <string>
#include <vector>
#include <algorithm>
#include <iomanip>
#include <conio.h>
#include "Evaluator.h"
#include "Token.h"

int main()
{
    std::cout << "/*" << std::endl;
    std::cout << "*  Matematik Interpreter (c) 2023 Fahmi Hidayat <fahmihidayatsch@gmail.com>" << std::endl;
    std::cout << "*  Supported char: * / + - ," << std::endl;
    std::cout << "*/" << std::endl;

    std::string expression;
    std::cout << "Input  : ";
    std::getline(std::cin, expression);
    auto result = evaluateStringToken(expression.data());
    std::cout << "Result : " << result.value << std::endl;
    std::cout  << std::endl <<"Press any key to exit...";
    getch();
    return 0;
}