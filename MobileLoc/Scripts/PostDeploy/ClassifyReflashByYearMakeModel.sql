		DROP TABLE IF EXISTS #tempReflash
		SELECT 
			Id,
			[Year], 
			Make, 
			Model, 
			KeyBlankDetails, 
			IsReflashRequired

		INTO #tempReflash
		FROM stage.IlcoEntryYearMakeModelKeyBlank mmkb


		--2003-2007 Toyota Sequoia
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%Sequoia%'
			AND YEAR BETWEEN 2003 and 2007

			
		--2001-2003 Toyota Rav4
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%Rav4%'
			AND YEAR BETWEEN 2001 and 2003


		--2000-2003 Toyota Prius
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%Prius%'
			AND YEAR BETWEEN 2000 and 2003

			
		--2000-2005 Toyota MR2
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%MR2%'
			AND YEAR BETWEEN 2000 and 2005


		--2001-2003 Toyota Highlander (with 4 cyclinder)
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%Highlander%'
			ANd KeyBlankDetails like '%TOY43AT4%'
			ANd Year BETWEEN 2001 and 2003


			
			
		--1998-2001 Toyota Camry
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%Camry%'
			AND YEAR BETWEEN 1998 and 2001


		--1998-2004 Toyota Avalon
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%Avalon%'
			AND YEAR BETWEEN 1998 and 2004


		--1998-2000 Toyota 4Runner
		UPDATE kb
			SET IsReflashRequired = 1
		FROM #tempReflash as kb
		WHERE 
			kb.Make = 'TOYOTA'
			AND Model like '%4 Runner%'
			AND YEAR BETWEEN 1998 and 2000


			
		/*************************BEGIN UPDATE TARGET TABLE**********************************/
		UPDATE  ymmkb
			SET 
				ymmkb.IsReflashRequired = temp.IsReflashRequired

		FROM stage.IlcoEntryYearMakeModelKeyBlank ymmkb
		JOIN #tempReflash temp
			ON ymmkb.Id = temp.Id
				;
		/*************************END UPDATE TARGET TABLE**********************************/