%{
#include<stdio.h>
#include<limits.h>
#include<string.h>

int hl,size,day,hour,min;
char perms[10],owner[50],group[50],month[4],filename[100];
int ex_count=0;
int largest=INT_MIN,smallest=INT_MAX;
char largest_file[100],smallest_file[100];

int monthtonum(char*month){
  if (month[2]=='n' && month[1]=='a') return 1;
  if (month[2]=='b') return 2;
  if (month[2]=='r' && month[1]=='a') return 3;
  if (month[2]=='r' && month[1]=='p') return 4;
  if (month[2]=='y') return 5;
  if (month[2]=='n' && month[1]=='u') return 6;
  if (month[2]=='l') return 7;
  if (month[2]=='g') return 8;
  if (month[2]=='p') return 9;
  if (month[2]=='t') return 10;
  if (month[2]=='v') return 11;
  if (month[2]=='c') return 12;
  return 0;
}

struct timestamp{
  char filename[100];
  int month;
  int day;
  int hour;
  int min;
};
int compare_timestamps(struct timestamp t1, struct timestamp t2) {
  if (t1.month != t2.month) return (t1.month > t2.month) ? 1 : 2;
  if (t1.day != t2.day)     return (t1.day > t2.day) ? 1 : 2;
  if (t1.hour != t2.hour)   return (t1.hour > t2.hour) ? 1 : 2;
  if (t1.min != t2.min)     return (t1.min > t2.min) ? 1 : 2;
  return 1;
}

struct timestamp largest_t={"s",-1,-1,-1,-1};
struct timestamp smallest_t={"l",100,100,100,100};

%}

%option noyywrap

int [0-9]+
perms [d-]([r-][w-][x-]){3}
name [a-z][a-z0-9_-]*
date [A-Z][a-z]{2}[ \t]+{int}[ \t]+{int}:{int}
filename [A-Za-z0-9._,;-]+
ws [ \t]+
%%
{perms}{ws}{int}{ws}{name}{ws}{name}{ws}{int}{ws}{date}{ws}{filename} {
  sscanf(yytext,"%s %d %s %s %d %s %d %d:%d %s",perms,&hl,group,owner,&size,month,&day,&hour,&min,filename);

  if (hl==1 && perms[9]=='x'){ex_count++;} //a)

  if (size>largest){largest=size;strcpy(largest_file,filename);} //b)
  if (size<smallest){smallest=size;strcpy(smallest_file,filename);}

  if (perms[7]=='-' && perms[8]=='-' && perms[9]=='-'){printf("Resource unavailable to other(s): '%s'\n",filename);} //c)

  struct timestamp t;//d)
  strcpy(t.filename, filename);
  t.month = monthtonum(month);
  t.day   = day;
  t.hour  = hour;
  t.min   = min;
  if (compare_timestamps(t,smallest_t)==2) smallest_t=t;
  if (compare_timestamps(t,largest_t)==1) largest_t=t; 
  //printf("%s %d %s %s %d %s %d %d:%d %s\n",perms,hl,group,owner,size,month,day,hour,min,filename);
  //parintf("Ex_count=%d\n",ex_count);
  //printf("%c %c %c\n",perms[7],perms[8],perms[9]);
  }
. {}
[\n] {}
%%

int main(){
  yylex();
  printf("\nNo. of files/executables in the folder : %d\n",ex_count);
  printf("\nLargest File/Folder : '%s' (%d bytes)\nSmallest File/Folder : '%s' (%d bytes)\n",largest_file,largest,smallest_file,smallest);
  printf("\nOldest Resource:'%s'\nMost Recent Resource:'%s'\n",smallest_t.filename,largest_t.filename);
  return 0;
}
