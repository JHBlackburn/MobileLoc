DROP TABLE IF EXISTS #reflashAuto

CREATE TABLE #reflashAuto
(
	ItemName NVARCHAR(100) NOT NULL,
	Year INT,
	MakeName NVARCHAR(100),
	ModelName NVARCHAR(100)
)

	INSERT INTO #reflashAuto
	(
		ItemName,
		Year,
		MakeName, 
		ModelName
	)
		VALUES
			( '1996 Acura RL', 1996, 'Acura', 'RL' ),
			( '1997 Acura NSX', 1997, 'Acura', 'NSX' ),
			( '1997 Acura RL', 1997, 'Acura', 'RL' ),
			( '1997 Honda Prelude', 1997, 'Honda', 'Prelude' ),
			( '1998 Acura NSX', 1998, 'Acura', 'NSX' ),
			( '1998 Acura RL', 1998, 'Acura', 'RL' ),
			( '1998 Honda Prelude', 1998, 'Honda', 'Prelude' ),
			( '1998 Lexus ES300', 1998, 'Lexus', 'ES300' ),
			( '1998 Lexus GS300', 1998, 'Lexus', 'GS300' ),
			( '1998 Lexus GS400', 1998, 'Lexus', 'GS400' ),
			( '1998 Lexus LX470', 1998, 'Lexus', 'LX470' ),
			( '1998 Lexus RX300', 1998, 'Lexus', 'RX300' ),
			( '1998 Lexus SC300/400', 1998, 'Lexus', 'SC300/400' ),
			( '1998 Toyota 4 Runner', 1998, 'Toyota', '4 Runner' ),
			( '1998 Toyota Avalon', 1998, 'Toyota', 'Avalon' ),
			( '1998 Toyota Camry', 1998, 'Toyota', 'Camry' ),
			( '1998 Toyota Sienna', 1998, 'Toyota', 'Sienna' ),
			( '1998 Toyota Solara', 1998, 'Toyota', 'Solara' ),
			( '1998 Toyota Tacoma', 1998, 'Toyota', 'Tacoma' ),
			( '1999 Acura NSX', 1999, 'Acura', 'NSX' ),
			( '1999 Acura RL', 1999, 'Acura', 'RL' ),
			( '1999 Honda Prelude', 1999, 'Honda', 'Prelude' ),
			( '1999 Lexus ES300', 1999, 'Lexus', 'ES300' ),
			( '1999 Lexus GS300', 1999, 'Lexus', 'GS300' ),
			( '1999 Lexus GS400', 1999, 'Lexus', 'GS400' ),
			( '1999 Lexus LX470', 1999, 'Lexus', 'LX470' ),
			( '1999 Lexus RX300', 1999, 'Lexus', 'RX300' ),
			( '1999 Toyota 4 Runner', 1999, 'Toyota', '4 Runner' ),
			( '1999 Toyota Avalon', 1999, 'Toyota', 'Avalon' ),
			( '1999 Toyota Camry', 1999, 'Toyota', 'Camry' ),
			( '1999 Toyota Land Cruiser', 1999, 'Toyota', 'Land Cruiser' ),
			( '1999 Toyota Sienna', 1999, 'Toyota', 'Sienna' ),
			( '1999 Toyota Solara', 1999, 'Toyota', 'Solara' ),
			( '1999 Toyota Tacoma', 1999, 'Toyota', 'Tacoma' ),
			( '2000 Acura DL', 2000, 'Acura', 'DL' ),
			( '2000 Acura NSX', 2000, 'Acura', 'NSX' ),
			( '2000 Honda Prelude', 2000, 'Honda', 'Prelude' ),
			( '2000 Lexus ES300', 2000, 'Lexus', 'ES300' ),
			( '2000 Lexus GS300', 2000, 'Lexus', 'GS300' ),
			( '2000 Lexus GS400', 2000, 'Lexus', 'GS400' ),
			( '2000 Lexus LX470', 2000, 'Lexus', 'LX470' ),
			( '2000 Lexus RX300', 2000, 'Lexus', 'RX300' ),
			( '2000 Lexus SC300/400', 2000, 'Lexus', 'SC300/400' ),
			( '2000 Toyota 4 Runner', 2000, 'Toyota', '4 Runner' ),
			( '2000 Toyota Avalon', 2000, 'Toyota', 'Avalon' ),
			( '2000 Toyota Camry', 2000, 'Toyota', 'Camry' ),
			( '2000 Toyota Land Cruiser', 2000, 'Toyota', 'Land Cruiser' ),
			( '2000 Toyota MR2', 2000, 'Toyota', 'MR2' ),
			( '2000 Toyota Sienna', 2000, 'Toyota', 'Sienna' ),
			( '2000 Toyota Solara', 2000, 'Toyota', 'Solara' ),
			( '2000 Toyota Tacoma', 2000, 'Toyota', 'Tacoma' ),
			( '2001 Acura DL', 2001, 'Acura', 'DL' ),
			( '2001 Acura NSX', 2001, 'Acura', 'NSX' ),
			( '2001 Honda Prelude', 2001, 'Honda', 'Prelude' ),
			( '2001 Lexus ES300', 2001, 'Lexus', 'ES300' ),
			( '2001 Lexus GS300', 2001, 'Lexus', 'GS300' ),
			( '2001 Lexus GS430', 2001, 'Lexus', 'GS430' ),
			( '2001 Lexus GX470', 2001, 'Lexus', 'GX470' ),
			( '2001 Lexus IS300', 2001, 'Lexus', 'IS300' ),
			( '2001 Lexus LS430', 2001, 'Lexus', 'LS430' ),
			( '2001 Lexus LX470', 2001, 'Lexus', 'LX470' ),
			( '2001 Lexus RX300', 2001, 'Lexus', 'RX300' ),
			( '2001 Toyota 4 Runner', 2001, 'Toyota', '4 Runner' ),
			( '2001 Toyota Avalon', 2001, 'Toyota', 'Avalon' ),
			( '2001 Toyota Camry', 2001, 'Toyota', 'Camry' ),
			( '2001 Toyota Highlander', 2001, 'Toyota', 'Highlander' ),
			( '2001 Toyota Land Cruiser', 2001, 'Toyota', 'Land Cruiser' ),
			( '2001 Toyota MR2', 2001, 'Toyota', 'MR2' ),
			( '2001 Toyota Prius', 2001, 'Toyota', 'Prius' ),
			( '2001 Toyota Sequoia', 2001, 'Toyota', 'Sequoia' ),
			( '2001 Toyota Sienna', 2001, 'Toyota', 'Sienna' ),
			( '2001 Toyota Solara', 2001, 'Toyota', 'Solara' ),
			( '2002 Acura DL', 2002, 'Acura', 'DL' ),
			( '2002 Acura NSX', 2002, 'Acura', 'NSX' ),
			( '2002 Honda Prelude', 2002, 'Honda', 'Prelude' ),
			( '2002 Lexus ES300', 2002, 'Lexus', 'ES300' ),
			( '2002 Lexus GS300', 2002, 'Lexus', 'GS300' ),
			( '2002 Lexus GS430', 2002, 'Lexus', 'GS430' ),
			( '2002 Lexus GX470', 2002, 'Lexus', 'GX470' ),
			( '2002 Lexus IS300', 2002, 'Lexus', 'IS300' ),
			( '2002 Lexus LS430', 2002, 'Lexus', 'LS430' ),
			( '2002 Lexus LX470', 2002, 'Lexus', 'LX470' ),
			( '2002 Lexus RX300', 2002, 'Lexus', 'RX300' ),
			( '2002 Lexus SC430', 2002, 'Lexus', 'SC430' ),
			( '2002 Toyota 4 Runner', 2002, 'Toyota', '4 Runner' ),
			( '2002 Toyota Avalon', 2002, 'Toyota', 'Avalon' ),
			( '2002 Toyota Camry', 2002, 'Toyota', 'Camry' ),
			( '2002 Toyota Highlander', 2002, 'Toyota', 'Highlander' ),
			( '2002 Toyota Land Cruiser', 2002, 'Toyota', 'Land Cruiser' ),
			( '2002 Toyota MR2', 2002, 'Toyota', 'MR2' ),
			( '2002 Toyota Prius', 2002, 'Toyota', 'Prius' ),
			( '2002 Toyota Rav 4', 2002, 'Toyota', 'Rav 4' ),
			( '2002 Toyota Sequoia', 2002, 'Toyota', 'Sequoia' ),
			( '2002 Toyota Sienna', 2002, 'Toyota', 'Sienna' ),
			( '2002 Toyota Solara', 2002, 'Toyota', 'Solara' ),
			( '2003 Acura DL', 2003, 'Acura', 'DL' ),
			( '2003 Acura NSX', 2003, 'Acura', 'NSX' ),
			( '2003 Lexus ES300', 2003, 'Lexus', 'ES300' ),
			( '2003 Lexus GS300', 2003, 'Lexus', 'GS300' ),
			( '2003 Lexus GS430', 2003, 'Lexus', 'GS430' ),
			( '2003 Lexus GX470', 2003, 'Lexus', 'GX470' ),
			( '2003 Lexus IS300', 2003, 'Lexus', 'IS300' ),
			( '2003 Lexus LS430', 2003, 'Lexus', 'LS430' ),
			( '2003 Lexus LX470', 2003, 'Lexus', 'LX470' ),
			( '2003 Lexus RX300', 2003, 'Lexus', 'RX300' ),
			( '2003 Lexus SC430', 2003, 'Lexus', 'SC430' ),
			( '2003 Toyota 4 Runner', 2003, 'Toyota', '4 Runner' ),
			( '2003 Toyota Camry', 2003, 'Toyota', 'Camry' ),
			( '2003 Toyota Highlander', 2003, 'Toyota', 'Highlander' ),
			( '2003 Toyota Land Cruiser', 2003, 'Toyota', 'Land Cruiser' ),
			( '2003 Toyota MR2', 2003, 'Toyota', 'MR2' ),
			( '2003 Toyota Prius', 2003, 'Toyota', 'Prius' ),
			( '2003 Toyota Rav 4', 2003, 'Toyota', 'Rav 4' ),
			( '2003 Toyota Sequoia', 2003, 'Toyota', 'Sequoia' ),
			( '2003 Toyota Sienna', 2003, 'Toyota', 'Sienna' ),
			( '2003 Toyota Solara', 2003, 'Toyota', 'Solara' ),
			( '2004 Acura DL', 2004, 'Acura', 'DL' ),
			( '2004 Acura NSX', 2004, 'Acura', 'NSX' ),
			( '2004 Lexus ES330', 2004, 'Lexus', 'ES330' ),
			( '2004 Lexus LS430', 2004, 'Lexus', 'LS430' ),
			( '2004 Lexus LX470', 2004, 'Lexus', 'LX470' ),
			( '2004 Lexus RX330/400', 2004, 'Lexus', 'RX330/400' ),
			( '2004 Lexus SC 430', 2004, 'Lexus', 'SC 430' ),
			( '2004 Toyota 4 Runner', 2004, 'Toyota', '4 Runner' ),
			( '2004 Toyota Avalon', 2004, 'Toyota', 'Avalon' ),
			( '2004 Toyota Camry', 2004, 'Toyota', 'Camry' ),
			( '2004 Toyota Highlander', 2004, 'Toyota', 'Highlander' ),
			( '2004 Toyota Land Cruiser', 2004, 'Toyota', 'Land Cruiser' ),
			( '2004 Toyota MR2', 2004, 'Toyota', 'MR2' ),
			( '2004 Toyota Prius', 2004, 'Toyota', 'Prius' ),
			( '2004 Toyota Rav 4', 2004, 'Toyota', 'Rav 4' ),
			( '2004 Toyota Sequoia', 2004, 'Toyota', 'Sequoia' ),
			( '2004 Toyota Sienna', 2004, 'Toyota', 'Sienna' ),
			( '2004 Toyota Solara', 2004, 'Toyota', 'Solara' ),
			( '2005 Acura DL', 2005, 'Acura', 'DL' ),
			( '2005 Acura NSX', 2005, 'Acura', 'NSX' ),
			( '2005 Lexus ES330', 2005, 'Lexus', 'ES330' ),
			( '2005 Lexus LX470', 2005, 'Lexus', 'LX470' ),
			( '2005 Lexus RX330/400', 2005, 'Lexus', 'RX330/400' ),
			( '2005 Lexus SC430', 2005, 'Lexus', 'SC430' ),
			( '2005 Toyota 4 Runner', 2005, 'Toyota', '4 Runner' ),
			( '2005 Toyota Camry', 2005, 'Toyota', 'Camry' ),
			( '2005 Toyota Corolla', 2005, 'Toyota', 'Corolla' ),
			( '2005 Toyota Highlander', 2005, 'Toyota', 'Highlander' ),
			( '2005 Toyota Land Cruiser', 2005, 'Toyota', 'Land Cruiser' ),
			( '2005 Toyota Matrix', 2005, 'Toyota', 'Matrix' ),
			( '2005 Toyota MR2', 2005, 'Toyota', 'MR2' ),
			( '2005 Toyota Prius', 2005, 'Toyota', 'Prius' ),
			( '2005 Toyota Rav 4', 2005, 'Toyota', 'Rav 4' ),
			( '2005 Toyota Sequoia', 2005, 'Toyota', 'Sequoia' ),
			( '2005 Toyota Sienna', 2005, 'Toyota', 'Sienna' ),
			( '2005 Toyota Solara', 2005, 'Toyota', 'Solara' ),
			( '2006 Lexus ES330', 2006, 'Lexus', 'ES330' ),
			( '2006 Lexus RX330/400', 2006, 'Lexus', 'RX330/400' ),
			( '2006 Lexus SC430', 2006, 'Lexus', 'SC430' ),
			( '2006 Toyota 4 Runner', 2006, 'Toyota', '4 Runner' ),
			( '2006 Toyota Camry', 2006, 'Toyota', 'Camry' ),
			( '2006 Toyota Corolla', 2006, 'Toyota', 'Corolla' ),
			( '2006 Toyota Highlander', 2006, 'Toyota', 'Highlander' ),
			( '2006 Toyota Land Cruiser', 2006, 'Toyota', 'Land Cruiser' ),
			( '2006 Toyota Matrix', 2006, 'Toyota', 'Matrix' ),
			( '2006 Toyota Prius', 2006, 'Toyota', 'Prius' ),
			( '2006 Toyota Rav 4', 2006, 'Toyota', 'Rav 4' ),
			( '2006 Toyota Sequoia', 2006, 'Toyota', 'Sequoia' ),
			( '2006 Toyota Sienna', 2006, 'Toyota', 'Sienna' ),
			( '2006 Toyota Solara', 2006, 'Toyota', 'Solara' ),
			( '2007 Toyota Rav 4', 2007, 'Toyota', 'Rav 4' )




	
		/*************************BEGIN MERGE**********************************/

		MERGE INTO [auto].ReflashRequired AS t  
				USING 
				(
					SELECT
						ItemName,
						[Year],
						MakeName,
						ModelName

						FROM #reflashAuto
				)  AS s  
				ON s.[Year] = t.[Year]
				AND s.MakeName = t.MakeName
				AND s.ModelName = t.ModelName

				WHEN MATCHED 
					THEN UPDATE 
						SET 
							t.ItemName = s.ItemName

				WHEN NOT MATCHED BY TARGET THEN  
					INSERT 
					(
						ItemName,
						[Year],
						MakeName,
						ModelName
					) 	
					VALUES
					(
						ItemName,
						[Year],
						MakeName,
						ModelName
					)
				;
		/*************************END MERGE**********************************/
