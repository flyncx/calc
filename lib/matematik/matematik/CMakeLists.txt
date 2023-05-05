# CMakeList.txt : CMake project for matematik, include source and define
# project specific logic here.
#

# Add source to this project's executable.
add_executable (matematik "main.cpp" "main.h"         "Token.h"  "Token.cpp" "Evaluator.h" "Evaluator.cpp")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET matematik PROPERTY CXX_STANDARD 20)
endif()

# TODO: Add tests and install targets if needed.
