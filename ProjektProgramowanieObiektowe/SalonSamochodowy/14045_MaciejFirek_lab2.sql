/* tworzenie bazy danych */ 
CREATE DATABASE SalonSamochodowy
COLLATE Polish_100_CI_AS; 

/* tworzenie tabel */ 

	CREATE TABLE [dbo].[Klienci](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Imie] [nvarchar] (50) NOT NULL,
	[Nazwisko] [nvarchar] (100) NOT NULL,
	[PESEL] [nvarchar] (20) NULL,
	[Email] [nvarchar] (250) NULL,
	[Telefon] [nvarchar] (20) NULL)
	

	CREATE TABLE [dbo].[Marka](
	[ID] [int] PRIMARY KEY IDENTITY,
	[nazwa] [nvarchar] (50) UNIQUE NOT NULL)

	CREATE TABLE [dbo].[Model](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Model] [nvarchar] (500) NOT NULL,
	[MarkaID] [int] FOREIGN KEY REFERENCES Marka(ID),
	[cena] [money] NOT NULL,
	[KlientID] [int] FOREIGN KEY REFERENCES Klienci(ID))
	

	CREATE TABLE [dbo].[Statusy](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (250) UNIQUE NOT NULL)

	CREATE TABLE [dbo].[Rezerwacje](
	[ID] [int] PRIMARY KEY IDENTITY,
	[KlientID] [int] FOREIGN KEY REFERENCES Klienci(ID),
	[DataOdbioru] [datetime] NOT NULL,
	[StatusID] [int] FOREIGN KEY REFERENCES Statusy(ID))
	

	

	CREATE TABLE [dbo].[Dostawcy](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (500) NOT NULL,
	[MarkaID] [int] FOREIGN KEY REFERENCES Marka(ID),
	[NIP] [nvarchar] (20) NOT NULL,
	[KodPocztowy] [nvarchar] (20) NULL,
	[Miasto] [nvarchar] (250) NULL,
	[Adres] [nvarchar] (1000) NULL)

	

	CREATE TABLE [dbo].[Pracownicy](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Imie] [nvarchar] (500) NOT NULL,
	[Nazwisko] [nvarchar] (20) NOT NULL,
	[Email] [nvarchar] (20) NULL,
	[telefon] [nvarchar] (250) NULL,
	[Adres] [nvarchar] (1000) NULL)

	CREATE TABLE [dbo].[Wyposazenie](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (1000) NULL,
	[NazwaID] [int] FOREIGN KEY REFERENCES Marka(ID),
	[Model] [nvarchar] (1000) NULL,
	[ModelID] [int] FOREIGN KEY REFERENCES Model(ID),
	[Rodzajwyposazenia] [nvarchar] (20) NULL)


/* DODAWANIE WARTOSCI DO TABEL */																																	
	INSERT INTO Statusy (Nazwa)
	VALUES  ('Wolny'),
			('Zajêty'),
			('Niepotwierdzona'),
			('Potwierdzona'),
			('Anulowana'),
			('Zrealizowana')

	INSERT INTO Klienci (Imie, Nazwisko, PESEL, Email, Telefon) 
	VALUES ('Barbara', 'Fibiana', '75092908342', 'barbara.fibiana@onet.pl', '884317743'),
		('Barbara', 'Gruda', '83110523423', 'barbara.gruda@gmail.com', '513518635'),
		('Jadwiga', 'Bilecka', '70101023456', 'jadwiga.bilecka@onet.pl', '884815648')

	INSERT INTO Marka(Nazwa)
	VALUES  ('Audi'), 
			('BMW'),
			('TOYOTA')
	
	INSERT INTO model
	VALUES('A5',1,'350000',1),
	('M5',2,'500000',2),
	('YARIS',3,'100000',3)
	
	
	INSERT INTO Rezerwacje(klientID,Dataodbioru,StatusID) VALUES  (1,'2022-02-25',4),
	(2,'2022-04-13',3),
	(3,'2022-01-14',6)

	INSERT INTO Dostawcy (nazwa,MarkaID,NIP,KodPocztowy,Miasto,Adres) VALUES ('Audi Select Plus',1,'5466549871','33-410','Krakow','ul. Zakopianska 169a'),
	('BMW M-Cars',2,'2662548871','33-410','Krakow','Gora libertowska'),
	('Toyota Dobrygowski Kraków Modlnica',3,'3253658541','33-410','Krakow','ul. Czestochowska 30')
	
	INSERT INTO Pracownicy(imie,nazwisko,email,telefon,adres) VALUES ('Jan','Kowalski','Kowalski@gmail.com','321654987','ul. D³uga 12'),
	('Kamil','Kromka','Kromka@gmail.com','654987485','ul. Krakowska 38'),
	('Krystian','Baton','Baton@gmail.com','842964587','ul. Zakopianska 64')

	INSERT INTO Wyposazenie (nazwa,nazwaID,Model,ModelID,Rodzajwyposazenia) VALUES ('Audi',1,'A5',1,'Normalny'),
	('BMW',2,'M5',2,'Bogaty'),
	('TOYOTA',3,'Yaris',3,'Ubogi')
	


		/* PROCEDURY */
CREATE PROCEDURE DodajKlienta
	@Imie nvarchar (50),
	@Nazwisko nvarchar (100),
	@PESEL nvarchar (20),
	@Email nvarchar (250),
	@Telefon nvarchar (20)
AS
BEGIN
	INSERT Klienci
	VALUES (@Imie, @Nazwisko, @PESEL, @Email, @Telefon)
END

exec DodajKlienta 'Jan','Kowalski','0123456789','kowalski@gmail.com','123456789'

/*************2	procedura	***************************************/
CREATE PROCEDURE usunklienta

AS
BEGIN
	DELETE FROM Klienci WHERE id=(SELECT MAX(id) from Klienci);
END

exec usunklienta 
/*************3	procedura	***************************************/
CREATE PROCEDURE zmiencene
	@id int,
	@Cena nvarchar (100)
AS
BEGIN
	UPDATE model
	SET cena=@cena where id=@id
END

exec zmiencene 1,350000

				/* FUNKCJE */
/***************************1***************************************/	
		CREATE  FUNCTION funkcja1
		(@KlientID int )
RETURNS TABLE 
AS
RETURN

	SELECT  Klienci.Imie,
			Klienci.Nazwisko,
			Rezerwacje.dataodbioru,
			marka.nazwa	
	FROM marka, Rezerwacje
	 JOIN Klienci ON Rezerwacje.KlientID = Klienci.ID 
	WHERE
		Klienci.ID = @KlientID AND  Marka.ID = @KlientID
		
		select * from funkcja1(1)
		
/***************************2***************************************/

				
				CREATE  FUNCTION funkcja2
				(@KlientID int )
		RETURNS TABLE 
		AS
		RETURN

			SELECT  Klienci.Imie,
					Klienci.Nazwisko,
					Marka.nazwa,
					model.model
			FROM Marka, model
			 JOIN Klienci ON model.ID = Klienci.ID 
			WHERE
				Klienci.ID = @KlientID AND Marka.ID=@KlientID
		
		select * from funkcja2(3)
	
	/***************************3***************************************/

						CREATE  FUNCTION funkcja3
				(@wyposazenieID int) 
		RETURNS TABLE 
		AS
		RETURN

			SELECT  
					Marka.nazwa,
					model.model,
					Wyposazenie.Rodzajwyposazenia
			FROM model,Marka
			JOIN Wyposazenie ON Marka.ID = Wyposazenie.ID
			WHERE
				Marka.ID = @wyposazenieID  AND model.ID = @wyposazenieID
				
				select * from funkcja3(3)


		

						/* WIDOKI */
/***************************1***************************************/

	CREATE VIEW [dbo].[Widok1]
	as
	SELECT  Klienci.Imie,
			Klienci.Nazwisko,
			Rezerwacje.dataodbioru
	FROM Rezerwacje 
	 JOIN Klienci ON Rezerwacje.KlientID = Klienci.ID 

	
		SELECT * from widok1

/***************************2***************************************/

			CREATE VIEW [dbo].[Widok2]
			as
			SELECT  
					model.model,
					Marka.nazwa,
					model.Cena
			FROM Marka
			JOIN model ON Marka.ID = Model.ID
			WHERE cena>'120000'

			SELECT * from widok2

					/* ZAPYTANIA */

/***************************1***************************************/
SELECT * FROM Dostawcy where Nazwa LIKE 'BMW%'
/***************************2***************************************/
SELECT * FROM Klienci WHERE Imie='barbara' AND Email LIKE '%Gruda%'
/***************************3***************************************/
	SELECT  Klienci.Imie,
			Klienci.Nazwisko,
			Rezerwacje.dataodbioru
	FROM Rezerwacje 
	 JOIN Klienci ON Rezerwacje.KlientID = Klienci.ID 
	 WHERE DataOdbioru BETWEEN '2022/02/20' AND '2022/03/20'
/***************************4***************************************/
SELECT * FROM Marka WHERE id IN (2,3)
/***************************5***************************************/
SELECT TOP 2 * FROM Pracownicy ORDER BY Imie
/***************************6***************************************/
SELECT * FROM Pracownicy WHERE Adres LIKE '%D³uga%' OR Adres LIKE '%Krakowska%'
/***************************7***************************************/
SELECT SUM(cena) AS Koszt_Wszystkich_Aut FROM model 
/***************************8***************************************/
			SELECT  
					model.ID,
					model.model,
					Marka.nazwa,
					SUM(Cena) AS cena
			FROM Marka
			LEFT JOIN model ON Marka.ID = Model.ID
			GROUP BY model.model, model.ID,marka.nazwa, model.cena	 ORDER BY cena desc	
/***************************9***************************************/
SELECT * FROM model ORDER BY 1  OFFSET 1 ROWS  
/***************************10***************************************/
SELECT MAX(cena) AS Najdrozsze_Auto,MIN(cena) AS Najtansze_Auto FROM model 

			



	