    /*----- Sección de Declaraciones -----*/

%{
#include <iostream>
#include <vector>
#include <string>

using namespace std;

vector<string> correos, webs, fechas, telefonos, matriculas, postales, NIFs;
vector<int> lcorreos, lwebs, lfechas, ltelefonos, lmatriculas, lpostales, lNIFs;
int nlineas;
void escribir_datos();

%}

iweb        "https:\/\/"|"http:\/\/"|"HTTPS:\/\/"|"HTTP:\/\/"?"www."?
dominio     ([A-Za-z0-9]*\.?[A-Za-z0-9]*)*(.es|.com|.net|.biz|.mx|.ar|.gob)+
correo      [A-Za-z_][A-Za-z0-9_]*[@]{dominio}
web         {iweb}{dominio}
telefono    "+34"?(9|6)[0-9]{8,8}
matricula   ([A-Z][A-Z]"-"?[0-9]{4,4}"-"?[A-Z][A-Z]|[0-9]{4,4}"-"?[A-Z][A-Z][A-Z])
postal      ([0-4][1-9][0-9]{3,3}|[5][0-2][0-9]{3,3})
NIF         [0-9]{8,8}"-"?[A-Z]

%%

    /*----- Sección de Reglas -----*/

\n              { nlineas++; }
{correo}        { string insertar(yytext); correos.push_back(insertar); lcorreos.push_back(nlineas+1); }
{web}           { string insertar(yytext); webs.push_back(insertar); lwebs.push_back(nlineas+1); }
{telefono}      { string insertar(yytext); telefonos.push_back(insertar); ltelefonos.push_back(nlineas+1); }
{matricula}     { string insertar(yytext); matriculas.push_back(insertar); lmatriculas.push_back(nlineas+1); }
{postal}        { string insertar(yytext); postales.push_back(insertar); lpostales.push_back(nlineas+1); }
{NIF}           { string insertar(yytext); NIFs.push_back(insertar); lNIFs.push_back(nlineas+1); }
.               { ; }          // Regla por defecto, muestra lo que no es captado por las reglas superiores

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

    nlineas = 0;
    yylex();
    escribir_datos();

    return 0;
}

void escribir_datos() {

    cout << "Correos:" << endl;
    for(int i = 0; i < correos.size(); i++) {
        cout << "\t" << correos[i] << " ---> " << lcorreos[i] << endl;
    }

    cout << "Webs:" << endl;
    for(int i = 0; i < webs.size(); i++) {
        cout << "\t" << webs[i] << " ---> " << lwebs[i] << endl;
    }

    cout << "Fechas:" << endl;
    for(int i = 0; i < fechas.size(); i++) {
        cout << "\t" << fechas[i] << " ---> " << lfechas[i] << endl;
    }

    cout << "Telefonos:" << endl;
    for(int i = 0; i < telefonos.size(); i++) {
        cout << "\t" << telefonos[i] << " ---> " << ltelefonos[i] << endl;
    }

    cout << "Matriculas:" << endl;
    for(int i = 0; i < matriculas.size(); i++) {
        cout << "\t" << matriculas[i] << " ---> " << lmatriculas[i] << endl;
    }

    cout << "Codigos Postales:" << endl;
    for(int i = 0; i < postales.size(); i++) {
        cout << "\t" << postales[i] << " ---> " << lpostales[i] << endl;
    }

    cout << "NIFs:" << endl;
    for(int i = 0; i < NIFs.size(); i++) {
        cout << "\t" << NIFs[i] << " ---> " << lNIFs[i] << endl;
    }

}
