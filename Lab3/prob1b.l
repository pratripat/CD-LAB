%{
#include<stdio.h>
#include<string.h>
int state,count=0,bsf,bspp;
char DATE[20] = "", NAME[50] = "";
float hba;

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

%option noyywrap

date (0[1-9]|[1-2][0-9]|3[0-1])-(0[1-9]|1[0-2])-[0-9]{4}
name [A-Z][a-z]+
hba "HBA1C"[ \t]+[0-9]+\.[0-9]+
bsf "BS(F)"[ \t]+[0-9]+
bspp "BS(PP)"[ \t]+[0-9]+

%%
{date} {strcpy(DATE,yytext);}
{name} {strcpy(NAME,yytext);}
{hba}  {sscanf(yytext,"HBA1C %f",&hba);}
{bsf}  {sscanf(yytext,"BS(F) %d",&bsf);}
{bspp} {sscanf(yytext,"BS(PP) %d",&bspp);}
\n     {printf("%d\t%s\t%s\t%d\t%d\t%.1f\t%s\t%s\t%s\n",++count,DATE,NAME,bsf,bspp,hba,classify_bsf(bsf),classify_bspp(bspp),classify_hba(hba));}
[ \t]  {} 
.      {}
%%

int main() {
    printf("Patient\tTest Date\tName\tBS(F)\tBS(PP)\tHBA1C\tF\tPP\tHBA1C\n");
    yylex();
    return 0;
}
