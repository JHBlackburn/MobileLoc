CREATE TABLE stage.[IlcoEntry]
(
	MakeName NVARCHAR(100) NOT NULL,
	ModelName NVARCHAR(100) NOT NULL,
	EntryTitle NVARCHAR(500) NOT NULL,
	KeyBlankDetails NVARCHAR(500) NULL,
	CodeSeriesText NVARCHAR(500) NULL,
	SubstituteText NVARCHAR(500) NULL,
	ProgramWithText NVARCHAR(500) NULL,
	NotesText NVARCHAR(500) NULL,
	DateCreated DATETIME2 NOT NULL DEFAULT GETUTCDATE(),


)
GO
	CREATE CLUSTERED INDEX CI_IlcoEntry ON stage.[IlcoEntry] (MakeName, ModelName, EntryTitle, KeyBlankDetails)
