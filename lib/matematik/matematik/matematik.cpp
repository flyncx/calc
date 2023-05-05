#ifdef WIN32
   #define EXPORT __declspec(dllexport)
#else
   #define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

#include "Token.h"
#include "Evaluator.h"


EXPORT 
double evaluateString(char *str){
   auto token = evaluateStringToken(str);
   return token.value;
}
