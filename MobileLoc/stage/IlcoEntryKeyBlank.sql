CREATE TABLE stage.[IlcoEntryKeyBlank]
(
	KeyBlankDetails NVARCHAR(500) PRIMARY KEY,
	KeyBlankType NVARCHAR(100) NULL,

	CONSTRAINT CK_stage_IlcoEntryKeyBlank_KeyBlankType CHECK (KeyBlankType IS NULL OR KeyBlankType IN ('Metal', 'HiSecurity', 'Transponder', 'VATS', 'Proximity'))
)
