CREATE TABLE products.[AutoProduct]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Make varchar(100) NOT NULL,
	Model varchar(100) NOT NULL,
	IlcoEntryName varchar(100) NOT NULL,
	IlcoDetails VARCHAR(500) NOT NULL,
	PriceUSD DECIMAL(18,6) NULL
)
