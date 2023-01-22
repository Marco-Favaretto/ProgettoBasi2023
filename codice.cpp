/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * g++ codice.cpp -L dependencies\lib -lpq -o basi   *
 * .\basi.exe                                        *
** * * * * * * * * * * * * * * * * * * * * * * * * * */

#include<cstdio>
#include<fstream>
#include<iostream>
using std::cout;
using std::cin;
using std::endl;
#include "dependencies/include/libpq-fe.h"

#define PG_PORT 5432
#define PG_USER "postgres"
#define PG_HOST "127.0.0.1"
#define PG_DB "Progetto"

//chiede di ripetere eventuale ciclo di funzioni con relativo controllo sull'input
int ripeti();/* * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * g++ codice.cpp -L dependencies\lib -lpq -o basi   *
 * .\basi.exe                                        *
** * * * * * * * * * * * * * * * * * * * * * * * * * */

#include<cstdio>
#include<fstream>
#include<iostream>
#include<string>
using std::cout;
using std::cin;
using std::endl;
#include "dependencies/include/libpq-fe.h"

#define PG_PORT 5432
#define PG_USER "postgres"
#define PG_HOST "127.0.0.1"
#define PG_DB "Progetto"

//chiede di ripetere eventuale ciclo di funzioni con relativo controllo sull'input
int ripeti();

//stampa menu delle query
void menu(int*);

//controlla che la query sia eseguita correttamente
void checkResults(PGresult*, const PGconn*);

//stampa linea alta e bassa della tabella di output e la linea di separazione tra nome_campi e valori
void print_ln(int*, int);

//Stampa i valori finali di ogni campo-valore-riga -> riempie con degli spazi per allineare e chiude con ' | '
void pad_field(char*, int);

//Esegue e stampa la Query
int exeQ(PGconn*, char*);

int main() {
    cout << "inserire la password: ";
    char pg_pass[50];
    cin >> pg_pass;
    char conninfo [250];
    sprintf(conninfo , " user =%s password =%s dbname =%s hostaddr =%s port =%d", PG_USER , pg_pass , PG_DB , PG_HOST , PG_PORT);
    PGconn* conn = PQconnectdb(conninfo);
    if( PQstatus(conn) != CONNECTION_OK ){
        cout << "Errore di connessione\n" << PQerrorMessage(conn);
        PQfinish(conn);
        exit(1);
    } else {
        cout << "Connessione avvenuta correttamente" << endl;
        int menu_value;       //valore che specifica azione del menu
        int prog_r = 0;       //valore che specifica se ripetere un ciclo di esecuzione query
        //query, marcato const poiché in sola lettura
        const char* query[6] = {
            //Query 1
            "select v.luogo \
            from vende v\
            where v.TipoProdotto = '%s' and v.disponibilita = TRUE;",
            //Query 2
            "drop view if exists nopart; \
            create view nopart(luogo, autore, num) as \
                select op.luogo, op.autore, count(*) as num \
                from opera op \
                group by op.autore, op.luogo \
                order by op.luogo; \
            select g.luogo, max(n.num) \
            from nopart n join galleria g on g.luogo = n.luogo \
            group by g.luogo;",
            //Query 3
            "select g.luogo as luogo, count(*) as nopere \
            from opera o join galleria g on g.luogo = o.luogo \
            group by g.luogo \
            order by nopere desc \
            limit 1;",
            //Query 4
            "select g.Luogo, count(d.Mail) as Dipendenti, avg(d.Salario)::numeric(10,2) as Salario_medio, sum(d.Salario) as SpeseSalario \
            from Dipendente d join galleria g on d.galleria = g.luogo \
            group by g.luogo;",
            //Query 5
            "select e.Luogo, e.Nome \
            from Evento e \
            where '%s' between e.Datainizio and e.Datafine;",
            //Query 6
            "select g.Luogo, o.tipo, count(*) num \
            from opera o join galleria g on g.luogo = o.luogo \
            group by g.luogo, o.tipo \
            having count(*) > 3 \
            order by count(*) desc;"
        };
        
        //ciclo esecuzione query
        do {
            //menu
            menu(&menu_value);
            //cout << menu_value << endl;
            const char* tmp_q2[2] = {
                    "select TipoProdotto, Prezzo \
                        from Prodotto", 
                    "select TipoProdotto \
                        from Prodotto \
                        where TipoProdotto = '%s'"
                };
            //se utente non inserisce 0, esegui query, altrimenti quit diretto
            if(menu_value){
                char prodotto[50];
                char querytmp[400], q2_tmp[50]; //salva la query corrente da eseguire
                std::string s, data[3];
                //switch case per esecuzione delle query
                switch(menu_value) {
                    case 1:
                        cout << "Scegliere uno dei seguenti prodotti:\n";
                        sprintf(q2_tmp, tmp_q2[0]);
                        exeQ(conn, q2_tmp);
                        int ok;
                        do {
                            char q2_tmp2[200];
                            cout << "Specificare quale Prodotto visualizzare: ";  //richiesta piatto
                            cin >> prodotto;
                            sprintf(q2_tmp2, tmp_q2[1], prodotto);
                            cout << "Hai selezionato:" << endl; 
                            ok = exeQ(conn, q2_tmp2);          // test per valutare se il prodotto inserito è effettivamente nella tabella
                        } while(!ok);
                        sprintf(querytmp, query[0], prodotto);
                        exeQ(conn, querytmp);
                        break;
                    case 2:
                        sprintf(q2_tmp, query[1]);
                        exeQ(conn, querytmp);
                        break;
                    case 3:
                        sprintf(querytmp, query[2]);
                        exeQ(conn, querytmp);
                        break;
                    case 4:
                        sprintf(querytmp, query[3]);
                        exeQ(conn, querytmp);
                        break;
                    case 5:
                        //inserimento data:
                        cout << "Inserimento data\n - Inserire anno: ";
                        cin >> data[0];
                        cout << "- Inserire mese: ";
                        cin >> data[1];
                        cout << "- Inserire giorno: ";
                        cin >> data[2];
                        s = data[0] + "-" + data[1] + "-" + data[2];
                        //
                        sprintf(querytmp, query[4], s);
                        exeQ(conn, querytmp);
                        break;
                    case 6:
                        sprintf(querytmp, query[5]);
                        exeQ(conn, querytmp);
                        break;
                    default:
                        break;
                }
                cout << "Visualizzare una nuova query? [y or n]: ";    //ripetere l'esecuzione del programma
                prog_r = ripeti();
            }
        } while(prog_r);
        PQfinish(conn); //chiusura connessione
    }
    return 0;
}

int ripeti() {
    char c;
    cin >> c;
    while(c != 'y' && c != 'n'){
        cout << "[y or n]: ";
        cin >> c;
    }
    if(c == 'y') return 1;
    else return 0;
}

void menu(int *menu_v) {
    *menu_v = -1;
    while(*menu_v < 0 || *menu_v > 6) {
        cout << "Selezionare una delle seguenti query da eseguire: \n";
            cout << "\t1. Scegliere un prodotto e visualizzare i negozi nei quali e' disponibile\n";
            cout << "\t2. Visualizzare gli artisti che hanno creato piu' opere per galleria\n";
            cout << "\t3. Galleria con maggior numero di opere\n";
            cout << "\t4. Salario medio e spesa complessiva per galleria\n";
            cout << "\t5. Inserendo una data, vengono visualizzati gli eventi sono in corso\n";
            cout << "\t6. Galleria avente almeno 3 opere dello stesso tipo\n";
        cout << "\tPremere 0 per chiudere il programma." << endl;
        cout << "Inserire un numero compreso tra 0 e 6: ";
        cin >> *menu_v;
        if(*menu_v < 0 || *menu_v > 6) {
            cout << "Il valore inserito deve essere compreso tra 0 e 6." << endl;
        }
    } //POST: menu_value valore compreso in [0, 6]
}

void checkResults(PGresult* res , const PGconn* conn) {
    if ( PQresultStatus (res) != PGRES_TUPLES_OK ) {
        cout << "Risultati inconsistenti\n" << PQerrorMessage(conn) << endl ;
        PQclear(res);
        exit(1);
    }
}

void print_ln(int* len, int fields) {
    for (int i = 0; i < fields; i++) {
        cout << '+'; 
        for(int j = 0; j < len[i]+2; j++) cout << '-';
    }
    cout << '+' << endl;
}

void pad_field(char *value, int len) {
    int k = 0;
    //cout << value << endl; check value: corretto 
    while(*(value+k) != '\0') k++;                       //calcolo lunghezza nomi campi
    for(int j = 0; j < (len - k); j++) cout << ' ';      //Spazio da riempire = differenza len[campo_corrente] e lunghezza effettiva del nome
    cout << " | ";                                       //riempi di spazi e chiudi con |*/
}


int exeQ(PGconn* tmpconn, char* tmp_query) {
    PGresult* res = PQexec(tmpconn, tmp_query);
    checkResults(res , tmpconn);
    int tuple = PQntuples(res);
    int fields = PQnfields(res);

    //Raccolta informazioni riguardo la lunghezza in caratteri delle tuple, dei campi e dei valori
    int len[fields];
    char* fullq[tuple+1][fields];                 //matrice in cui si registrano i valori di res: tupla fullq[0][j] = campi della query
    for(int j = 0; j < fields; j++) {
        len[j] = 0;
        fullq[0][j] = PQfname(res, j);            //salvo nomi campi
        int k = 0;
        while(fullq[0][j][k] != '\0') k++;        //calcolo lunghezza nomi campi [k] dereferemzia sul char
        if(k > len[j]) len[j] = k;                //salvo la lunghezza maggiore
    }

    for(int i = 0; i < tuple; i++) {
        for(int j = 0; j < fields; j++) {
            fullq[i+1][j] = PQgetvalue(res, i, j);     //salvo valori campi
            int k = 0;
            while(fullq[i+1][j][k] != '\0') k++;       //calcolo lunghezza valori campi [k] dereferemzia sul char
            if(k > len[j]) len[j] = k;                 //salvo la lunghezza maggiore
        }
    }

    //Stampa effettiva delle Query
    print_ln(len, fields);
    cout << "| ";
    for(int i = 0; i < fields; i++) {
        cout << PQfname(res, i);
        pad_field(fullq[0][i], len[i]);
    }
    cout << endl;
    print_ln(len, fields);
    for(int i = 0; i < tuple; i++) {
        cout << "| ";
        for(int j = 0; j < fields; j++) {
            cout << PQgetvalue(res, i, j);
            pad_field(fullq[i+1][j], len[j]);
        }
        cout << endl;
    }
    print_ln(len, fields);

    PQclear(res); //chiusura dell'esecuzione della query
    return tuple; //return per verificare che ci sia stato output
}


//stampa menu delle query
void menu(int*);

//controlla che la query sia eseguita correttamente
void checkResults(PGresult*, const PGconn*);

//stampa linea alta e bassa della tabella di output e la linea di separazione tra nome_campi e valori
void print_ln(int*, int);

//Stampa i valori finali di ogni campo-valore-riga -> riempie con degli spazi per allineare e chiude con ' | '
void pad_field(char*, int);

//Esegue e stampa la Query
int exeQ(PGconn*, char*);

int main() {
    cout << "inserire la password: ";
    char pg_pass[50];
    cin >> pg_pass;
    char conninfo [250];
    sprintf(conninfo , " user =%s password =%s dbname =%s hostaddr =%s port =%d", PG_USER , pg_pass , PG_DB , PG_HOST , PG_PORT);
    PGconn* conn = PQconnectdb(conninfo);
    if( PQstatus(conn) != CONNECTION_OK ){
        cout << "Errore di connessione\n" << PQerrorMessage(conn);
        PQfinish(conn);
        exit(1);
    } else {
        cout << "Connessione avvenuta correttamente" << endl;
        int menu_value;       //valore che specifica azione del menu
        int prog_r = 0;       //valore che specifica se ripetere un ciclo di esecuzione query
        //query, marcato const poiché in sola lettura
        const char* query[6] = {
            //Query 1
            "select luogo \
            from vende v \
            where TipoProdotto = '%s' and disponibilità = TRUE;",
            //Query 2
            "drop view if exists nopart; \
            create view nopart(luogo, autore, num) as \
                select a.luogo, a.autore, count(*) as num \
                from opera a \
                group by a.autore, a.luogo \
                order by a.luogo; \
            select g.luogo, max(n.num) \
            from nopart n join galleria g on g.luogo = n.luogo \
            group by g.luogo;",
            //Query 3
            "select g.luogo as luogo, count(*) as nopere \
            from opere o join galleria g on g.luogo = o.luogo \
            group by g.luogo \
            order by nopere desc \
            limit 1;",
            //Query 4
            "select g.Luogo, count(d.Mail) as Dipendenti, avg(d.Salario)::numeric(10,2) as Salario_medio, sum(d.Salario) as SpeseSalario \
            from Dipendente d join galleria g on d.galleria = g.luogo \
            group by g.luogo;",
            //Query 5
            "select Luogo, Nome \
            from Evento e \
            where '%s' between Datainizio and Datafine;",
            //Query 6
            "select g.Luogo, o.tipo, count(*) num \
            from opera o join galleria g on g.luogo = o.luogo \
            group by g.luogo, o.tipo \
            having count(*) > 3;"
        };
        
        //ciclo esecuzione query
        do {
            //menu
            menu(&menu_value);
            //cout << menu_value << endl;
            const char* tmp_q2[2] = {
                    "select TipoProdotto, Prezzo \
                        from Prodotto", 
                    "select TipoProdotto \
                        from Prodotto \
                        where TipoProdotto = '%s'"
                };
            //se utente non inserisce 0, esegui query, altrimenti quit diretto
            if(menu_value){
                char prodotto[50];
                char querytmp[800], q2_tmp[50]; //salva la query corrente da eseguire
                //switch case per esecuzione delle query
                switch(menu_value) {
                    case 1:
                        cout << "Scegliere uno dei seguenti prodotti:";
                        sprintf(q2_tmp, tmp_q2[0]);
                        exeQ(conn, q2_tmp);
                        int ok;
                        do {
                            char q2_tmp2[200];
                            cout << "Specificare quale Prodotto visualizzare: ";  //richiesta piatto
                            cin >> prodotto;
                            sprintf(q2_tmp2, tmp_q2[1], prodotto);
                            cout << "Hai selezionato:" << endl; 
                            ok = exeQ(conn, q2_tmp2);          // test per valutare se il prodotto inserito è effettivamente nella tabella
                        } while(!ok);
                        sprintf(querytmp, query[0], prodotto);
                        exeQ(conn, querytmp);
                        break;
                    case 2:
                        sprintf(q2_tmp, query[1]);
                        exeQ(conn, querytmp);
                        break;
                    case 3:
                        sprintf(querytmp, query[2]);
                        exeQ(conn, querytmp);
                        break;
                    case 4:
                        sprintf(querytmp, query[3]);
                        exeQ(conn, querytmp);
                        break;
                    case 5:
                        //inserimento data:
                        char* data[3];
                        //
                        sprintf(querytmp, query[4]);
                        exeQ(conn, querytmp);
                        break;
                    case 6:
                        sprintf(querytmp, query[5]);
                        exeQ(conn, querytmp);
                        break;
                    default:
                        break;
                }
                cout << "Visualizzare una nuova query? [y or n]: ";    //ripetere l'esecuzione del programma
                prog_r = ripeti();
            }
        } while(prog_r);
        PQfinish(conn); //chiusura connessione
    }
    return 0;
}

int ripeti() {
    char c;
    cin >> c;
    while(c != 'y' && c != 'n'){
        cout << "[y or n]: ";
        cin >> c;
    }
    if(c == 'y') return 1;
    else return 0;
}

void menu(int *menu_v) {
    *menu_v = -1;
    while(*menu_v < 0 || *menu_v > 6) {
        cout << "Selezionare una delle seguenti query da eseguire: \n";
            cout << "\t1. Scegliere un prodotto e visualizzare i negozi nei quali è disponibile\n";
            cout << "\t2. Visualizzare gli artisti che hanno creato più opere per galleria\n";
            cout << "\t3. Galleria con maggior numero di opere\n";
            cout << "\t4. Salario medio e spesa complessiva per galleria\n";
            cout << "\t5. Inserendo una data, vengono visualizzati gli eventi sono in corso\n";
            cout << "\t6. Galleria avente almeno 3 opere dello stesso tipo\n";
        cout << "\tPremere 0 per chiudere il programma." << endl;
        cout << "Inserire un numero compreso tra 0 e 6: ";
        cin >> *menu_v;
        if(*menu_v < 0 || *menu_v > 6) {
            cout << "Il valore inserito deve essere compreso tra 0 e 6." << endl;
        }
    } //POST: menu_value valore compreso in [0, 6]
}

void checkResults(PGresult* res , const PGconn* conn) {
    if ( PQresultStatus (res) != PGRES_TUPLES_OK ) {
        cout << "Risultati inconsistenti" << PQerrorMessage(conn) << endl ;
        PQclear(res);
        exit(1);
    }
}

void print_ln(int* len, int fields) {
    for (int i = 0; i < fields; i++) {
        cout << '+'; 
        for(int j = 0; j < len[i]+2; j++) cout << '-';
    }
    cout << '+' << endl;
}

void pad_field(char *value, int len) {
    int k = 0;
    //cout << value << endl; check value: corretto 
    while(*(value+k) != '\0') k++;                       //calcolo lunghezza nomi campi
    for(int j = 0; j < (len - k); j++) cout << ' ';      //Spazio da riempire = differenza len[campo_corrente] e lunghezza effettiva del nome
    cout << " | ";                                       //riempi di spazi e chiudi con |*/
}


int exeQ(PGconn* tmpconn, char* tmp_query) {
    PGresult* res = PQexec(tmpconn, tmp_query);
    checkResults(res , tmpconn);
    int tuple = PQntuples(res);
    int fields = PQnfields(res);

    //Raccolta informazioni riguardo la lunghezza in caratteri delle tuple, dei campi e dei valori
    int len[fields];
    char* fullq[tuple+1][fields];                 //matrice in cui si registrano i valori di res: tupla fullq[0][j] = campi della query
    for(int j = 0; j < fields; j++) {
        len[j] = 0;
        fullq[0][j] = PQfname(res, j);            //salvo nomi campi
        int k = 0;
        while(fullq[0][j][k] != '\0') k++;        //calcolo lunghezza nomi campi [k] dereferemzia sul char
        if(k > len[j]) len[j] = k;                //salvo la lunghezza maggiore
    }

    for(int i = 0; i < tuple; i++) {
        for(int j = 0; j < fields; j++) {
            fullq[i+1][j] = PQgetvalue(res, i, j);     //salvo valori campi
            int k = 0;
            while(fullq[i+1][j][k] != '\0') k++;       //calcolo lunghezza valori campi [k] dereferemzia sul char
            if(k > len[j]) len[j] = k;                 //salvo la lunghezza maggiore
        }
    }

    //Stampa effettiva delle Query
    print_ln(len, fields);
    cout << "| ";
    for(int i = 0; i < fields; i++) {
        cout << PQfname(res, i);
        pad_field(fullq[0][i], len[i]);
    }
    cout << endl;
    print_ln(len, fields);
    for(int i = 0; i < tuple; i++) {
        cout << "| ";
        for(int j = 0; j < fields; j++) {
            cout << PQgetvalue(res, i, j);
            pad_field(fullq[i+1][j], len[j]);
        }
        cout << endl;
    }
    print_ln(len, fields);

    PQclear(res); //chiusura dell'esecuzione della query
    return tuple; //return per verificare che ci sia stato output
}
