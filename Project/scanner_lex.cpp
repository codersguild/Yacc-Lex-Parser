#include <iostream>
#include <stdio.h>
#include "scanner.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

int main(void)
{
	int ntokens;
	ntokens = yylex();
	while(ntokens)
	{
		std::cout << yytext << ",";
		printf("%d\n", ntokens);
		ntokens = yylex();
	}
	return 0;
}
