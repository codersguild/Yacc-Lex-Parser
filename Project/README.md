Simple Lex example in ```*.l``` file.
```C++
%{
#include "scanner.h"
int nchar = 0, nwords = 0, nline = 0;
%}

%%
b*(ab*a)*b*		return TOKEN1;
(x*)			return TOKEN2;
c?(b|a)*c*		return TOKEN3;
^\+(([0-9])|(0)){2}	return COUNTRY_CODE;
([0-9]{10})		return FULL_PHONE;
%%

int yywrap(void){
	return 1;
}
```
In ```scanner.h```.

```C++
#define TOKEN1 1
#define TOKEN2 2
#define TOKEN3 3
#define FORMAT 4
#define COUNTRY_CODE 100000000
#define FULL_PHONE 200000000
```

In ```.cpp``` file.

```C++
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
```
