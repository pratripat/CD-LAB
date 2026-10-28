%{
#include <stdio.h>
int t1_c = 0, t2_c = 0, t3_c = 0;
%}%

%option noyywrap

%%

a+b* {t1_c++; printf("T1 found: count = %d lexemme: %s\n", t1_c, yytext);}
a*c* {t2_c++; printf("T2 found: count = %d lexemme: %s\n", t2_c, yytext);}
[ \n\t] { }
. {t3_c++; printf("Word %s is either not a lexemme or not part of alphabet. count = %d\n", yytext, t3_c);}

%%

int main() {
	yylex();
	printf("Statistics of tokens in input:\n |Token1|=%d; |Token2|=%d; |AllTokens|=%d\n",t1_c,t2_c,t1_c+t2_c);
	printf("No. of characters that are not lexemes/not in alphabet : %d\n",t3_c);
	return 0;
}
