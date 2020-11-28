CREATE TABLE products.[AutoProduct]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	YearMakeModel NVARCHAR(500) NOT NULL,
	MakeName varchar(100) NOT NULL,
	ModelName varchar(100) NOT NULL,
	[Year] INT NOT NULL,
	IlcoEntryTitle varchar(100) NOT NULL,
	IlcoKeyBlanks VARCHAR(1000) NOT NULL,
	IlcoCodeSeries VARCHAR(1000) NOT NULL,
	IlcoProgramWith VARCHAR(1000) NOT NULL,
	IlcoSubstitute VARCHAR(1000) NOT NULL,
	IlcoNotes VARCHAR(1000) NOT NULL,
	SetUpKeysPriceUSD DECIMAL(18,6) NULL
)
