CREATE FUNCTION DateOfBirthValidation
(
    @Age int,
    @DateOfBirth datetime
)
RETURNS varchar(50)
AS
BEGIN
    DECLARE @CurrentDate datetime
    DECLARE @BirthDate datetime
    DECLARE @Message varchar(50)
    SET @CurrentDate = GETDATE()
    SET @BirthDate = DATEADD(YEAR, @Age, @DateOfBirth)
    IF @BirthDate > @CurrentDate
    BEGIN
        SET @Message = 'Your birthday didn"t come'
    END
    ELSE IF @BirthDate < @CurrentDate
    BEGIN
        SET @Message = 'Your birthday is late'
    END
    ELSE IF @BirthDate = @CurrentDate
    BEGIN
        SET @Message = 'Happy birthday'
    END
    ELSE
    BEGIN
        SET @Message = 'Date of birth error'
    END
    RETURN @Message
END