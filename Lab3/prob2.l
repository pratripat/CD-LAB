%{
#include<stdio.h>
int kw,id,ints,assn,arithmetic,relational,lp,rp,delim,comm,chars,strings;
%}

%option noyywrap

pre "#".*
comment "//".*
kw "int"|"float"|"char"|"long"|"if"|"else"|"for"|"while"|"return"
id [A-Za-z_][A-Za-z0-9_]*
leftpar "["|"{"|"("
rightpar "]"|"}"|")"
hex "0x"[0-9A-Fa-f]+
int 0|[1-9][0-9]*
octal 0[0-7]+
float {int}\.{int}
char '([^'\\]|\\.)*'
str \"([^"\\]|\\.)*\"
arith [+*\-\\][=]*
rel "!"|"&&"|"||"|">="|"<="|"=="|">"|"<"


%%
{pre} {printf("Pre Processor Directive Ignored: %s\n",yytext);}
{kw} {printf("(Token,Lexeme)=(KEYWORD,%s)\n",yytext);kw++;}
{id} {printf("(Token,Lexeme)=(IDENTIFIER,%s)\n",yytext);id++;}
{leftpar} {printf("(Token,Lexeme)=(LEFTPAR,'%s')\n",yytext);lp++;}
{rightpar} {printf("(Token,Lexeme)=(RIGHTPAR,'%s')\n",yytext);rp++;}
{comment} {printf("Single Line Comment:\"%s\"\n",yytext);comm++;}
{int} {printf("(Token,Lexeme)=(INTEGER,%s)\n",yytext);ints++;}
{hex} {printf("(Token,Lexeme)=(HEXA NUMBER,%s)\n",yytext);}
{octal} {printf("(Token,Lexeme)=(OCTAL NUMBER,%s)\n",yytext);}
{char} {printf("(Token,Lexeme)=(CHARACTER LITERAL,%s)\n",yytext);chars++;}
{str} {printf("(Token,Lexeme)=(STRING ,%s)\n",yytext);strings++;}
{arith} {printf("(Token,Lexeme)=(ARITHMETIC_OP ,%s)\n",yytext);arithmetic++;}
{rel} {printf("(Token,Lexeme)=(RELATIONAL_OP ,%s)\n",yytext);relational++;}
";"|"," {printf("(Token,Lexeme)=(DELIMITER,'%s')\n",yytext);delim++;}
"=" {printf("(Token,Lexeme)=(ASSIGN_OP,'%s')\n",yytext);assn++;}
[\n]|. {}
%%

int main(){
	yylex();
	printf("\nDisplay Statistics of Tokens in Input\n\n");
	printf("Number of keywords : %d\n",kw);
	printf("Number of identifiers : %d\n",id);
	printf("Number of integers : %d\n",ints);
	printf("Number of assign operators : %d\n",assn);
	printf("Number of aritmetic operators : %d\n",arithmetic);
	printf("Number of relational operators : %d\n",relational);
	printf("Number of left parenthesis : %d\n",lp);
	printf("Number of right parenthesis : %d\n",rp);
	printf("Number of delimiters : %d\n",delim);
	printf("Number of single line comments : %d\n",comm);
	printf("Number of character literals : %d\n",chars);
	printf("Number of string literals : %d\n",strings);
	return 0;
}
