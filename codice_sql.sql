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
('Classic', 6, 'Italia'),
('Renaissance', 3, 'Italia'),
('Gotic', 8, 'Francia'),
('Contemporary', 4, 'Francia'),
('Abstract', 5, 'Germania'),
('Digital', 2, 'Germania'),
('Modern', 4, 'RegnoUnito'),
('Contemporary', 5, 'RegnoUnito'),
('Human', 7, 'USA'),
('Digital', 5, 'USA'),
('Modern', 7, 'Canada'),
('Contemporary', 4, 'Canada'),
('Abstract', 2, 'Cina'),
('Classic', 3, 'Cina'),
('Feudal', 3, 'Giappone'),
('Anime', 4, 'Giappone'),
('StreetArt', 3, 'SudAfrica'),
('Digital', 7, 'SudAfrica'),
('Modern', 7, 'Brasile'),
('Contemporary', 5, 'Brasile');

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
(01,'Il giocatore','','Sculpture','Italia','Classic','Cara'),
(02,'Giostra','','Architecture','Italia','Classic','Cara'),
(03,'Pensiero','','Sculpture','Italia','Classic','Tami'),
(04,'Movimento','','Sculpture','Italia','Classic','Tami'),
(05,'Porticato','','Architecture','Italia','Classic','Noella'),
(06,'Fontana','','Architecture','Italia','Classic','Noella'),
(07,'Le 3 dame','Tre donne che si muovono sinuose','Painting','Italia','Renaissance','Yelena'),
(08,'Le 4 dame','Quattro donzelle che ballano','Painting','Italia','Renaissance','Yelena'),
(09,'Le 5 dame','Cinque dame che pensano','Painting','Italia','Renaissance','Yelena'),
(10,'Notre Dame de Lyon','','Architecture','Francia','Gotic','Audrey'),
(11,'Notre Dame de Paris','','Architecture','Francia','Gotic','Audrey'),
(12,'Sacre Coeur','','Architecture','Francia','Gotic','Cherise'),
(13,'Saint Bartolomie','','Architecture','Francia','Gotic','Cherise'),
(14,'Fourier','','Architecture','Francia','Gotic','Audrey'),
(15,'Fayettes','','Architecture','Francia','Gotic','Cherise'),
(16,'Epicerie','','Architecture','Francia','Gotic','Nichole'),
(17,'Ecrir','','Architecture','Francia','Gotic','Nichole'),
(18,'Finding Paradise','','Painting','Francia','Contemporary','Zollie'),
(19,'Within Painting','A large whimsical vision of Spring celebrating its return.','Painting','Francia','Contemporary','Zollie'),
(20,'Beach Stones','Watercolor stones painting in shade of blue, indigo, teal, and grey.','','Francia','Contemporary','Zollie'),
(21,'Letting Go','The times I have felt the most peaceful are in lakes, floating on my back with my face to the sun and the silence of water in my ears.','Painting','Francia','Contemporary','Marsh'),
(22,'Twei','Heute möchte ich von meinem besten Freund erzählen. Zunächst zu seinem Äußeren.','Painting','Germania','Abstract','Ryann'),
(23,'Zund','Er ist sehr groß und ragt mit seinen 1,94 Meter Körpergröße aus fast jeder Menschengruppe heraus.','Painting','Germania','Abstract','Ryann'),
(24,'Wander','Seine Arme und Beine sind zwar lang, aber kräftig, da er sehr gerne Sport treibt.','Painting','Germania','Abstract','FraZ'),
(25,'Krunken','Mein Freund ist Basketballer.','Painting','Germania','Abstract','FraZ'),
(26,'Apoteque','','Painting','Germania','Abstract','FraZ'),
(27,'Life','','Print','Germania','Digital','Shirline'),
(28,'idfc','','Print','Germania','Digital','Shirline'),
(29,'lol','','Painting','RegnoUnito','Modern','Ryann'),
(30,'YOLO','you obly live once','Painting','RegnoUnito','Modern','Ryann'),
(31,'God save the queen','Please, we are begging','Painting','RegnoUnito','Modern','Aymer'),
(32,'rofl','','Sculpture','RegnoUnito','Contemporary','Huntlee'),
(33,'B E A U T Y',':O','Sculpture','RegnoUnito','Contemporary','Huntlee'),
(34,'Boom','','Painting','RegnoUnito','Contemporary','Huntlee'),
(35,'Basmati','','Painting','RegnoUnito','Contemporary','Huntlee'),
(36,'Nature','The beauty of nature passing through me.','Performance','USA','Human','Huntlee'),
(37,'Fight','','Performance','USA','Human','Sadye'),
(38,'War','','Performance','USA','Human','Sadye'),
(39,'Hope','first','Performance','USA','Human','Sadye'),
(40,'Less','second','Performance','USA','Human','Sadye'),
(41,'Rage','','Performance','USA','Human','Sadye'),
(42,'Scream','','Performance','USA','Human','Sadye'),
(43,'Group','These groupings are defined by the perception that the artworks within them share a single quality.','NFT','USA','Digital','Cherise'),
(44,'Be free','Afternoon Aspen Grove','Image','USA','Digital','Cherise'),
(45,'bff','','Print','USA','Digital','Shirline'),
(46,'gf or bf','','Print','USA','Digital','Shirline'),
(47,'Rare','Still young','Painting','Canada','Modern','Aggi'),
(48,'Steak','Good in every occasion','Painting','Canada','Modern','Aggi'),
(49,'Medium','Walking at your pace','Painting','Canada','Modern','Aggi'),
(50,'Jogging','','Sculpture','Canada','Modern','Nikki'),
(51,'Jumper','','Sculpture','Canada','Modern','Nikki'),
(52,'Winston','','Sculpture','Canada','Contemporary','Berti'),
(53,'Cave','','Architecture','Canada','Contemporary','Berti'),
(54,'SkyLiner','','Architecture','Canada','Contemporary','Berti'),
(55,'Warrior','Is he fighting or crying?','Painting','Cina','Abstract','Aggi'),
(56,'Pagoda','','Sculpture','Cina','Classic','Wren'),
(57,'Buddah','','Sculpture','Cina','Classic','Wren'),
(58,'Samurai','Loyality and Honor','Painting','Giappone','Feudal','Falkner'),
(59,'Waiting','','Painting','Giappone','Feudal','Falkner'),
(60,'AOD','','Animation','Giappone','Anime','Verine'),
(61,'SSO','','Animation','Giappone','Anime','Lilian'),
(62,'MMO','','Animation','Giappone','Anime','Verine'),
(63,'FER','','Animation','Giappone','Anime','Bayard'),
(64,'Crazy','','Murales','SudAfrica','StreetArt','Suellen'),
(65,'Happy','','Murales','SudAfrica','StreetArt','Suellen'),
(66,'Melody','Feel the rithm in music','Murales','SudAfrica','StreetArt','Judon'),
(67,'Rampa','','Print','SudAfrica','Digital','Wynnie'),
(68,'CreationVSCreator1','','Animation','SudAfrica','Digital','Charles'),
(69,'CreationVSCreator2','','Animation','SudAfrica','Digital','Charles'),
(70,'CreationVSCreator3','','Animation','SudAfrica','Digital','Charles'),
(71,'Lukas','','Print','SudAfrica','Digital','Wynnie'),
(72,'Wine','','Sculpture','Brasile','Modern','Verge'),
(73,'Bread','','Sculpture','Brasile','Modern','Verge'),
(74,'Fish','','Sculpture','Brasile','Modern','Verge'),
(75,'Hola','','Painting','Brasile','Contemporary','Sumner'),
(76,'Amigos','','Painting','Brasile','Contemporary','Barr'),
(77,'Mira','','Painting','Brasile','Contemporary','Sadye');

insert into Evento (ID, Nome, DataInizio, DataFine, Luogo) values
(01,'Free Guides','2020-08-13','2020-08-20','Italia'),
(02,'Meet the artist','2021-01-10','2021-01-15','Italia'),
(03,'Interactive Learning','2022-10-01','2022-12-30','Italia'),
(04,'Sales on souvenir','2021-04-16','2021-05-16','Francia'),
(05,'Charity','2022-05-01','2022-05-31','Francia'),
(06,'Free Guides','2018-02-26','2018-03-15','Germania'),
(07,'All night','2015-11-23','2015-11-24','Germania'),
(08,'Charity','2019-12-25','2019-12-31','Germania'),
(09,'Sales on souvenir','2014-07-12','2014-07-18','RegnoUnito'),
(10,'Charity','2021-09-07','2021-09-27','RegnoUnito'),
(11,'Free Guides','2023-01-01','2023-01-07','USA'),
(12,'Sales on souvenir','2015-05-18','2015-05-28','USA'),
(13,'Charity','2022-12-06','2022-12-08','USA'),
(14,'Sales on souvenir','2020-08-13','2020-08-20','Canada'),
(15,'Free Guides','2021-09-07','2021-09-27','Canada'),
(16,'Meet the artist','2021-01-04','2021-01-08','Cina'),
(17,'Interactive Learning','2020-10-07','2020-10-14','Cina'),
(18,'Free Guides','2019-12-25','2019-12-31','Giappone'),
(19,'Charity','2018-02-04','2018-02-05','Giappone'),
(20,'Meet the artist','2014-11-18','2014-11-24','Giappone'),
(21,'Sales on souvenir','2022-10-01','2022-12-30','SudAfrica'),
(22,'All night','2015-03-13','2015-03-23','SudAfrica'),
(23,'Meet the artist','2013-06-14','2013-06-18','SudAfrica'),
(24,'Free Guides','2020-11-19','2020-11-29','Brasile'),
(25,'Charity','2016-05-08','2016-05-15','Brasile');


insert into Dipendente (NomeCognome, Mail, Salario, Mansione, Galleria) values
(' MariaStanfield ',' Maria.Stanfield@gmail.com ', 6000 , 'Direttore' , 'Italia' ),
(' RickRipp ',' Rick.Ripp@gmail.com ', 8000 , 'Direttore' , 'USA' ),
(' ParisGarry ',' Paris.Garry@gmail.com ', 8000 , 'Direttore' , 'Francia' ),
(' GeorgeDueber ',' George.Dueber@gmail.com ', 8000 , 'Direttore' , 'Canada' ),
(' NathanNorrix ',' Nathan.Norrix@gmail.com ', 8000 , 'Direttore' , 'RegnoUnito' ),
(' JoeCrabb ',' Joe.Crabb@gmail.com ', 8000 , 'Direttore' , 'SudAfrica' ),
(' CarrieMatthews ',' Carrie.Matthews@gmail.com ', 8000 , 'Direttore' , 'Cina' ),
(' DebraMurphy ',' Debra.Murphy@gmail.com ', 8000 , 'Direttore' , 'Giappone' ),
(' DavidKoral ',' David.Koral@gmail.com ', 8000 , 'Direttore' , 'Germania' ),
(' JeanLeon ',' Jean.Leon@gmail.com ', 8000 , 'Direttore' , 'Brasile' ),
(' DawnWangler ',' Dawn.Wangler@gmail.com ', 2900 , 'Receptionist' , 'Italia' ),
(' CarissaRich ',' Carissa.Rich@gmail.com ', 2900 , 'Receptionist' , 'Francia' ),
(' MathewHunter ',' Mathew.Hunter@gmail.com ', 2900 , 'Receptionist' , 'RegnoUnito' ),
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
(' SharonMead ',' Sharon.Mead@gmail.com ', 2300 , 'Commesso' , 'RegnoUnito' ),
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
(' ToddClapham ',' Todd.Clapham@gmail.com ', 2200 , 'Guardia' , 'RegnoUnito' ),
(' NormaDigiovanni ',' Norma.Digiovanni@gmail.com ', 2200 , 'Guardia' , 'Cina' ),
(' HerbertJones ',' Herbert.Jones@gmail.com ', 2000 , 'Guardia' , 'Giappone' ),
(' RosellaSelby ',' Rosella.Selby@gmail.com ', 2300 , 'Guardia' , 'Canada' ),
(' StevenLinder ',' Steven.Linder@gmail.com ', 2000 , 'Guardia' , 'Brasile' ),
(' GregoriaSuzuki ',' Gregoria.Suzuki@gmail.com ', 2200 , 'Guardia' , 'SudAfrica' ),
(' IraCharon ',' Ira.Charon@gmail.com ', 2200 , 'Guardia' , 'Italia' ),
(' CharlesPhillips ',' Charles.Phillips@gmail.com ', 1800 , 'Guardia' , 'USA' ),
(' CarolynCote ',' Carolyn.Cote@gmail.com ', 2200 , 'Guardia' , 'RegnoUnito' ),
(' RicardoDavis ',' Ricardo.Davis@gmail.com ', 1900 , 'Guardia' , 'RegnoUnito' ),
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

insert into Prodotto(TipoProdotto, Prezzo) values
('Statuetta', 10),
('Cartolina', 2),
('Quadretto', 15),
('Tazza', 12),
('Penna', 5),
('Agenda', 7),
('Borsa', 40),
('CoverCellulare', 5),
('Libro', 12),
('Poster', 10),
('Quadro', 20),
('RiproduzioneArchitettonica', 20);

insert into Vende(Luogo, TipoProdotto, Disponibilita) values
('Italia', 'Statuetta', TRUE),
('Italia', 'Cartolina', TRUE),
('Italia', 'Quadretto', FALSE),
('Italia', 'Tazza', FALSE),
('Italia', 'Penna', TRUE),
('Italia', 'Agenda', FALSE),
('Italia', 'Borsa', FALSE),
('Italia', 'CoverCellulare', TRUE),
('Italia', 'Libro', TRUE),
('Italia', 'Poster', TRUE),
('Italia', 'Quadro', FALSE),
('Italia', 'RiproduzioneArchitettonica', FALSE),
('Francia', 'Statuetta', FALSE),
('Francia', 'Cartolina', FALSE),
('Francia', 'Quadretto', TRUE),
('Francia', 'Tazza', TRUE),
('Francia', 'Penna', FALSE),
('Francia', 'Agenda', FALSE),
('Francia', 'Borsa', TRUE),
('Francia', 'CoverCellulare', TRUE),
('Francia', 'Libro', FALSE),
('Francia', 'Poster', TRUE),
('Francia', 'Quadro', TRUE),
('Francia', 'RiproduzioneArchitettonica', FALSE),
('Germania', 'Statuetta', TRUE),
('Germania', 'Cartolina', FALSE),
('Germania', 'Quadretto', FALSE),
('Germania', 'Tazza', TRUE),
('Germania', 'Penna', TRUE),
('Germania', 'Agenda', FALSE),
('Germania', 'Borsa', TRUE),
('Germania', 'CoverCellulare', TRUE),
('Germania', 'Libro', FALSE),
('Germania', 'Poster', FALSE),
('Germania', 'Quadro', TRUE),
('Germania', 'RiproduzioneArchitettonica', FALSE),
('USA', 'Statuetta', FALSE),
('USA', 'Cartolina', TRUE),
('USA', 'Quadretto', FALSE),
('USA', 'Tazza', TRUE),
('USA', 'Penna', TRUE),
('USA', 'Agenda', TRUE),
('USA', 'Borsa', FALSE),
('USA', 'CoverCellulare', TRUE),
('USA', 'Libro', TRUE),
('USA', 'Poster', FALSE),
('USA', 'Quadro', FALSE),
('USA', 'RiproduzioneArchitettonica', TRUE),
('Canada', 'Statuetta', TRUE),
('Canada', 'Cartolina', TRUE),
('Canada', 'Quadretto', TRUE),
('Canada', 'Tazza', FALSE),
('Canada', 'Penna', FALSE),
('Canada', 'Agenda', FALSE),
('Canada', 'Borsa', TRUE),
('Canada', 'CoverCellulare', FALSE),
('Canada', 'Libro', TRUE),
('Canada', 'Poster', FALSE),
('Canada', 'Quadro', TRUE),
('Canada', 'RiproduzioneArchitettonica', TRUE),
('RegnoUnito', 'Statuetta', FALSE),
('RegnoUnito', 'Cartolina', FALSE),
('RegnoUnito', 'Quadretto', FALSE),
('RegnoUnito', 'Tazza', TRUE),
('RegnoUnito', 'Penna', TRUE),
('RegnoUnito', 'Agenda', FALSE),
('RegnoUnito', 'Borsa', TRUE),
('RegnoUnito', 'CoverCellulare', TRUE),
('RegnoUnito', 'Libro', TRUE),
('RegnoUnito', 'Poster', TRUE),
('RegnoUnito', 'Quadro', TRUE),
('RegnoUnito', 'RiproduzioneArchitettonica', FALSE),
('SudAfrica', 'Statuetta', TRUE),
('SudAfrica', 'Cartolina', TRUE),
('SudAfrica', 'Quadretto', FALSE),
('SudAfrica', 'Tazza', FALSE),
('SudAfrica', 'Penna', TRUE),
('SudAfrica', 'Agenda', TRUE),
('SudAfrica', 'Borsa', FALSE),
('SudAfrica', 'CoverCellulare', FALSE),
('SudAfrica', 'Libro', TRUE),
('SudAfrica', 'Poster', FALSE),
('SudAfrica', 'Quadro', FALSE),
('SudAfrica', 'RiproduzioneArchitettonica', FALSE),
('Brazile', 'Statuetta', TRUE),
('Brazile', 'Cartolina', TRUE),
('Brazile', 'Quadretto', FALSE),
('Brazile', 'Tazza', TRUE),
('Brazile', 'Penna', FALSE),
('Brazile', 'Agenda', TRUE),
('Brazile', 'Borsa', TRUE),
('Brazile', 'CoverCellulare', TRUE),
('Brazile', 'Libro', FALSE),
('Brazile', 'Poster', FALSE),
('Brazile', 'Quadro', FALSE),
('Brazile', 'RiproduzioneArchitettonica', FALSE),
('Cina', 'Statuetta', TRUE),
('Cina', 'Cartolina', TRUE),
('Cina', 'Quadretto', TRUE),
('Cina', 'Tazza', FALSE),
('Cina', 'Penna', FALSE),
('Cina', 'Agenda', FALSE),
('Cina', 'Borsa', TRUE),
('Cina', 'CoverCellulare', FALSE),
('Cina', 'Libro', TRUE),
('Cina', 'Poster', TRUE),
('Cina', 'Quadro', FALSE),
('Cina', 'RiproduzioneArchitettonica', TRUE),
('Giappone', 'Statuetta', TRUE),
('Giappone', 'Cartolina', TRUE),
('Giappone', 'Quadretto', FALSE),
('Giappone', 'Tazza', FALSE),
('Giappone', 'Penna', FALSE),
('Giappone', 'Agenda', FALSE),
('Giappone', 'Borsa', TRUE),
('Giappone', 'CoverCellulare', TRUE),
('Giappone', 'Libro', TRUE),
('Giappone', 'Poster', TRUE),
('Giappone', 'Quadro', FALSE),
('Giappone', 'RiproduzioneArchitettonica', FALSE);


--Query

--1. Verificare disponibilità prodotto da una certa galleria
--mostra lista prodotti per scelta utente:
select TipoProdotto, Prezzo
from Prodotto;
--input esempio con 'cartolina'
select luogo
from vende v
where TipoProdotto = '%s' and disponibilità = TRUE;


--2. Artisti che hanno creato più opere in ordine decrescente
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
from opere o join galleria g on g.luogo = o.luogo
group by g.luogo
order by nopere desc
limit 1;

--4. Galleria che spende di più nel salario dipendenti
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
