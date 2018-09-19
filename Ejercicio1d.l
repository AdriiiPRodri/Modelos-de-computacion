    /*----- Sección de Declaraciones -----*/

%{
#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

string cifrada;
void escribir_datos();

%}

%%

    /*----- Sección de Reglas -----*/

[^ \t\n]+       { string insertar(yytext); reverse(insertar.begin(), insertar.end()); cifrada.append(insertar); cifrada.append("\n"); }
.                                           { ; }          // Regla por defecto, muestra lo que no es captado por las reglas superiores

%%

    /*----- Sección de Procedimientos -----*/

int main(int argc, char *argv[]) {

    yyin = stdin;
    yylex();
    escribir_datos();

    return 0;
}

void escribir_datos() {
    cout << cifrada <<endl;
}
