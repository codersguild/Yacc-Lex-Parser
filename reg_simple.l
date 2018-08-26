%{

#include "y.tab.h"
void yyerror (char *s);
int yylex();

%}
%%

"calculate"			  	   	{ return print; }
"print"					       	{ return print; }
"exit"						      { return exit_command; }
[a-zA-Z][a-zA-Z0-9]*		{ yylval.id = yytext; return identifier; }
[0-9]+			            { yylval.num = atoi(yytext); return number; }
[ \t\n]                		;
[-+\(\)=/*\n;]          { return yytext[0]; }
.                      	{ ECHO;  yyerror(" unexpected character"); }

%%
int yywrap (void) 			{ return 1; }
