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
    Nome varchar(20) not null,
    NumeroEspositori int not null,
    Luogo varchar(50) not null,
    foreign key (Luogo) references Galleria(Luogo) on update cascade on delete cascade,
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
    foreign key (Luogo, Nome) references Sala(Luogo, Nome) on update cascade on delete cascade,
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
    Orario varchar(15) not null,
    Luogo varchar(50) not null,
    foreign key (Luogo) references Galleria(Luogo) on update cascade on delete cascade,
    primary key (Luogo)
);

create table Prodotto (
    TipoProdotto varchar(50) not null,
    Prezzo int not null,
    primary key (TipoProdotto)
);

create table Vende (
    Luogo varchar(50) not null,
    TipoProdotto varchar(50) not null,
    Disponibilita boolean not null,
    foreign key (Luogo) references NegozioSouvenir(Luogo) on update cascade on delete cascade,
    foreign key (TipoProdotto) references Prodotto(TipoProdotto) on update cascade on delete cascade,
    primary key (Luogo, TipoProdotto)
);

create table Dipendente (
    NomeCognome varchar(60) not null,
    Mail varchar(60) not null unique,
    Salario int not null,
    Mansione varchar(20),
    Galleria varchar(20) not null,
    foreign key (Galleria) references Galleria(Luogo) on update cascade on delete cascade,
    primary key(Mail)
);


--Insert values del datbase


--Query

--1. Verificare disponibilità prodotto da una certa galleria

--mostra lista prodotti per scelta utente:
select TipoProdotto
from Prodotto;
--input esempio con 'cartolina'
select luogo 
from vende v
where TipoProdotto = '%s' and disponibilità = TRUE

--2. Artisti che hanno creato più opere in ordine decrescente per galleria
drop view if exists nopart;
create view nopart(luogo, autore, num) as --numero opere per autore in ciascuna galleria
	select a.luogo, a.autore, count(*) as num
	from opera a
	group by a.autore, a.luogo
	order by a.luogo;

select g.luogo, max(n.num)
from nopart n join galleria g on g.luogo = n.luogo
group by g.luogo;


--3. Galleria con più opere
select g.luogo as luogo, count(*) as nopere
from opera o join galleria g on g.luogo = o.luogo
group by g.luogo
order by nopere desc
limit 1;

--4. Galleria che spende di più nel salario dipendenti + salario medio
select g.Luogo, count(d.Mail) as Dipendenti, avg(d.Salario)::numeric(10,2) as Salario_medio, sum(d.Salario) as SpeseSalario
from Dipendente d join galleria g on d.galleria = g.luogo
group by g.luogo;

--5. Eventi in corso (facendo inserire la data all'utente?)
select Luogo, Nome
from Evento e
where '%s' between Datainizio and Datafine;

--6. Galleria avente almeno tre opere di un determinato tipo
select g.Luogo, o.tipo, count(*) num 
from opera o join galleria g on g.luogo = o.luogo
group by g.luogo, o.tipo
having count(*) > 3;

--Indici

create index art_location on opera(Titolo, Luogo);
