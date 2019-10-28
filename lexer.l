%option yylineno
%pointer

%{
    #include <cstdlib>
    #include <cerrno>
    #include <climits>
    #include <limits>
    #include "parser.hpp"
    
	void yyerror(const char *);
%}

/* WRITEME: Write any definitions here. You can find information on
            definitions here:
            ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC10 */

/* WRITEME: If you are going to use start conditions, write them here.
            You can find more information on start conditions here:
            ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC11
            You will probably want to use exclusive conditions rather
            than inclusive conditions (use the %x instead of the %s). */
%x COMMENT

%%
 /* WRITEME: Write your Flex token rules here */

"/*"                  { BEGIN(COMMENT); }
<COMMENT>.            ;
<COMMENT>\n           ;
<COMMENT><<EOF>>      { yyerror("dangling comment"); }
<COMMENT>"*/"         { BEGIN(INITIAL); }
 

0|[1-9][0-9]*         { return T_NUMBER; }
"+"                   { return T_PLUS; }
"-"                   { return T_MINUS; }
"*"                   { return T_MULTIPLY; }
"/"                   { return T_DIVIDE; }
">"                   { return T_LARGERTHAN; }
">="                  { return T_LARGEREQUAL; }
"equals"              { return T_EQUALS; }
"and"                 { return T_AND; }
"or"                  { return T_OR; }
"not"                 { return T_NOT; }
"("                   { return T_OPENPAREN; }
")"                   { return T_CLOSEPAREN; }
"{"                   { return T_OPENBRACE; }
"}"                   { return T_CLOSEBRACE; }
"return"              { return T_RETURN; }
"integer"             { return T_INTEGER; }
"boolean"             { return T_BOOLEAN; }
"none"                { return T_NONE; }
"print"               { return T_PRINT; }
"if"                  { return T_IF; }
"else"                { return T_ELSE; }
"while"               { return T_WHILE; }
"new"                 { return T_NEW; }
"true"                { return T_TRUE; }
"false"               { return T_FALSE; }
"extends"             { return T_EXTENDS; }
"do"                  { return T_DO; }
[ \t\n]               ;
"."                   { return T_DOT; }
","                   { return T_COMMA; }
";"                   { return T_SEMICOLON; }
"->"                  { return T_ARROW; }
[a-z][a-z0-9]*        { return T_ID; }
"="                   { return T_ASSIGN; }

/* Not requied but good to have */       
"=="                  { return T_EQUALS; } 
"&&"                  { return T_AND; }
"||"                  { return T_OR; }
"elif"                { return T_ELIF; }
"<"                   {return T_LESSTHAN; }
"<="                  {return T_LESSEQUAL; }

.                     { yyerror("invalid character"); }

%%

int yywrap(void) {
  return 1;
}
