--drop table in caso di tabelle già esistenti

drop table if exists Galleria;
drop table if exists Sala;
drop table if exists Opera;
drop table if exists Artista;
drop table if exists NegozioSouvenir;
drop table if exists Evento;
drop table if exists Prodotto;
drop table if exists Vende;
drop table if exists Dipendente;

--create ed alter table del database

create table Galleria (
    Luogo varchar(50) not null,
    Nome varchar(50) not null,
    primary key(Luogo)
);

create table Sala (
    Nome varchar(20) not null
    NumeroEspositori int not null,
    Luogo varchar(50) not null,
    foreign key (Luogo) references Galleria(Luogo) on update cascade on delete cascade
    primary key(Nome, Luogo)
);

create table Artista (
    NickName varchar(30) not null,
    DataNascita DATE not null,
    Nome varchar(30),
    primary key(NickName)
);

create table Opera (
    ID int not null,
    Titolo varchar(50) not null,
    Descrizione varchar(500),
    Tipo varchar(50) not null,
    Luogo varchar(50) not null,
    Nome varchar(20) not null,
    Autore varchar(30) not null,
    foreign key (Luogo) references Sala(Luogo) on update cascade on delete cascade,
    foreign key (Nome) references Sala(Nome) on update cascade on delete cascade,
    foreign key (Autore) references Artista(NickName) on update cascade on delete cascade,
    primary key(ID)
);

create table Evento (
    ID int not null,
    Nome varchar(60) not null, 
    DataInizio DATE not null,
    DataFine DATE not null,
    Luogo varchar(50) not null,
    foreign key (Luogo) references Galleria(Luogo) on update cascade on delete cascade,
    primary key (ID)
);

create table NegozioSouvenir (
    Orario DATE not null,
    Luogo varchar(50) not null,
    foreign key (Luogo) references Galleria(Luogo) on update cascade on delete cascade,
    primary key (Luogo)
);

create table Prodotto (
    TipoProdotto varchar(50) not null,
    Disponibilita boolean not null default = false
    primary key (TipoProdotto)
);

create table Vende (
    Luogo varchar(50) not null,
    TipoProdotto varchar(50) not null,
    foreign key (Luogo) references NegozioSouvenir(Luogo) on update cascade on delete cascade,
    foreign key (TipoProdotto) references Prodotto(TipoProdotto) on update cascade on delete cascade,
    primary key (Luogo, TipoProdotto)
);

create table Dipendente (
    CodiceFiscale varchar(60) not null,
    Salario int not null,
    Mansione varchar(20),
    Galleria varchar(20) not null,
    foreign key (Galleria) references Galleria(Luogo) on update cascade on delete cascade,
    primary key(CodiceFiscale)
);


--Insert values del datbase
insert into Galleria(Luogo, Nome)
values (Manhattan, NYGallery);
values (Bronx, BGallery)
values (Brooklin, KGallery);
values (Queens, QGallery);
values (Staten Island, RGallery)

insert into Sala(Nome, NumeroEspositori, Luogo)
values (New, 6, Manhattan);
values (Classic, 3, Manhattan);
values (Modern, 4, Manhattan);
values (Contemporary, 8, Manhattan);
values (New, 5, Bronx);
values (Classic, 2, Bronx);
values (Modern, 4, Bronx);
values (Contemporary, 5, Bronx);
values (New, 7, Brooklin);
values (Classic, 5, Brooklin);
values (Modern, 7, Brooklin);
values (Contemporary, 4, Brooklin);
values (New, 2, Queens);
values (Classic, 3, Queens);
values (Modern, 3, Queens);
values (Contemporary, 4, Queens);
values (New, 8, Staten Island);
values (Classic, 9, Staten Island);
values (Modern, 7, Staten Island);
values (Contemporary, 5, Staten Island)

insert into Artista (NickName, DataNascita, Nome)
values (Ronst, 1999-12-01, Richard);
values (Milok, 1978-08-27, Mikael);

--Query

--1. Verificare disponibilità prodotto da una certa galleria
--2. Artisti che hanno creato più opere
--3. Galleria con più opere
--4. Galleria che spende di più nel salario dipendenti
--5. Eventi più recenti
--6. Tipo di opere più presente



--Indici

