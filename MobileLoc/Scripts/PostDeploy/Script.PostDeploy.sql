/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--Ilco Entry grain
:r .\SeedIlcoEntry.sql
:r .\ClassifyIlcoEntryKeyBlank.sql

--Year Make Model (Key Blank) grain
:r .\SeedIlcoEntryYearMakeModelKeyBlank.sql
:r .\ClassifyReflashByYearMakeModel.sql
:r .\SeedYearMakeModel.sql

--Square Items
:r .\StageSquareItemAutoCategory.sql
