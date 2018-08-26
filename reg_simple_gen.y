%{

void yyerror (char *s);
int yylex();
#include <iostream>
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>
#include <utility>
#include <ctype.h>
#include <sstream>
#include <unordered_map>
std::unordered_map<std::string, int> symbol_table;
int symbolVal(const char* symbol);
void updateSymbolVal(const char* symbol, int val);
extern int yyparse();
%}

%union {int num; const char* id;}         /* Yacc definitions */
%start line
%token print
%token exit_command
%token <num> number
%token <id> identifier
%type <num> line exp term 
%type <id> assignment

%%

/* descriptions of expected inputs     corresponding actions (in C) */

line    : assignment 		';'		{;}
		| exit_command 		';'		{printf("Exit Command.\n"); exit(EXIT_SUCCESS);}
		| print exp 		';'		{printf("Printing Result : %d\n", $2);}
		| line assignment 	';'		{;}
		| line print exp 	';'		{printf("Printing Result : %d\n", $3);}
		| line exit_command ';'		{printf("Exit Command.\n"); exit(EXIT_SUCCESS);}
		;

assignment 	: identifier '=' exp  { updateSymbolVal($1, $3); }
			;

exp    	: term                  { $$ = $1;		}
       	| exp '+' term          { $$ = $1 + $3;	}
       	| exp '-' term          { $$ = $1 - $3;	}
       	| exp '*' term          { $$ = $1 * $3;	}
       	| exp '/' term          { $$ = $1 / $3;	}
       	| '(' exp ')' 			{ $$ = $2; }
       	;

term   	: number                { $$ = $1;	}
		| identifier			{ $$ = symbolVal($1); } 
        ;

%%       /* C code */

/* returns the value of a given symbol from symbol table */
int symbolVal(const char* symbol)
{
	std::string find(symbol);
	std::cout << "Symbol Table : " << find << std::endl;
	return symbol_table[find];
}

/* updates the value of a given symbol in symbol table */
void updateSymbolVal(const char* symbol, int val)
{
	std::stringstream ss;
	ss << symbol;
	std::string input = "";
	getline(ss, input, ' ');
	std::cout << "Symbol Updated : " << input << ", " << val << std::endl;
	symbol_table[input] = val;
}

int main (void) {
	return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

