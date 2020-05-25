	CREATE PROCEDURE products.[uspMergeAutoProduct]
		@make VARCHAR(100) = null,
		@model VARCHAR(100) = null,
		@ilcoEntryName VARCHAR(100) = null,
		@ilcoDetails VARCHAR(500) = null,
		@priceUSD decimal(18,6)  = null

	AS
	BEGIN
	
		IF(@make is null)
		BEGIN
			RAISERROR('Param: Make cannot be null', 16, 1)
		END	

		IF(@model is null)
		BEGIN
			RAISERROR('Param: Model cannot be null', 16, 1)
		END	

		IF(@ilcoEntryName is null)
		BEGIN
			RAISERROR('Param: IlcoEntryName cannot be null', 16, 1)
		END	

		IF(@make is null)
		BEGIN
			RAISERROR('Param: IlcoDetails cannot be null', 16, 1)
		END	

		/************* BEGIN MERGE *********************/

			MERGE INTO products.AutoProduct AS t  
			USING 
			(
				SELECT 
					Make = @make,
					Model = @model,
					IlcoEntryName = @ilcoEntryName,
					IlcoDetails = @ilcoDetails,
					PriceUSD = @priceUSD
			)  AS s  
			ON t.Make = s.Make
			AND t.Model = s.Model
			AND t.IlcoEntryName = s.IlcoEntryName
		
			WHEN MATCHED 
			AND (
				ISNULL(t.IlcoDetails,'') <> ISNULL(s.IlcoDetails,'')
				OR ISNULL(t.PriceUSD,0) <> ISNULL(s.PriceUSD, 0)
				)
				THEN UPDATE 
					SET 
						t.IlcoDetails = s.IlcoDetails,
						t.PriceUSD = s.PriceUSD
			
			WHEN NOT MATCHED BY TARGET THEN  
				INSERT 
				(
					Make,
					Model,
					IlcoEntryName,
					IlcoDetails,
					PriceUSD
				) 
				VALUES
				(
					Make,
					Model,
					IlcoEntryName,
					IlcoDetails,
					PriceUSD
				)
			;

		/************* END MERGE *********************/

	END