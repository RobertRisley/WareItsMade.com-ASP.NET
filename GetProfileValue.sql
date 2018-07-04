ALTER FUNCTION [dbo].[GetProfileValue] (
	@UserName nvarchar(50)
,	@PropertyName varchar(50)
)
RETURNS nvarchar(255)
AS
BEGIN
	--DECLARE	@UserName nvarchar(50),	@PropertyName varchar(50)
	--SELECT @UserName = 'rwr', @PropertyName = 'street2'

	IF @UserName IS NULL OR LEN(@UserName) = 0
	OR @PropertyName IS NULL OR LEN(@PropertyName) = 0
		RETURN NULL

	-- get the profile PropertyNames and PropertyValueStrings with @UserName
	DECLARE @PropertyNames nvarchar(4000), @PropertyValueStrings nvarchar(4000)
	SELECT @PropertyNames = PropertyNames, @PropertyValueStrings = PropertyValueStrings
	FROM Users u JOIN Profiles p ON u.UserId = p.UserId WHERE u.UserName = @UserName

	-- Find the starting position of the key.
	DECLARE @pos AS INTEGER
	SET @pos = CHARINDEX(@PropertyName + ':', @PropertyNames, 0)
	IF @pos = 0 RETURN NULL

	-- Find the starting position of the value.
	DECLARE @endPos As INTEGER
	DECLARE @valueStart AS INTEGER
	SET @pos = @pos + LEN(@PropertyName) + LEN(':')
	SET @endPos = CHARINDEX(':', @PropertyNames, @pos)
	SET @valueStart = CAST(SUBSTRING(@PropertyNames, @pos, @endPos - @pos) AS INT)

	-- Find the length of the value.
	DECLARE @valueLength AS INTEGER
	SET @pos = @endPos + LEN(':')
	SET @endPos = CHARINDEX(':', @PropertyNames, @pos)
	SET @valueLength = CAST(SUBSTRING(@PropertyNames, @pos, @endPos - @pos) AS INT)
	IF @valueLength = 0 RETURN NULL

	--SELECT SUBSTRING(@PropertyValueStrings, @valueStart + 1, @valueLength)
	RETURN SUBSTRING(@PropertyValueStrings, @valueStart + 1, @valueLength)
END
