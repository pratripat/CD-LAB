%{
#include<stdio.h>
#include<stdlib.h>
int counter=0;
int state;
char* BSF,*BSPP,*HBA;
char* classify_bsf(int x){
	if (x>=66 && x<=116) return "N";
	if (x>=56 && x<66) return "L";
	if (x<56) return "VL";
	if (x>116 && x<=132) return "H";
	if (x>132) return "VH";
}

char* classify_bspp(int x){
        if (x>=67 && x<=147) return "N";
        if (x>=56 && x<67) return "L";
        if (x<56) return "VL";
        if (x>147 && x<=168) return "H";
        if (x>168) return "VH";
}

char* classify_hba(float x){
        if (x>=3.8 && x<=6.3) return "N";
        if (x>=3.2 && x<3.8) return "L";
        if (x<3.2) return "VL";
        if (x>6.3 && x<=7.2) return "H";
        if (x>7.2) return "VH";
}

%}
ws [ \t]
day 0[1-9]|[1-2][0-9]|3[0-1]
month 0[1-9]|1[0-2]
date {day}-{month}-20[0-9][0-9]
name [A-Z][a-z]+
real [0-9]+\.[0-9]+
int [0-9]+
bsf "BS(F)"{ws}*
bspp "BS(PP)"{ws}*
hba1c "HBA1C"{ws}*
%option noyywrap
%%
{date} {printf("Patient No. %d:%s ",counter,yytext);++counter;}
{name} {printf("%s ",yytext);}
{bsf} {printf("%s ",yytext);state=1;}
{bspp} {printf("%s ",yytext);state=2;}
{hba1c} {printf("%s ",yytext);}
{int} {if (state==1){printf("%s",yytext);BSF=classify_bsf(atoi(yytext));} 
       if (state==2){printf("%s",yytext);BSPP=classify_bspp(atoi(yytext));}}
{real} {printf("%s",yytext);HBA=classify_hba(atof(yytext));}
[\n] {printf("||F:%s;PP:%s;HBA1C:%s\n",BSF,BSPP,HBA);}	
%%
int main(){
        yylex();
        return 0;
}
