USE [ans_sql]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- +--TEST--+
-- FNC_CONVERT_TIME_1
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	convert time
--*  
--*  作成日/create date			:	2021/04/07										
--*　作成者/creater				:	quangnd　								
--*   					
--****************************************************************************************
CREATE FUNCTION [FNC_TIME_tong](
	-- Add the parameters for the stored procedure here
	@P_time_a							INT		
,	@P_time_b							INT		
)	
RETURNS  INT 
AS
BEGIN
	DECLARE  
		@w_minute INT

	SET @w_minute = ( (@P_time_a /100)*60 + (@P_time_a % 100) + (@P_time_b /100)*60 + (@P_time_b % 100)  )	
	RETURN (@w_minute / 60 )*100 + @w_minute % 60  
END
--select dbo.FNC_TIME_tong(220,345)
GO
CREATE FUNCTION [FNC_TIME_hieu](
	-- Add the parameters for the stored procedure here
	@P_time_a							INT		
,	@P_time_b							INT		
)	
RETURNS  INT 
AS
BEGIN
	DECLARE  
		@w_minute INT

	SET @w_minute = ((@P_time_a /100)*60 + (@P_time_a % 100) - (@P_time_b /100)*60 - (@P_time_b % 100))	
	RETURN (@w_minute / 60 )*100 + @w_minute % 60  
END
--select dbo.FNC_TIME_hieu(300,130) as hehe
GO
--CONVERT MINUTE -> HH:MM
CREATE FUNCTION [FNC_MINUTE](

	@P_minute				INT		
)	
RETURNS  NVARCHAR(5)
AS
BEGIN
	DECLARE  
		@w_result	NVARCHAR(5)
	,	@w_minute	NVARCHAR(5)

		IF((@P_minute % 60 ) < 10) 
		BEGIN  
			SET @w_minute = CONCAT('0',@P_minute % 60)
		END
		ELSE
		BEGIN  
			SET @w_minute = @P_minute % 60
		END	
		SELECT  @w_result = CONCAT((@P_minute / 60 ),':',@w_minute );
	RETURN  @w_result 
END
--SELECT [dbo].[FNC_MINUTE](121)
GO
--CONVERT MINUTE -> HHMM
alter FUNCTION [FNC_MINUTE_1](
	@P_minute	INT		
)	
RETURNS  INT
AS
BEGIN
	DECLARE  
		@w_result	NVARCHAR(5)
	,	@w_minute NVARCHAR(5)

		IF((@P_minute % 60 ) < 10) 
		BEGIN  
			SET @w_minute = CONCAT('0',@P_minute % 60)
		END
		ELSE
		BEGIN  
			SET @w_minute = @P_minute % 60
		END	
		SELECT  @w_result = CONCAT((@P_minute / 60 ),@w_minute );
	RETURN  CAST(@w_result AS INT)
END
--SELECT [dbo].[FNC_MINUTE_1](125)
GO
-- CONVERT HHMM -> MINUTE
CREATE FUNCTION [FNC_TIME_MM](
	@P_time		INT		
)	
RETURNS  INT
AS
BEGIN	  
	RETURN  (@P_time /100)*60 + (@P_time % 100)
END
--SELECT [dbo].[FNC_TIME_MM](100)
GO
-- CONVERT HHMM -> HOURS
alter FUNCTION [FNC_TIME_HH](
	@P_time		INT	
,	@P_choose	INT = 0
)	
RETURNS  FLOAT
AS
BEGIN	  
		DECLARE  
		@w_minute	FLOAT
	,	@w_rs		FLOAT
	SET @w_minute = (@P_time/100) + (@P_time % 100)/60.0
	IF(@P_choose = 1)
	BEGIN
		SET @w_rs = cast(CEILING(@w_minute) as float)
	END
	ELSE IF(@P_choose = 2)
	BEGIN
		SET @w_rs = cast(FLOOR(@w_minute) as float)
	END
	ELSE
	BEGIN
		SET @w_rs =  cast(ROUND(@w_minute,2) as float)
	END
	RETURN @w_rs
END
--SELECT [dbo].[FNC_TIME_HH](43239,25)
GO
