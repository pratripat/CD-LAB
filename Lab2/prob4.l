%{
#include<stdio.h>
int t1_counter=0,t2_counter=0,non_counter=0;
%}
%option noyywrap
%%
a+b* {t1_counter++;printf("T1 found: count=%d lexeme=%s \n",t1_counter,yytext);}
a*c* {t2_counter++;printf("T2 found: count=%d lexeme=%s \n",t2_counter,yytext);}
[ \n\t] {}
. {non_counter++;printf("Character %s is either not a lexeme or not in Alphabet : count=%d \n",yytext,non_counter);}


%%
int main(){
	yylex();
	printf("Statistics of tokens in input:\n |Token1|=%d; |Token2|=%d; |AllTokens|=%d\n",t1_counter,t2_counter,t1_counter+t2_counter);
	printf("No. of characters that are not lexemes/not in alphabet : %d\n",non_counter);
	return 0;
}
