%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int current_line = 1;
int current_column = 1;
#define MAX_ID_LENGTH 15

void print_token(const char* lexeme, const char* token_type) {
    if (strcmp(lexeme, token_type) == 0) {
        printf("%s %s\n", lexeme, token_type);
    } else {
        printf("%s - %s\n", lexeme, token_type);
    }
}

void report_lexical_error(const char* lexeme, const char* error_message) {
    printf("%s - erro - %s\n", lexeme, error_message);
}

%}

%x COMMENT

%%

"program"   { print_token(yytext, "program"); current_column += yyleng; }
"var"       { print_token(yytext, "var"); current_column += yyleng; }
"real"      { print_token(yytext, "real"); current_column += yyleng; }
"integer"   { print_token(yytext, "integer"); current_column += yyleng; }
"begin"     { print_token(yytext, "begin"); current_column += yyleng; }
"end"       { print_token(yytext, "end"); current_column += yyleng; }
"read"      { print_token(yytext, "read"); current_column += yyleng; }
"write"     { print_token(yytext, "write"); current_column += yyleng; }
"while"     { print_token(yytext, "while"); current_column += yyleng; }
"do"        { print_token(yytext, "do"); current_column += yyleng; }
"if"        { print_token(yytext, "if"); current_column += yyleng; }
"then"      { print_token(yytext, "then"); current_column += yyleng; }
"else"      { print_token(yytext, "else"); current_column += yyleng; }
"const"     { print_token(yytext, "const"); current_column += yyleng; }
"procedure" { print_token(yytext, "procedure"); current_column += yyleng; }
"for"       { print_token(yytext, "for"); current_column += yyleng; }
"to"        { print_token(yytext, "to"); current_column += yyleng; }

";"         { print_token(yytext, "simb_ponto_virgula"); current_column += yyleng; }
":"         { print_token(yytext, "simb_dois_pontos"); current_column += yyleng; }
"("         { print_token(yytext, "simb_abre_parentese"); current_column += yyleng; }
")"         { print_token(yytext, "simb_fecha_parentese"); current_column += yyleng; }
","         { print_token(yytext, "simb_virgula"); current_column += yyleng; }
"."         { print_token(yytext, "simb_ponto"); current_column += yyleng; }
":="        { print_token(yytext, "simb_atribuicao"); current_column += yyleng; }
"="         { print_token(yytext, "simb_igual"); current_column += yyleng; }
"<>"        { print_token(yytext, "simb_diferente"); current_column += yyleng; }
">="        { print_token(yytext, "simb_maior_igual"); current_column += yyleng; }
"<="        { print_token(yytext, "simb_menor_igual"); current_column += yyleng; }
">"         { print_token(yytext, "simb_maior"); current_column += yyleng; }
"<"         { print_token(yytext, "simb_menor"); current_column += yyleng; }
"+"         { print_token(yytext, "simb_mais"); current_column += yyleng; }
"-"         { print_token(yytext, "simb_menos"); current_column += yyleng; }
"*"         { print_token(yytext, "simb_multiplicacao"); current_column += yyleng; }
"/"         { print_token(yytext, "simb_divisao"); current_column += yyleng; }

[0-9]+\.[a-zA-Z][_a-zA-Z0-9]* {
    report_lexical_error(yytext, "numero real mal formado");
    current_column += yyleng;
}
[0-9]+\.[0-9]+ { print_token(yytext, "num_real"); current_column += yyleng; }
[0-9]+        { print_token(yytext, "num_int"); current_column += yyleng; }

[a-zA-Z][_a-zA-Z0-9]* {
    if (yyleng > MAX_ID_LENGTH) {
        report_lexical_error(yytext, "identificador muito grande");
    } else {
        print_token(yytext, "id");
    }
    current_column += yyleng;
}

"{"         { current_column += yyleng; BEGIN(COMMENT); }
<COMMENT>[^}]* { current_column += yyleng; }
<COMMENT>"}" { current_column += yyleng; BEGIN(INITIAL); }
<COMMENT><<EOF>> {
    report_lexical_error("{", "comentario nao terminado");
    BEGIN(INITIAL);
}

[ \t]+      { current_column += yyleng; }
"\n"        { current_line++; current_column = 1; }

.           {
    report_lexical_error(yytext, "simbolo nao pertencente a linguagem");
    current_column += yyleng;
}

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Erro ao abrir o arquivo: %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        yyin = stdin;
    }

    yylex();

    if (argc > 1) {
        fclose(yyin);
    }
    return 0;
}
