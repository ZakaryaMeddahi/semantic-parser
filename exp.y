%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(const char *s);
%}
%union{
int vale;
float valf;
}
%token<vale> NBI
%token<valf> NBF
%token NL 
%token ADD
%token SUB
%token MULT
%token DIV
%token OP
%token CP
%left ADD SUB
%left MULT DIV
%type<vale> expression
%type<valf> expressionf
%start calcul
%%
calcul : 
       |calcul exp
       ;
exp : NL
    |expression NL {printf("Result %i \n",$1);}
    |expressionf NL {printf("Result %f \n",$1);}
    ;
expression : NBI {$$=$1;}
           | expression ADD expression {$$=$1+$3;}
	   | expression SUB expression {$$=$1-$3;}
           | expression MULT expression {$$=$1*$3;}
	   | expression DIV expression {if($3 == 0) {printf("Can't Divide By Zero!"); exit(1);} else {$$=$1/$3;}}
	   | OP expression CP {$$=$2;}
           ;
expressionf : NBF {$$=$1;}
            | expressionf ADD expressionf {$$=$1+$3;}
            | expression ADD expressionf {$$=$1+$3;}
            | expressionf ADD expression {$$=$1+$3;}
            | expressionf SUB expressionf {$$=$1-$3;}
            | expression SUB expressionf {$$=$1-$3;}
            | expressionf SUB expression {$$=$1-$3;}
            | expressionf MULT expressionf {$$=$1*$3;}
            | expression MULT expressionf {$$=$1*$3;}
            | expressionf MULT expression {$$=$1*$3;}
            | expressionf DIV expressionf {if($3 == 0) {printf("Can't Divide By Zero!"); exit(1);} else {$$=$1/$3;}}
            | expression DIV expressionf {if($3 == 0) {printf("Can't Divide By Zero!"); exit(1);} else {$$=$1/$3;}}
            | expressionf DIV expression {if($3 == 0) {printf("Can't Divide By Zero!"); exit(1);} else {$$=$1/$3;}}
	    | OP expressionf CP {$$=$2;}
            ; 
%%

