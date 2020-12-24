DROP TABLE IF EXISTS #tempSquareItem

CREATE TABLE #tempSquareItem
(
	[Token] nvarchar(255) NULL DEFAULT(''),
	[Item Name] nvarchar(255) NULL,
	[Description] nvarchar(2000) NULL,
	[Category] nvarchar(255) NULL,
	[SKU] nvarchar(255) NULL,
	[Variation Name] nvarchar(255) NULL,
	[Price] float NULL DEFAULT('0.00'),
	[Option Name 1] nvarchar(255) NULL DEFAULT(''),
	[Option Value 1] nvarchar(255) NULL DEFAULT(''),
	[Current Quantity Mobile Locksmith, Inc#] nvarchar(255) NULL DEFAULT(''),
	[New Quantity Mobile Locksmith, Inc#] nvarchar(255) NULL DEFAULT(''),
	[Stock Alert Enabled Mobile Locksmith, Inc#] nvarchar(255) NULL DEFAULT(''),
	[Stock Alert Count Mobile Locksmith, Inc#] nvarchar(255) NULL DEFAULT(''), 
	[Modifier Set - Automotive - Hi-Security Non-Transponder] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - Hi-Security Transponder] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - Proximity] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - Regular Metal] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - Regular Transponder] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - Remotes] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - Tibbe Non-Transponder] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - Tibbe Transponder] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Automotive - VATS] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Key Blanks Costs] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Lock Finishes] nvarchar(255) NULL DEFAULT('N'),
	[Modifier Set - Lock Functions] nvarchar(255) NULL DEFAULT('N'),
	[Tax - Sales Tax (7%)] nvarchar(255) NULL
) 


DECLARE @spacing NVARCHAR(20) = '    '

INSERT INTO #tempSquareItem
	(
		[Item Name],
		[Description],
		[Category],
		[SKU],
		[Variation Name],
		[Price],
		[Modifier Set - Automotive - Hi-Security Non-Transponder],
		[Modifier Set - Automotive - Hi-Security Transponder],
		[Modifier Set - Automotive - Proximity],
		[Modifier Set - Automotive - Regular Metal],
		[Modifier Set - Automotive - Regular Transponder],
		[Modifier Set - Automotive - Remotes],
		[Modifier Set - Automotive - Tibbe Non-Transponder],
		[Modifier Set - Automotive - Tibbe Transponder],
		[Modifier Set - Automotive - VATS],
		[Tax - Sales Tax (7%)]
	)
	SELECT DISTINCT
		[Item Name] = CONCAT(
							CASE WHEN ymm.IsNoFlyList = 1 THEN '(NO FLY LIST) ' ELSE '' END,
							ymm.Year, ' ', 
							ymm.Make, ' ', 
							ymm.Model
							),
		[Description] = CONCAT(
							'Key Blanks:  ', ymm.KeyBlanks, @spacing,
							'Substitutes:  ', ISNULL(ymm.Substitute, 'N/A'), @spacing,
							'Program With:  ', ISNULL(ymm.ProgramWith, 'N/A'), @spacing,
							'Code Series:  ', ISNULL(ymm.CodeSeries, 'N/A'), @spacing,
							'Notes:  ', ISNULL(ymm.Notes, 'N/A'), '    '
							),
		Category = 'Automotive (Setup/Duplicate Keys)',
		SKU = CONCAT('AUTO_', ymm.Id),
		[Variation Name] = 'Regular',
		[Price] =  '0.00',
		[Modifier Set - Automotive - Hi-Security Non-Transponder] = (
							CASE WHEN ymm.KeyBladeType = 'High Security/Sidewinder' 
										AND IsTransponder = 0 THEN 'Y' 
								ELSE 'N' 
							END),
		[Modifier Set - Automotive - Hi-Security Transponder] = (
							CASE WHEN ymm.KeyBladeType = 'High Security/Sidewinder' 
										AND IsTransponder = 1 THEN 'Y' 
								ELSE 'N' 
							END),
		[Modifier Set - Automotive - Proximity] = (
							CASE WHEN ymm.IsProx = 1 THEN 'Y' 
								ELSE 'N' 
							END),
		[Modifier Set - Automotive - Regular Metal] = (
							CASE WHEN ymm.KeyBladeType = 'Regular' 
										AND IsTransponder = 0 THEN 'Y' 
								ELSE 'N' 
							END),
		[Modifier Set - Automotive - Regular Transponder]  = (
							CASE WHEN ymm.KeyBladeType = 'Regular' 
										AND IsTransponder = 1 THEN 'Y' 
								ELSE 'N' 
							END),

		[Modifier Set - Automotive - Remotes] = 'N',

		[Modifier Set - Automotive - Tibbe Non-Transponder]  = (
							CASE WHEN ymm.KeyBladeType = 'Tibbe' 
										AND IsTransponder = 0 THEN 'Y' 
								ELSE 'N' 
							END),
		[Modifier Set - Automotive - Tibbe Transponder]  = (
							CASE WHEN ymm.KeyBladeType = 'Tibbe' 
										AND IsTransponder = 1 THEN 'Y' 
								ELSE 'N' 
							END),
		[Modifier Set - Automotive - VATS] = (
							CASE WHEN IsVATS = 1 THEN 'Y' 
								ELSE 'N' 
							END),

		[Tax - Sales Tax (7%)] = 'Y'

	FROM autos.YearMakeModel ymm


		/*************************BEGIN MERGE**********************************/
		MERGE INTO stage.SquareItem AS t  
				USING 
				(
					SELECT DISTINCT
					Token,
					[Item Name],
					[Description],
					[Category],
					[SKU],
					[Variation Name],
					[Price],
					[Option Name 1],
					[Option Value 1],
					[Current Quantity Mobile Locksmith, Inc#],
					[New Quantity Mobile Locksmith, Inc#],
					[Stock Alert Enabled Mobile Locksmith, Inc#],
					[Stock Alert Count Mobile Locksmith, Inc#],
					[Modifier Set - Automotive - Hi-Security Non-Transponder] = MAX([Modifier Set - Automotive - Hi-Security Non-Transponder]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - Hi-Security Transponder] = MAX([Modifier Set - Automotive - Hi-Security Transponder]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - Proximity] = MAX([Modifier Set - Automotive - Proximity]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - Regular Metal] = MAX([Modifier Set - Automotive - Regular Metal]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - Regular Transponder] = MAX([Modifier Set - Automotive - Regular Transponder]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - Remotes] = MAX([Modifier Set - Automotive - Remotes]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - Tibbe Non-Transponder] = MAX([Modifier Set - Automotive - Tibbe Non-Transponder]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - Tibbe Transponder] = MAX([Modifier Set - Automotive - Tibbe Transponder]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Automotive - VATS] = MAX([Modifier Set - Automotive - VATS]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Key Blanks Costs] = MAX([Modifier Set - Key Blanks Costs]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Lock Finishes] = MAX([Modifier Set - Lock Finishes]) OVER(PARTITION BY [Item Name]),
					[Modifier Set - Lock Functions] = MAX([Modifier Set - Lock Functions]) OVER(PARTITION BY [Item Name]),
					[Tax - Sales Tax (7%)]

					FROM #tempSquareItem
				)  AS s  
				ON s.SKU = t.SKU
				

				WHEN MATCHED 
					THEN UPDATE 
						SET 
							Token = s.Token,
							[Item Name] = s.[Item Name],
							[Description] = s.[Description],
							[Category] = s.[Category],
							[SKU] = s.[SKU],
							[Variation Name] = s.[Variation Name],
							[Price] = s.[Price],
							[Option Name 1] = s.[Option Name 1],
							[Option Value 1] = s.[Option Value 1],
							[Current Quantity Mobile Locksmith, Inc#] = s.[Current Quantity Mobile Locksmith, Inc#],
							[New Quantity Mobile Locksmith, Inc#] = s.[New Quantity Mobile Locksmith, Inc#],
							[Stock Alert Enabled Mobile Locksmith, Inc#] = s.[Stock Alert Enabled Mobile Locksmith, Inc#],
							[Stock Alert Count Mobile Locksmith, Inc#] = s.[Stock Alert Count Mobile Locksmith, Inc#],
							[Modifier Set - Automotive - Hi-Security Non-Transponder] = s.[Modifier Set - Automotive - Hi-Security Non-Transponder],
							[Modifier Set - Automotive - Hi-Security Transponder] = s.[Modifier Set - Automotive - Hi-Security Transponder],
							[Modifier Set - Automotive - Proximity] = s.[Modifier Set - Automotive - Proximity],
							[Modifier Set - Automotive - Regular Metal] = s.[Modifier Set - Automotive - Regular Metal],
							[Modifier Set - Automotive - Regular Transponder] = s.[Modifier Set - Automotive - Regular Transponder],
							[Modifier Set - Automotive - Remotes] = s.[Modifier Set - Automotive - Remotes],
							[Modifier Set - Automotive - Tibbe Transponder] = s.[Modifier Set - Automotive - Tibbe Transponder],
							[Modifier Set - Automotive - Tibbe Non-Transponder] = s.[Modifier Set - Automotive - Tibbe Non-Transponder],
							[Modifier Set - Automotive - VATS] = s.[Modifier Set - Automotive - VATS],
							[Modifier Set - Key Blanks Costs] = s.[Modifier Set - Key Blanks Costs],
							[Modifier Set - Lock Finishes] = s.[Modifier Set - Lock Finishes],
							[Modifier Set - Lock Functions] = s.[Modifier Set - Lock Functions],
							[Tax - Sales Tax (7%)] = s.[Tax - Sales Tax (7%)]

					WHEN NOT MATCHED 
					THEN INSERT 
					(
					
						Token,
						[Item Name],
						[Description],
						[Category],
						[SKU],
						[Variation Name],
						[Price],
						[Option Name 1],
						[Option Value 1],
						[Current Quantity Mobile Locksmith, Inc#],
						[New Quantity Mobile Locksmith, Inc#],
						[Stock Alert Enabled Mobile Locksmith, Inc#],
						[Stock Alert Count Mobile Locksmith, Inc#],
						[Modifier Set - Automotive - Hi-Security Non-Transponder],
						[Modifier Set - Automotive - Hi-Security Transponder],
						[Modifier Set - Automotive - Proximity],
						[Modifier Set - Automotive - Regular Metal],
						[Modifier Set - Automotive - Regular Transponder],
						[Modifier Set - Automotive - Remotes],
						[Modifier Set - Automotive - Tibbe Transponder],
						[Modifier Set - Automotive - Tibbe Non-Transponder],
						[Modifier Set - Automotive - VATS],
						[Modifier Set - Key Blanks Costs],
						[Modifier Set - Lock Finishes],
						[Modifier Set - Lock Functions],
						[Tax - Sales Tax (7%)]				
					)
					VALUES
						(
							Token,
							[Item Name],
							[Description],
							[Category],
							[SKU],
							[Variation Name],
							[Price],
							[Option Name 1],
							[Option Value 1],
							[Current Quantity Mobile Locksmith, Inc#],
							[New Quantity Mobile Locksmith, Inc#],
							[Stock Alert Enabled Mobile Locksmith, Inc#],
							[Stock Alert Count Mobile Locksmith, Inc#],
							[Modifier Set - Automotive - Hi-Security Non-Transponder],
							[Modifier Set - Automotive - Hi-Security Transponder],
							[Modifier Set - Automotive - Proximity],
							[Modifier Set - Automotive - Regular Metal],
							[Modifier Set - Automotive - Regular Transponder],
							[Modifier Set - Automotive - Remotes],
							[Modifier Set - Automotive - Tibbe Transponder],
							[Modifier Set - Automotive - Tibbe Non-Transponder],
							[Modifier Set - Automotive - VATS],
							[Modifier Set - Key Blanks Costs],
							[Modifier Set - Lock Finishes],
							[Modifier Set - Lock Functions],
							[Tax - Sales Tax (7%)]				
						)
					WHEN NOT MATCHED BY SOURCE
					AND t.Category = 'Automotive (Setup/Duplicate Keys)'
						THEN DELETE
					;
		/*************************END MERGE**********************************/

