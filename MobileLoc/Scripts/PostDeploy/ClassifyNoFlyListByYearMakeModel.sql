		DROP TABLE IF EXISTS #tempNoFly
		SELECT 
			Id,
			[Year], 
			Make, 
			Model, 
			KeyBlankDetails, 
			IsNoFlyList

		INTO #tempNoFly
		FROM stage.IlcoEntryYearMakeModelKeyBlank mmkb


		--Volkswagon after 2009
		UPDATE kb
			SET IsNoFlyList = 1
		FROM #tempNoFly as kb
		WHERE 
			kb.Make = 'VOLKSWAGEN'
			AND YEAR >= 2009


			
		/*************************BEGIN UPDATE TARGET TABLE**********************************/
		UPDATE  ymmkb
			SET 
				ymmkb.IsNoFlyList = temp.IsNoFlyList

		FROM stage.IlcoEntryYearMakeModelKeyBlank ymmkb
		JOIN #tempNoFly temp
			ON ymmkb.Id = temp.Id
				;
		/*************************END UPDATE TARGET TABLE**********************************/