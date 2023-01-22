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
--spostare disponibilità in vende?
--input esempio con "cartolina"
select luogo 
from vende v
where TipoProdotto = '%s' and disponibilità = 't'


--2. Artisti che hanno creato più opere in ordine decrescente
drop view if exists nopere;
create view nopere(autore, num) as  --numero opere per autore
    select art.NickName, count(*)
    from artista art join opera op on art.NickName = op.Autore
    group by art.NickName
    order by num desc;
select mn.citta as citta, mn.aut as aurore 
from nopere n join (
    select g.luogo as Citta, o.autore aut
    from galleria g join opera o on g.Luogo = o.Luogo
    group by aut;
) mn on n.autore = mn.aut
group by citta;


--3. Galleria con più opere
select gal.luogo, max(nopere) as num_opere
from galleria gal join (
select g.luogo as luogo, count(*) as nopere
from opere o join galleria g on g.luogo = o.luogo
group by g.luogo;
) g1 on gal.luogo = g.luogo;
--stessa query, ma altro modo, penso
select g.luogo as luogo, count(*) as nopere
from opere o join galleria g on g.luogo = o.luogo
group by g.luogo
order by nopere desc
limit 1;

--4. Galleria che spende di più nel salario dipendenti
select g.Luogo, count(d.Mail) as Dipendenti, sum(d.Salario) as SpeseSalario
from Dipendente d join galleria g on d.galleria = g.luogo
group by g.luogo;
--4.5 Salario medio per galleria
select g.Luogo, count(d.Mail) as nDipendenti, avg(d.Salario) as Salario_medio 
from Dipendente d join galleria g on d.galleria = g.luogo
group by g.luogo;


--5. Eventi in corso (facendo inserire la data all'utente?)
select Luogo, Nome
from Evento e
where '%s' between Data_inizio and Data_fine;


--6. Galleria avente almeno tre opere di un determinato tipo
select o.Luogo, o.tipo, count(*) num 
from opera o
group by o.tipo
having num > 3;


--possibile altra query: disponibilità gallerie?

--Indici

create index art_location on opera(Titolo, Luogo);