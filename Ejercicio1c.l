    /*----- Sección de Declaraciones -----*/

%{
#include <iostream>

using namespace std;

int mayusculas, minusculas, mezclaMm, enteros, reales, sumae;
float sumar;
void escribir_datos();

%}

%%

    /*----- Sección de Reglas -----*/

[A-Z]*                                      { mayusculas++; }
[a-z]*                                      { minusculas++; }
[A-Za-z]*                                   { mezclaMm++; }
[0-9]*                                      { enteros++; sumae += atoi(yytext); }
([0-9]+(,|.)[0-9]+(e|E)?"-"?[0-9]*|[0-9]+(,|.)?[0-9]*(e|E)"-"?[0-9]*)       { reales++; sumar += atof(yytext); }
.                                           { ; }          // Regla por defecto, muestra lo que no es captado por las reglas superiores

%%

    /*----- Sección de Procedimientos -----*/

int main(int argc, char *argv[]) {

    if (argc == 2) {
        yyin = fopen(argv[1], "rt");

        if(yyin == NULL) {
            cout << "El fichero " << argv[1] << " no se puede abrir" << endl;
            exit(-1);
        }
    }
    else
        yyin = stdin;

    mayusculas = minusculas = mezclaMm = enteros = reales = sumae = 0;
    sumar = 0.0;
    yylex();
    escribir_datos();

    return 0;
}

void escribir_datos() {
    cout << "Numero de palabras en mayuscula:\t" << mayusculas << endl;
    cout << "Numero de palabras en minusculas:\t" << minusculas << endl;
    cout << "Numero de palabras con mezcla M-m:\t" << mezclaMm << endl;
    cout << "Numero de enteros:\t" << enteros << endl;
    cout << "Numero de reales:\t" << reales << endl;
    cout << "Suma de los enteros:\t" << sumae << endl;
    cout << "Suma de los reales:\t" << sumar << endl;

}
