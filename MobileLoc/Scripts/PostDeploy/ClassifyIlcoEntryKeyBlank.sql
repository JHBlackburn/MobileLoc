
	DROP TABLE IF EXISTS #tempIlcoEntry

	SELECT DISTINCT 
		KeyBlankDetails,
		IsCloner = CAST(0 as BIT),
		IsTransponder = CAST(0 as BIT),
		IsVATS = CAST(0 as BIT),
		IsProx = CAST(0 as BIT),
		KeyBladeType = CAST(NULL AS NVARCHAR(100)),
		MakeName,
		ModelName,
		EntryTitle,
		CodeSeriesText,
		SubstituteText,
		ProgramWithText,
		NotesText
		INTO #tempIlcoEntry
		FROM stage.IlcoEntry s
		WHERE NULLIF(s.KeyBlankDetails, '') IS NOT NULL
		
		------------------------------------------
		------------------CLONERs-----------------
		------------------------------------------
		UPDATE kb
			SET IsCloner = 1

		FROM #tempIlcoEntry as kb
		WHERE (
				kb.KeyBlankDetails like '%GTK%'
				OR kb.KeyBlankDetails like '%EK3%'
				OR (kb.KeyBlankDetails like '%PT5%' ANd kb.KeyBlankDetails like '%HD%')
				OR kb.KeyBlankDetails like '%FO21MH%'
				)
		
		------------------------------------------
		------------------TRANSPONDERs------------
		------------------------------------------
		UPDATE kb
			SET IsTransponder = 1
		--SELECT *
		FROM #tempIlcoEntry as kb
		WHERE NULLIF(kb.ProgramWithText, '') IS NOT NULL

			
		------------------------------------------
		------------------VATS--------------------
		------------------------------------------
		UPDATE #tempIlcoEntry
		SET IsVATS = 1
		WHERE KeyBlankDetails LIKE '%VATS%'

			
		------------------------------------------
		------------------PROX--------------------
		------------------------------------------					
		UPDATE #tempIlcoEntry
		SET IsProx = 1
		WHERE ModelName LIKE '%PROX%' 
		AND ModelName NOT LIKE '%w/o%'


		-------------------------------------------------------	
		-----------------Key Blade Type------------------------	
		-------------------------------------------------------
		
		------------------------------------------
		------------------Tibbe--------------------
		------------------------------------------	
		UPDATE kb
			SET KeyBladeType = 'Tibbe'
		--SELECT *
		FROM #tempIlcoEntry as kb
		WHERE 
			KeyBladeType IS NULL 
			AND 
				(
					kb.CodeSeriesText like '%T111111-T444444%'
					OR 
						(
							KeyBlankDetails			LIKE '%FO21T7%' 
							OR kb.KeyBlankDetails	LIKE '%FO21T17%'  
							OR KeyBlankDetails		LIKE '%TBE1T5%'  
							OR KeyBlankDetails		LIKE '%FO21MH%'  
						)
				)

		------------------------------------------
		------------High Security/Sidewinder------
		------------------------------------------				
		UPDATE kb
			SET KeyBladeType = 'High Security/Sidewinder'
		FROM #tempIlcoEntry as kb
		WHERE 
			KeyBladeType IS NULL 
			AND 
				(
					kb.NotesText like 'High Security Key'
					OR CodeSeriesText like '%Z0001-Z6000%'
					OR CodeSeriesText like '%V0001-V5718%'
				)



		--SELECT * FROM #tempIlcoEntry