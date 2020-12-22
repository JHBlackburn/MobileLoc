		DROP TABLE IF EXISTS #tempYearMakeModel

		SELECT DISTINCT 
			[Year],
			Make, 
			Model,
			KeyBlanks =	(
							SELECT DISTINCT ilco1.KeyBlankDetails + ' | ' AS [text()]
							FROM stage.IlcoEntryYearMakeModelKeyBlank ilco1
							WHERE ilco1.Make = ilco2.Make
							AND ilco1.Model = ilco2.Model
							AND ilco1.[Year] = ilco2.[Year]
							FOR XML PATH ('')
						),
			CodeSeries = (
							SELECT DISTINCT ilco1.CodeSeriesText + ' | ' AS [text()]
							FROM stage.IlcoEntryYearMakeModelKeyBlank ilco1
							WHERE ilco1.Make = ilco2.Make
							AND ilco1.Model = ilco2.Model
							AND ilco1.[Year] = ilco2.[Year]
							FOR XML PATH ('')
						),
			ProgramWith = (
							SELECT DISTINCT ilco1.ProgramWithText + ' | ' AS [text()]
							FROM stage.IlcoEntryYearMakeModelKeyBlank ilco1
							WHERE ilco1.Make = ilco2.Make
							AND ilco1.Model = ilco2.Model
							AND ilco1.[Year] = ilco2.[Year]
							FOR XML PATH ('')

						),
			Substitute = (
							SELECT DISTINCT ilco1.SubstituteText + ' | ' AS [text()]
							FROM stage.IlcoEntryYearMakeModelKeyBlank ilco1
							WHERE ilco1.Make = ilco2.Make
							AND ilco1.Model = ilco2.Model
							AND ilco1.[Year] = ilco2.[Year]
							FOR XML PATH ('')

						),
			Notes = (
							SELECT DISTINCT ilco1.NotesText + ' | ' AS [text()]
							FROM stage.IlcoEntryYearMakeModelKeyBlank ilco1
							WHERE ilco1.Make = ilco2.Make
							AND ilco1.Model = ilco2.Model
							AND ilco1.[Year] = ilco2.[Year]
							FOR XML PATH ('')
						),
			KeyBladeType = ilco2.KeyBladeType,
			IsCloner = CAST(MAX(CAST(ilco2.IsCloner as INT)) OVER(PARTITION BY ilco2.Year, ilco2.Make, ilco2.Model) as BIT),
			IsTransponder= CAST(MAX(CAST(ilco2.IsTransponder as INT)) OVER(PARTITION BY ilco2.Year, ilco2.Make, ilco2.Model) as BIT),
			IsProx = CAST(MAX(CAST(ilco2.IsProx as INT)) OVER(PARTITION BY ilco2.Year, ilco2.Make, ilco2.Model) as BIT),	
			IsVATS = CAST(MAX(CAST(ilco2.IsVATS as INT)) OVER(PARTITION BY ilco2.Year, ilco2.Make, ilco2.Model) as BIT),
			IsReflashRequired = CAST(MAX(CAST(ilco2.IsReflashRequired as INT)) OVER(PARTITION BY ilco2.Year, ilco2.Make, ilco2.Model) as BIT),
			IsNoFlyList = CAST(MAX(CAST(ilco2.IsNoFlyList as INT)) OVER(PARTITION BY ilco2.Year, ilco2.Make, ilco2.Model) as BIT)
		INTO #tempYearMakeModel
		FROM stage.IlcoEntryYearMakeModelKeyBlank ilco2

		

		UPDATE temp
		SET 
			temp.KeyBlanks = RTRIM(LTRIM(LEFT(temp.KeyBlanks, LEN(temp.KeyBlanks)-2))),
			temp.CodeSeries = RTRIM(LTRIM(LEFT(temp.CodeSeries, LEN(temp.CodeSeries)-2))),
			temp.ProgramWith = RTRIM(LTRIM(LEFT(temp.ProgramWith, LEN(temp.ProgramWith)-2))),
			temp.Substitute = RTRIM(LTRIM(LEFT(temp.Substitute, LEN(temp.Substitute)-2))),
			temp.Notes = RTRIM(LTRIM(LEFT(temp.Notes, LEN(temp.Notes)-2)))

		FROM #tempYearMakeModel temp

		UPDATE temp
		SET 
			temp.KeyBlanks = NULLIF(NULLIF(temp.KeyBlanks, '-'), ''),
			temp.CodeSeries = NULLIF(NULLIF(temp.CodeSeries, '-'), ''),
			temp.ProgramWith = NULLIF(NULLIF(temp.ProgramWith, '-'), ''),
			temp.Substitute = NULLIF(NULLIF(temp.Substitute, '-'), ''),
			temp.Notes = NULLIF(NULLIF(temp.Notes, '-'), '')
		--SELECT * 
		FROM #tempYearMakeModel temp

				/*************************BEGIN MERGE**********************************/
		MERGE INTO autos.[YearMakeModel] AS t  
				USING 
				(
					SELECT
						[Year], 
						Make, 
						Model,
						KeyBlanks,
						CodeSeries,
						Substitute,
						ProgramWith,
						Notes,
						KeyBladeType,
						IsCloner,
						IsTransponder,
						IsProx,	
						IsVATS,
						IsReflashRequired,
						IsNoFlyList,
						1 as IsActive

						FROM #tempYearMakeModel
				)  AS s  
				ON s.Year = t.Year
				AND s.Make = t.Make
				AND s.Model = t.Model

				WHEN MATCHED 
					THEN UPDATE 
						SET 
							KeyBlanks = s.KeyBlanks,
							CodeSeries = s.CodeSeries,
							Substitute = s.Substitute,
							ProgramWith = s.ProgramWith,
							Notes = s.Notes,
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
						[Year], 
						Make, 
						Model,
						KeyBlanks,
						CodeSeries,
						Substitute,
						ProgramWith,
						Notes,
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
						[Year], 
						Make, 
						Model,
						KeyBlanks,
						CodeSeries,
						Substitute,
						ProgramWith,
						Notes,
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

