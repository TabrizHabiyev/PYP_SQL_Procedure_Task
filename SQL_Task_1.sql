
CREATE DATABASE PYP_SQL_Procedure_Task

USE PYP_SQL_Procedure_Task

CREATE TABLE Country
(
Id INT IDENTITY(1,1) PRIMARY KEY,
CountryName VARCHAR(50) NOT NULL,
Code VARCHAR(50) NOT NULL
)

CREATE TABLE City
(
Id INT IDENTITY(1,1) PRIMARY KEY,
CityName VARCHAR(50) NOT NULL,
CountryId INT NOT NULL Foreign Key REFERENCES Country(Id),
Code VARCHAR(50) NOT NULL
)

CREATE TABLE District
(
Id INT IDENTITY(1,1) PRIMARY KEY,
DistrictName VARCHAR(50) NOT NULL,
CountryId INT NOT NULL Foreign Key REFERENCES Country(Id),
CityId INT NOT NULL Foreign Key REFERENCES City(Id),
Code VARCHAR(50) NOT NULL
)

CREATE TABLE Town
(
Id INT IDENTITY(1,1) PRIMARY KEY,
TownName VARCHAR(50) NOT NULL,
CountryId INT NOT NULL Foreign Key REFERENCES Country(Id),
CityId INT NOT NULL Foreign Key REFERENCES City(Id),
DistrictId INT NOT NULL Foreign Key REFERENCES District(Id),
Code VARCHAR(50) NOT NULL
)

CREATE PROCEDURE PYP_SQL_Procedure_Task
@CountryName VARCHAR(50),
@CityName VARCHAR(50),
@DistrictName VARCHAR(50),
@TownName VARCHAR(50)
AS
BEGIN
DECLARE @CountryId INT
DECLARE @CityId INT
DECLARE @DistrictId INT
DECLARE @TownId INT

SELECT @CountryId = Id FROM Country WHERE CountryName = @CountryName
SELECT @CityId = Id FROM City WHERE CityName = @CityName
SELECT @DistrictId = Id FROM District WHERE DistrictName = @DistrictName
SELECT @TownId = Id FROM Town WHERE TownName = @TownName

IF @CountryId IS NULL
BEGIN
INSERT INTO Country(CountryName,Code) VALUES(@CountryName,NEWID())
SELECT @CountryId = Id FROM Country WHERE CountryName = @CountryName
END
ELSE
BEGIN
PRINT 'Country Already Exists'
END

IF @CityId IS NULL
BEGIN
INSERT INTO City(CityName,CountryId,Code) VALUES(@CityName,@CountryId,NEWID())
SELECT @CityId = Id FROM City WHERE CityName = @CityName
END
ELSE
BEGIN
PRINT 'City Already Exists'
END

IF @DistrictId IS NULL
BEGIN


INSERT INTO District(DistrictName,CountryId,CityId,Code
) VALUES(@DistrictName,@CountryId,@CityId,NEWID())
SELECT @DistrictId = Id FROM District WHERE DistrictName = @DistrictName
END
ELSE
BEGIN
PRINT 'District Already Exists'
END

IF @TownId IS NULL
BEGIN
INSERT INTO Town(TownName,CountryId,CityId,DistrictId,Code) VALUES(@TownName,@CountryId,@CityId,@DistrictId,NEWID())
SELECT @TownId = Id FROM Town WHERE TownName = @TownName
END
ELSE
BEGIN
PRINT 'Town Already Exists'
END

END

GO

EXEC PYP_SQL_Procedure_Task 'Turkey','Istanbul','Kadikoy','Kadikoy Mahallesi'

EXEC PYP_SQL_Procedure_Task 'Tsurkey','Istanbsul','Kasdikoy','Kasdikoy Mahallesis'
