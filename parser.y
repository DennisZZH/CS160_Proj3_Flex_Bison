%{
    #include <cstdlib>
    #include <cstdio>
    #include <iostream>

    #define YYDEBUG 1

    int yylex(void);
    void yyerror(const char *);
%}

%error-verbose

/* WRITEME: List all your tokens here */
%token T_NUMBER T_ID
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LARGERTHAN T_LARGEREQUAL T_EQUALS T_AND T_OR T_NOT T_ASSIGN
%token T_OPENPAREN T_CLOSEPAREN T_OPENBRACE T_CLOSEBRACE T_DOT T_COMMA T_SEMICOLON T_ARROW
%token T_RETURN T_EXTENDS T_DO T_NEW T_IF T_ELSE T_WHILE T_PRINT T_NONE
%token T_BOOLEAN T_INTEGER T_TRUE T_FALSE

/* WRITEME: Specify precedence here */
%left T_OR 
%left T_AND 
%left T_LARGERTHAN T_LARGEREQUAL T_EQUALS
%left T_PLUS T_MINUS 
%left T_MULTIPLY T_DIVIDE
%precedence T_NOT T_UNARYMINUS

%%

/* WRITEME: This rule is a placeholder, since Bison requires
            at least one rule to run successfully. Replace
            this with your appropriate start rules. */

Start : Classes
      ;

Classes : Classes Class
        | Class
        ;

Class : T_ID T_OPENBRACE Members Methods T_CLOSEBRACE
      | T_ID T_EXTENDS T_ID T_OPENBRACE Members Methods T_CLOSEBRACE
      ;

Members : Members Member
        | %empty
        ;

Methods : Method Methods
        | %empty
        ;

Member : Type T_ID T_SEMICOLON
       ;

Method : T_ID T_OPENPAREN Parameters T_CLOSEPAREN T_ARROW ReturnType T_OPENBRACE MethodBody T_CLOSEBRACE
       ;

Type : T_INTEGER
     | T_BOOLEAN
     | T_ID
     ;

Parameters : Parameters T_COMMA Parameter
           | Parameter
           | %empty
           ;

ReturnType : Type
           | T_NONE
           ;

MethodBody : Declarations Statements Return
           ;

Parameter : Type T_ID
          ;

Declarations : Declarations Declaration
             | %empty
             ;

Statements : Statements Statement
           | %empty
           ;

Return : T_RETURN Expression T_SEMICOLON
       | %empty
       ;

Declaration : Type Vairables T_SEMICOLON
            ;

Statement : Assignment
          | MethodCall
          | IfElse
          | While
          | DoWhile
          | Print
          ;

Expression : Expression T_PLUS Expression
           | Expression T_MINUS Expression                          
           | Expression T_MULTIPLY Expression                       
           | Expression T_DIVIDE Expression                        
           | Expression T_LARGERTHAN Expression                 
           | Expression T_LARGEREQUAL Expression              
           | Expression T_EQUALS Expression                 
           | Expression T_AND Expression                           
           | Expression T_OR Expression                             
           | T_NOT Expression
           | T_MINUS Expression   %prec T_UNARYMINUS
           | T_ID                                         
           | T_ID T_DOT T_ID                             
           | MethodCall                                   
           | T_OPENPAREN Expression T_CLOSEPAREN                
           | T_NUMBER                                     
           | T_TRUE                                      
           | T_FALSE                                     
           | T_NEW T_ID                              
           | T_NEW T_ID T_OPENPAREN Arguments T_CLOSEPAREN
           ;

Assignment : T_ID T_ASSIGN Expression T_SEMICOLON
           | T_ID T_DOT T_ID T_ASSIGN Expression T_SEMICOLON
           ;

MethodCall : T_ID T_OPENPAREN Arguments T_CLOSEPAREN
           | T_ID T_DOT T_ID T_OPENPAREN Arguments T_CLOSEPAREN
           ;

IfElse : T_IF Expression T_OPENBRACE BlockStatements T_CLOSEPAREN
       | T_IF Expression T_OPENBRACE BlockStatements T_CLOSEBRACE T_ELSE T_OPENBRACE BlockStatements T_CLOSEBRACE
       ;

While : T_WHILE Expression T_OPENBRACE BlockStatements T_CLOSEBRACE
      ;

DoWhile : T_DO T_OPENBRACE BlockStatements T_CLOSEBRACE T_WHILE T_OPENPAREN Expression T_CLOSEPAREN T_SEMICOLON
        ;

Print : T_PRINT Expression
      ;

Arguments : Arguments T_COMMA Expression
          | Expression
          | %empty
          ;

BlockStatements : BlockStatements Statement
                | Statement
                ;

Vairables : Vairables T_COMMA T_ID
          | T_ID
          ;

/* WRITME: Write your Bison grammar specification here */

%%

extern int yylineno;

void yyerror(const char *s) {
  fprintf(stderr, "%s at line %d\n", s, yylineno);
  exit(1);
}