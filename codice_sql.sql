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
insert into Galleria(Luogo, Nome) values
 ("Manhattan", "NYGallery");
 ("Bronx", "BGallery")
 ("Brooklin", "KGallery");
 ("Queens", "QGallery");
 ("Staten Island", "RGallery")

insert into Sala(Nome, NumeroEspositori, Luogo) values
 ("Abstract", "6", "Manhattan");
 ("Digital", "3", "Manhattan");
 ("Modern", "4", "Manhattan");
 ("Contemporary", "8", "Manhattan");
 ("Abstract", "5", "Bronx");
 ("Digital", "2", "Bronx");
 ("Modern", "4", "Bronx");
 ("Contemporary", "5", "Bronx");
 ("Abstract", "7", "Brooklin");
 ("Digital", "5", "Brooklin");
 ("Modern", "7", "Brooklin");
 ("Contemporary", "4", "Brooklin");
 ("Abstract", "2", "Queens");
 ("Digital", "3", "Queens");
 ("Modern", "3", "Queens");
 ("Contemporary", "4", "Queens");
 ("Abstract", "8", "Staten Island");
 ("Digital", "9", "Staten Island");
 ("Modern", "7", "Staten Island");
 ("Contemporary", "5", "Staten Island")

insert into Artista (NickName, DataNascita, Nome) values
 ("Ronst", "1999-12-01", "Richard");
 ("Milok", "1978-08-27", "Mikael");
 ("Rammon", "2000-07-25", "Edward");
 ("NWY", "1995-04-07", "Soph");
 ("Nalala", "1950-03-13", "Nala");
 ("Maria Ross", "1967-05-22", "Maria");
 ("Linda Wood", "1998-08-11", "Linda");
 ("Alisha Lee", "2002-06-17", "Alisha")

 insert into Opera(ID, Titolo, Descrizione, Tipo, Luogo, Nome, Autore) values
 ("01", "Finding Paradise", "", "Painting", "Manhattan", "Abstract", "Ronst");
 ('02', 'Within Painting', "A large whimsical vision of Spring celebrating it's return.", 'Painting', 'Manhattan', 'Abstract', "Ronst");
 ("03","Beach Stones", "Watercolor stones painting in shade of blue, indigo, teal, and grey.", "Painting","Manhattan", "Abstract", "Linda Wood");
 ("04","Letting Go","The times I have felt the most peaceful are in lakes, floating on my back with my face to the sun and the silence of water in my ears. To let go, to open my hands and float...these are the moments that I feel the Great Spirit of life holding me up. The thought inscribed there in the paint is my prayer of thanks.", "Painting","Manhattan", "Abstract", "Alisha Lee");
 ("05", "OK!OK", "","Print", "Manhattan", "Digital", "Milok");
 ("06", "Boom", "A little crowded", "Print","Manhattan", "Digital", "Milok");
 ("07", "Sad is not new", "Is ok not to be ok", "Print", "Manhattan", "Digital", "Rammon");
 ("08", "Think", "", "Statue", "Manhattan", "Modern", "Maria Ross");
 ("09", "");
 ("10",);
 ("11",);
 ("12",);
 ("13",);

 insert into Evento(ID, Nome, DataInizio, DataFine, Luogo) values
("01", "Ronst", "13-06-2020","20-06-2020", "Manhattan");
("02", "Milok", "11-07-2021", "18-07-2021","Manhattan");
("03",);
("04",);
("05",);
("06",);


--Query

--1. Verificare disponibilità prodotto da una certa galleria
--2. Artisti che hanno creato più opere
--3. Galleria con più opere
--4. Galleria che spende di più nel salario dipendenti
--5. Eventi più recenti
--6. Tipo di opere più presente



--Indici

