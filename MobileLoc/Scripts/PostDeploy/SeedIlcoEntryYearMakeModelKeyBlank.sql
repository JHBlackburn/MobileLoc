		--list of keyblanks concatenated at make model, year range, grain
		DROP TABLE IF EXISTS #tempYearRangeEntry
		SELECT DISTINCT 
			IlcoEntryId = ilco2.Id, 
			ilco2.MakeName, 
			ilco2.ModelName,

			StartYear = cast(null AS NVARCHAR(10)),
			EndYear = cast(null AS NVARCHAR(10)),

			ilco2.EntryTitle,
			ilco2.KeyBlankDetails,
			ilco2.CodeSeriesText,
			ilco2.SubstituteText,
			ilco2.ProgramWithText,
			ilco2.NotesText,
			ilco2.KeyBladeType,
			ilco2.IsCloner,
			ilco2.IsTransponder,
			ilco2.IsProx,	
			ilco2.IsVATS,
			ilco2.IsReflashRequired,
			ilco2.IsNoFlyList

		INTO #tempYearRangeEntry
		FROM stage.IlcoEntry ilco2


		---------------------------------------------------------------------------
		--clean up the bad year data manually
			DROP TABLE IF EXISTS #NonConformistRecords
			CREATE TABLE #NonConformistRecords
			(
				EntryTitle NVARCHAR(500) PRIMARY KEY,
				StartYear INT,
				EndYear INT
			)
			INSERT INTO #NonConformistRecords
			(
				EntryTitle, 
				StartYear, 
				EndYear
			)
			VALUES
			('Apr-05 - 2006 BUICK Terraza',2005, 2006),
			('Jan-05 - Mar-05 BUICK Terraza',2005, 2005),
			('1/05 - 3/05 CHEVROLET TRUCKS, VANS, SUVS Uplander Mini Van', 2005, 2005),
			('mid-2001 - 2010 FORD TRUCKS, VANS, SUVS Explorer Sport Trac', 2001, 2010),
			('1999 - mid-1999 NISSAN/DATSUN Pathfinder', 1999, 1999),
			('mid-1999 - 2004 NISSAN/DATSUN Pathfinder', 1999, 2004),
			('Mid Jan 2005 - Mar-05 PONTIAC Montana, Montana SV6', 2005, 2005),
			('mid-2010 - 2015 TOYOTA Venza w/ Prox', 2010, 2015),
			('mid-2010 - 2015 TOYOTA Venza w/ Regular Ignition', 2010, 2015),
			('Pre 1980 - 1980 WHITE-GMC-VOLVO US Designed', 1980, 1980),
			('All - All DODGE TRUCKS, VANS, SUVS D50 Pickup', 1980, 1980),
			('1999 - mid-2001 FORD TRUCKS, VANS, SUVS Explorer Sport', 1999, 2001),
			('1998 - mid-2001 FORD TRUCKS, VANS, SUVS Explorer', 1998, 2001),
			('2001 - mid-2006 KIA Optima', 2001, 2006),
			('2005 - mid-2010 TOYOTA Corolla', 2005, 2010),
			('mid-2010 - 2013 TOYOTA Corolla', 2010, 2013),
			('All - All DIAMOND REO All', 1980, 2013),
			('mid-2001 - 2010 FORD TRUCKS, VANS, SUVS Explorer', 2001, 2010),
			('All - All NISSAN/DATSUN UD Diesel Truck', 1980, 1997),
			('Pre 1989 - 1989 MITSUBISHI Fuso Truck', 1982, 1991),
			('mid-2001 - 2006 MITSUBISHI Montero Sport', 2001, 2006),
			('Early 2005 - Early 2005 SATURN Relay', 2005, 2005),
			('2019 - SUBARU Forester w/ Regular Ignition', 2019, 2019)


		UPDATE mmkb
		SET 
			StartYear = ncr.StartYear,
			EndYear = ncr.EndYear
		FROM #tempYearRangeEntry mmkb
		JOIN #NonConformistRecords ncr
		on mmkb.EntryTitle = ncr.EntryTitle
		WHERE mmkb.StartYear IS NULL
		AND mmkb.EndYear IS NULL

		-----------------------------------------------------------------------------------------------
		--Update remaining well-behaved records
		UPDATE #tempYearRangeEntry
		SET 
			StartYear = LEFT(EntryTitle, CHARINDEX(' - ', EntryTitle)-1),
			EndYear = LEFT(RIGHT(EntryTitle, LEN(EntryTitle) - CHARINDEX(' - ', EntryTitle)-2), 4)
		WHERE StartYear IS NULL
		AND EndYear IS NULL


		-----------------------------------------------------------------------------------------------
		DECLARE @minStartYear INT = (SELECT MIN(TRY_CAST(StartYear as INT)) FROM #tempYearRangeEntry)	
		DECLARE @maxEndYear INT = (SELECT MAX(TRY_CAST(EndYear as INT)) FROM #tempYearRangeEntry)

		DROP TABLE IF EXISTS #distinctYears
		CREATE TABLE #distinctYears
			( 
				TheYear INT NOT NULL
			)

		DECLARE @thisYear INT = @minStartYear
		WHILE @thisYear <= @maxEndYear
			BEGIN
				INSERT INTO #distinctYears
				VALUES (@thisYear)

				SET @thisYear += 1
			END

		----------------------------------------------------------------------
		--Move to (make, model, year) grain
		DROP TABLE IF EXISTS #tempYearMakeModelKeyBlank
		SELECT DISTINCT
			IlcoEntryId,
			Year = [TheYear], 
			MakeName, 
			ModelName, 
			EntryTitle,
			KeyBlankDetails,
			CodeSeriesText,
			SubstituteText,
			ProgramWithText,
			NotesText,
			KeyBladeType,
			IsCloner,
			IsTransponder,
			IsProx,	
			IsVATS,
			IsReflashRequired,
			IsNoFlyList

		INTO #tempYearMakeModelKeyBlank
		FROM #tempYearRangeEntry mmkb
		LEFT JOIN #distinctYears dy
		on dy.TheYear BETWEEN TRY_CAST(mmkb.StartYear as int) and TRY_CAST(mmkb.EndYear as int)


		/*************************BEGIN MERGE**********************************/
		MERGE INTO stage.IlcoEntryYearMakeModelKeyBlank AS t  
				USING 
				(
					SELECT
						IlcoEntryId,
						[Year], 
						MakeName, 
						ModelName,
						EntryTitle,
						KeyBlankDetails,
						CodeSeriesText,
						SubstituteText,
						ProgramWithText,
						NotesText,
						KeyBladeType,
						IsCloner,
						IsTransponder,
						IsProx,	
						IsVATS,
						IsReflashRequired,
						IsNoFlyList,
						1 as IsActive

						FROM #tempYearMakeModelKeyBlank
				)  AS s  
				ON s.IlcoEntryId = t.IlcoEntryId
				AND s.Year = t.Year
				AND s.MakeName = t.Make
				AND s.ModelName = t.Model

				WHEN MATCHED 
					THEN UPDATE 
						SET 
							EntryTitle = s.EntryTitle,
							KeyBlankDetails = s.KeyBlankDetails,
							CodeSeriesText = s.CodeSeriesText,
							SubstituteText = s.SubstituteText,
							ProgramWithText = s.ProgramWithText,
							NotesText = s.NotesText,
							KeyBladeType = s.KeyBladeType,
							IsCloner = s.IsCloner,
							IsTransponder = s.IsTransponder,
							IsProx = s.IsProx,	
							IsVATS = s.IsVATS,
							IsReflashRequired = s.IsReflashRequired,
							IsNoFlyList = s.IsNoFlyList,
							t.IsActive = s.IsActive,
							DateModified = GETUTCDATE()

				WHEN NOT MATCHED BY TARGET THEN  
					INSERT 
					(
						IlcoEntryId, 
						[Year], 
						Make, 
						Model, 
						EntryTitle,
						KeyBlankDetails,
						CodeSeriesText,
						SubstituteText,
						ProgramWithText,
						NotesText,
						KeyBladeType,
						IsCloner,
						IsTransponder,
						IsProx,	
						IsVATS,
						IsReflashRequired,
						IsNoFlyList,
						IsActive
					) 	
					VALUES
					(
						IlcoEntryId, 
						[Year], 
						MakeName, 
						ModelName, 
						EntryTitle,
						KeyBlankDetails,
						CodeSeriesText,
						SubstituteText,
						ProgramWithText,
						NotesText,
						KeyBladeType,
						IsCloner,
						IsTransponder,
						IsProx,	
						IsVATS,
						IsReflashRequired,
						IsNoFlyList,
						IsActive
					)

				WHEN NOT MATCHED BY SOURCE
				THEN UPDATE
					SET IsActive = 0,
					DateModified = GETUTCDATE()
				;
		/*************************END MERGE**********************************/


