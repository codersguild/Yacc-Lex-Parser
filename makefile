calc: lex.yy.c y.tab.c
	g++ -std=c++17 -march=native -pedantic -O3 -g lex.yy.c y.tab.c -o simple_cfg

lex.yy.c: y.tab.c reg_simple.l
	flex reg_simple.l

y.tab.c: reg_simple_gen.y
	yacc -d reg_simple_gen.y

clean: 
	del lex.yy.c y.tab.c y.tab.h calc.exe

