%{
#include <iostream>
#include <cstdlib>
#include <cstring>

// Function to handle errors
void yyerror(const char *s) {
    std::cerr << "Error: " << s << std::endl;
}

// Function to report unexpected characters
void report_unexpected_char(char c) {
    std::cerr << "Unexpected character: 0x" << std::hex << (unsigned int)(unsigned char)c << std::dec << std::endl;
}
%}

DIGIT       [0-9]
LETTER      [a-zA-Z]
ID          {LETTER}({LETTER}|{DIGIT})*
WHITESPACE  [ \t]+
NEWLINE     \n
CARRIAGE_RETURN \r

%%

{WHITESPACE}+ { /* Ignore whitespace */ }
"if"        { std::cout << "Token: IF\n"; }
"else"      { std::cout << "Token: ELSE\n"; }
"while"     { std::cout << "Token: WHILE\n"; }
"for"       { std::cout << "Token: FOR\n"; }
"and"       { std::cout << "Token: AND\n"; }
"or"        { std::cout << "Token: OR\n"; }
"not"       { std::cout << "Token: NOT\n"; }
"then"      { std::cout << "Token: THEN\n"; }
"+"         { std::cout << "Token: PLUS\n"; }
"-"         { std::cout << "Token: MINUS\n"; }
"*"         { std::cout << "Token: MULT\n"; }
"/"         { std::cout << "Token: DIV\n"; }
"%"         { std::cout << "Token: MODULO\n"; }
"="         { std::cout << "Token: ASSIGN\n"; }
"=="        { std::cout << "Token: EQ\n"; }
"!="        { std::cout << "Token: NEQ\n"; }
"<"         { std::cout << "Token: LT\n"; }
">"         { std::cout << "Token: GT\n"; }
"<="        { std::cout << "Token: LE\n"; }
">="        { std::cout << "Token: GE\n"; }
","         { std::cout << "Token: COMMA\n"; }
";"         { std::cout << "Token: SEMICOLON\n"; }
"("         { std::cout << "Token: LPAREN\n"; }
")"         { std::cout << "Token: RPAREN\n"; }

{ID}        { 
                std::string identifier = yytext; 
                std::cout << "Token: IDENTIFIER, Value: " << identifier << std::endl; 
            }
{DIGIT}+    { 
                int number = std::atoi(yytext); 
                std::cout << "Token: INTEGER, Value: " << number << std::endl; 
            }

{NEWLINE}+      { /* Ignore newlines */ }
{CARRIAGE_RETURN}+ { /* Ignore carriage returns */ }

. {
    report_unexpected_char(yytext[0]);
}

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    yylex();
    return 0;
}
