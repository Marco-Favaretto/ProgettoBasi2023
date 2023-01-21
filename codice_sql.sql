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
insert into Galleria(Luogo, Nome) values
('Italia','ITMusesum'),
('Francia','FRMusesum'),
('Germania','DEMusesum'),
('RegnoUnito','UKMusesum'),
('USA','USAMusesum'),
('Canada','CAMusesum'),
('Cina','CNMusesum'),
('Giappone','JPMusesum'),
('SudAfrica','ZAMusesum'),
('Brasile','BRMusesum');

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
("Contemporary", "5", "Staten Island");

insert into Artista (NickName, DataNascita, Nome) values
('Shun', '1948-11-08', 'Shauna Caulliere'),
('ChariJ', '1816-07-04', 'CharityJancik'),
('Falkner', '1916-05-16', 'FalknerMcKeevers'),
('FraZ', '1962-12-09', 'FrazeDureden'),
('Audrey', '1913-02-06', 'AudreySinncock'),
('Cara', '1988-05-19', 'CaraDenacamp'),
('Shirline', '1988-04-07', 'ShirlineEnns'),
('Parsifal', '1864-09-11', 'ParsifalSherland'),
('Barr', '1919-02-24', 'BarrHicklingbottom'),
('Verine', '1956-08-04', 'VerineHolliar'),
('Bayard', '1924-10-23', 'BayardTitmuss'),
('Lilian', '1844-01-28', 'LilianFriett'),
('Sumner', '1928-05-23', 'SumnerSirey'),
('Lyda', '1905-11-08', 'LydaPyser'),
('Wynnie', '1931-02-15', 'WynnieCalladine'),
('Elle', '1879-02-12', 'ElleFlury'),
('Zorine', '1848-02-25', 'ZorineBrewood'),
('Suellen', '1887-10-16', 'SuellenCosten'),
('Aggi', '1910-03-21', 'AggiCrush'),
('Wren', '1988-05-27', 'WrenCormode'),
('Cherise', '1989-08-22', 'CheriseOliveti'),
('Charles', '1969-07-12', 'CharlesTrask'),
('Verge', '1832-02-11', 'VergeOsorio'),
('Celisse', '1881-05-26', 'CelisseScobbie'),
('Janessa', '1925-09-10', 'JanessaPickburn'),
('Nikki', '1825-02-15', 'NikkiEgginton'),
('Berti', '1819-11-11', 'BertiGoracci'),
('Nikola', '1961-12-28', 'NikolaMaddrah'),
('Jammal', '1835-11-03', 'JammalVedyaev'),
('Alastair', '1853-10-06', 'AlastairGowland'),
('Nichole', '1877-01-12', 'NicholeCavil'),
('Judon', '1883-04-27', 'JudonGibbon'),
('Ryann', '1916-10-02', 'RyannArndell'),
('Huntlee', '1827-10-07', 'HuntleeMonini'),
('Sadye', '1837-08-26', 'SadyeMitchelson'),
('Terence', '1942-05-01', 'TerenceLapsley'),
('Aymer', '1838-02-16', 'AymerJuster'),
('Almire', '1937-08-24', 'AlmireGrindley'),
('Kathleen', '1906-04-05', 'KathleenBiggadike'),
('Marsh', '1947-04-30', 'MarshNevins'),
('Felisha', '1987-01-09', 'FelishaShipp'),
('Noella', '1949-12-21', 'NoellaMeggison'),
('Zollie', '1827-07-24', 'ZollieGunnell'),
('Tami', '1927-10-08', 'TamiSerman'),
('Yelena', '1806-07-16', 'YelenaRudolf');

insert into Opera(ID, Titolo, Descrizione, Tipo, Luogo, Nome, Autore) values
("01", "Finding Paradise", "", "Painting", "Manhattan", "Abstract", "Ronst");
('02', 'Within Painting', "A large whimsical vision of Spring celebrating it's return.", 'Painting', 'Manhattan', 'Abstract', "Ronst");
("03","Beach Stones", "Watercolor stones painting in shade of blue, indigo, teal, and grey.", "Painting","Manhattan", "Abstract", "Linda Wood");
("04","Letting Go","The times I have felt the most peaceful are in lakes, floating on my back with my face to the sun and the silence of water in my ears. To let go, to open my hands and float...these are the moments that I feel the Great Spirit of life holding me up. The thought inscribed there in the paint is my prayer of thanks.", "Painting","Manhattan", "Abstract", "Alisha Lee");
("05", "OK!OK", "","Print", "Manhattan", "Digital", "Milok");
("06", "Boom", "A little crowded", "Print","Manhattan", "Digital", "Milok");
("07", "Sad is not new", "Is ok not to be ok", "Print", "Manhattan", "Digital", "Rammon");
("08", "Think", "", "Statue", "Manhattan", "Modern", "Maria Ross");
("09", "Lovevol", "", "Painting", "Manhattan", "Modern", "Maria Ross");
("10",);
("11",);
("12",);
("13",);

insert into Dipendente (NomeCognome, Mail, Salario, Mansione, Galleria) values
(' MariaStanfield ',' Maria.Stanfield@gmail.com ', 6000 , 'Direttore' , 'Italia' ),
(' RickRipp ',' Rick.Ripp@gmail.com ', 8000 , 'Direttore' , 'USA' ),
(' ParisGarry ',' Paris.Garry@gmail.com ', 8000 , 'Direttore' , 'Francia' ),
(' GeorgeDueber ',' George.Dueber@gmail.com ', 8000 , 'Direttore' , 'Canada' ),
(' NathanNorrix ',' Nathan.Norrix@gmail.com ', 8000 , 'Direttore' , 'Inghilterra' ),
(' JoeCrabb ',' Joe.Crabb@gmail.com ', 8000 , 'Direttore' , 'SudAfrica' ),
(' CarrieMatthews ',' Carrie.Matthews@gmail.com ', 8000 , 'Direttore' , 'Cina' ),
(' DebraMurphy ',' Debra.Murphy@gmail.com ', 8000 , 'Direttore' , 'Giappone' ),
(' DavidKoral ',' David.Koral@gmail.com ', 8000 , 'Direttore' , 'Germania' ),
(' JeanLeon ',' Jean.Leon@gmail.com ', 8000 , 'Direttore' , 'Brasile' ),
(' DawnWangler ',' Dawn.Wangler@gmail.com ', 2900 , 'Receptionist' , 'Italia' ),
(' CarissaRich ',' Carissa.Rich@gmail.com ', 2900 , 'Receptionist' , 'Francia' ),
(' MathewHunter ',' Mathew.Hunter@gmail.com ', 2900 , 'Receptionist' , 'Inghilterra' ),
(' KeriMcdowell ',' Keri.Mcdowell@gmail.com ', 2900 , 'Receptionist' , 'USA' ),
(' MaryBuono ',' Mary.Buono@gmail.com ', 1800 , 'Receptionist' , 'Germania' ),
(' AlfredRemillard ',' Alfred.Remillard@gmail.com ', 1900 , 'Receptionist' , 'Giappone' ),
(' TimothyBury ',' Timothy.Bury@gmail.com ', 1900 , 'Receptionist' , 'Cina' ),
(' BridgettJackson ',' Bridgett.Jackson@gmail.com ', 2300 , 'Receptionist' , 'Canada' ),
(' KarenNunez ',' Karen.Nunez@gmail.com ', 1800 , 'Receptionist' , 'SudAfrica' ),
(' DavidHoward ',' David.Howard@gmail.com ', 1800 , 'Receptionist' , 'Brasile' ),
(' AgnesMobley ',' Agnes.Mobley@gmail.com ', 1900 , 'Commesso' , 'Italia' ),
(' JamesCuevas ',' James.Cuevas@gmail.com ', 1800 , 'Commesso' , 'Francia' ),
(' ChrisHatcher ',' Chris.Hatcher@gmail.com ', 2300 , 'Commesso' , 'Germania' ),
(' SharonMead ',' Sharon.Mead@gmail.com ', 2300 , 'Commesso' , 'Inghilterra' ),
(' WillieFields ',' Willie.Fields@gmail.com ', 1800 , 'Commesso' , 'USA' ),
(' PatrickHorton ',' Patrick.Horton@gmail.com ', 1900 , 'Commesso' , 'Giappone' ),
(' DennisKing ',' Dennis.King@gmail.com ', 1800 , 'Commesso' , 'Cina' ),
(' KathleenDuncan ',' Kathleen.Duncan@gmail.com ', 2000 , 'Commesso' , 'Canada' ),
(' MarioKluender ',' Mario.Kluender@gmail.com ', 1900 , 'Commesso' , 'SudAfrica' ),
(' MarkPhillips ',' Mark.Phillips@gmail.com ', 2000 , 'Commesso' , 'Brasile' ),
(' WillieVaccaro ',' Willie.Vaccaro@gmail.com ', 2200 , 'Guardia' , 'Italia' ),
(' ThomasBaca ',' Thomas.Baca@gmail.com ', 1800 , 'Guardia' , 'Francia' ),
(' JillBrinkman ',' Jill.Brinkman@gmail.com ', 2300 , 'Guardia' , 'Germania' ),
(' JohnDavis ',' John.Davis@gmail.com ', 2200 , 'Guardia' , 'USA' ),
(' ToddClapham ',' Todd.Clapham@gmail.com ', 2200 , 'Guardia' , 'Inghilterra' ),
(' NormaDigiovanni ',' Norma.Digiovanni@gmail.com ', 2200 , 'Guardia' , 'Cina' ),
(' HerbertJones ',' Herbert.Jones@gmail.com ', 2000 , 'Guardia' , 'Giappone' ),
(' RosellaSelby ',' Rosella.Selby@gmail.com ', 2300 , 'Guardia' , 'Canada' ),
(' StevenLinder ',' Steven.Linder@gmail.com ', 2000 , 'Guardia' , 'Brasile' ),
(' GregoriaSuzuki ',' Gregoria.Suzuki@gmail.com ', 2200 , 'Guardia' , 'SudAfrica' ),
(' IraCharon ',' Ira.Charon@gmail.com ', 2200 , 'Guardia' , 'Italia' ),
(' CharlesPhillips ',' Charles.Phillips@gmail.com ', 1800 , 'Guardia' , 'USA' ),
(' CarolynCote ',' Carolyn.Cote@gmail.com ', 2200 , 'Guardia' , 'Inghilterra' ),
(' RicardoDavis ',' Ricardo.Davis@gmail.com ', 1900 , 'Guardia' , 'Inghilterra' ),
(' SaraDowning ',' Sara.Downing@gmail.com ', 1800 , 'Guardia' , 'Giappone' ),
(' MorrisJohnson ',' Morris.Johnson@gmail.com ', 2000 , 'Guardia' , 'Cina' ),
(' RonnieChiapetti ',' Ronnie.Chiapetti@gmail.com ', 1800 , 'Guardia' , 'Brazile' ),
(' SteveZimmerman ',' Steve.Zimmerman@gmail.com ', 2000 , 'Guardia' , 'SudAfrica' ),
(' DamonJohns ',' Damon.Johns@gmail.com ', 2300 , 'Guardia' , 'Italia' ),
(' HenryNichols ',' Henry.Nichols@gmail.com ', 1800 , 'Guardia' , 'Italia' ),
(' KathyLopez ',' Kathy.Lopez@gmail.com ', 2000 , 'Guardia' , 'Canada' ),
(' MarkBarnett ',' Mark.Barnett@gmail.com ', 1800 , 'Guardia' , 'USA' ),
(' KevinCoats ',' Kevin.Coats@gmail.com ', 1800 , 'Guardia' , 'USA' ),
(' OlgaVeil ',' Olga.Veil@gmail.com ', 1900 , 'Guardia' , 'USA' );

insert into NegozioSouvenir(Luogo, Orario) values
('Italia','Continuato'),
('Francia','Continuato'),
('Germania','Continuato'),
('RegnoUnito','Continuato'),
('USA','Continuato'),
('Canada','Continuato'),
('Cina','Continuato'),
('Giappone','Continuato'),
('SudAfrica','Continuato'),
('Brasile','Continuato');


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

create index '#' on '#';