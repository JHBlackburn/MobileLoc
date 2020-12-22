
	DROP TABLE IF EXISTS #tempIlcoEntry

	SELECT 
		Id,
		KeyBlankDetails,
		IsCloner = CAST(0 as BIT),
		IsTransponder = CAST(0 as BIT),
		IsVATS = CAST(0 as BIT),
		IsProx = CAST(0 as BIT),
		IsReflashRequired = CAST(0 AS BIT),
		IsNoFlyList = CAST(0 AS BIT),
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
		
		------------------------------------------
		------------------CLONERs-----------------
		------------------------------------------
		UPDATE kb
			SET IsCloner = 1

		FROM #tempIlcoEntry as kb
		WHERE (
				kb.KeyBlankDetails like '%GTK%'
				OR kb.KeyBlankDetails like '%EK3%'
				OR kb.KeyBlankDetails like '%PT5%'
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
		AND kb.ProgramWithText <> '-'

			
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
		WHERE 
		(ModelName LIKE '%PROX%' AND ModelName NOT LIKE '%w/o%')
		OR (EntryTitle LIKE '%PROX%' AND EntryTitle NOT LIKE '%w/o%')


		
		------------------------------------------
		------------REFLASH REQUIRED--------------
		------------------------------------------				
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempIlcoEntry as kb
		WHERE KeyBlankDetails like '%TOY43AT4%'
		-- hardcoded vehicles added too




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
					kb.NotesText like '%High Security Key%'
					OR MakeName LIKE '%LEXUS%'
					OR CodeSeriesText like '%Z0001-Z6000%'
					OR CodeSeriesText like '%V0001-V5718%'

					OR KeyBlankDetails like '%HU101T%'
					OR KeyBlankDetails like '%SIP22-GTS%'
					OR KeyBlankDetails like '%HY18-P%'
					OR KeyBlankDetails like '%HY18R-P%'
					OR KeyBlankDetails like '%LX90-P%'
					OR KeyBlankDetails like '%LXP90-P%'
					OR KeyBlankDetails like '%LXV90-P%'
					OR KeyBlankDetails like '%KK10-P%'
					OR KeyBlankDetails like '%KK12-P%'
					OR KeyBlankDetails like '%HY20-PT%'
					OR KeyBlankDetails like '%HY22%'
					OR KeyBlankDetails like '%HY22%'
					OR KeyBlankDetails like '%TOY51-P%'
					OR KeyBlankDetails like '%TOY48EMER%'
					
					OR SubstituteText like '%HU101T%'
					OR SubstituteText like '%SIP22-GTS%'
					OR SubstituteText like '%HY18-P%'
					OR SubstituteText like '%HY18R-P%'
					OR SubstituteText like '%LX90-P%'
					OR SubstituteText like '%LXP90-P%'
					OR SubstituteText like '%LXV90-P%'
					OR SubstituteText like '%KK10-P%'
					OR SubstituteText like '%KK12-P%'
					OR SubstituteText like '%HY20-PT%'
					OR SubstituteText like '%HY22%'
					OR SubstituteText like '%TOY51-P%'
					OR SubstituteText like '%TOY48EMER%'

				)

		------------------------------------------
		------------Regular KeyBlade (for everything else)
		------------------------------------------	
		UPDATE kb
			SET KeyBladeType = 'Regular'
		FROM #tempIlcoEntry as kb
		WHERE KeyBladeType IS NULL



		------------------------------------------
		------------NO FLY LIST------
		------------------------------------------				
		UPDATE kb
			SET IsNoFlyList = 1
		FROM #tempIlcoEntry as kb
		WHERE 
			MakeName IN ('AUDI', 'BMW', 'FERRARI', 'FIAT', 'MERCEDES', 'MINI', 'PORSCHE', 'SAAB', 'SMART', 'VOLVO', 'LAND ROVER')
			--VW past >=2009




		
		/*************************BEGIN MERGE**********************************/
		MERGE INTO stage.IlcoEntry AS t  
				USING 
				(
					SELECT
					Id,
					IsCloner,
					IsTransponder,
					IsProx,	
					IsVATS,
					IsReflashRequired,
					IsNoFlyList,
					KeyBladeType

					FROM #tempIlcoEntry
				)  AS s  
				ON s.Id = t.Id

				WHEN MATCHED 
					THEN UPDATE 
						SET 
							IsCloner = s.IsCloner,
							IsTransponder = s.IsTransponder,
							IsProx = s.IsProx,
							IsVATS = s.IsVATS,
							IsReflashRequired = s.IsReflashRequired,
							IsNoFlyList = s.IsNoFlyList,
							KeyBladeType = s.KeyBladeType,
							DateModified = GETUTCDATE()

				;
		/*************************END MERGE**********************************/
