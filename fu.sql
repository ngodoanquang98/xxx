DROP FUNCTION [FNC_gender_name]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- +--TEST--+
-- SELECT dbo.FNC_gender_name(8)
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	hehe
--*  
--*  作成日/create date			:	2022/03/30										
--*　作成者/creater				:	quangnd　								
--*   					
--****************************************************************************************
CREATE FUNCTION [FNC_gender_name]
(
	@P_gender_id TINYINT 
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE
		@w_sex		VARCHAR(50)		= ''
	IF EXISTS (SELECT 1 FROM library WHERE section = 'gender' AND id = @P_gender_id)
	BEGIN
		SET @w_sex = (SELECT value FROM library WHERE section = 'gender' AND id = @P_gender_id)
	END
	ELSE
	BEGIN
		SET @w_sex = '不明'
	END
	RETURN @w_sex
END
GO
--BAI20
--SELECT dbo.FNC_years_old ('2021-01-30')
CREATE FUNCTION [FNC_years_old]
(
	@P_birthday DATE
)
RETURNS TINYINT
AS
BEGIN
	DECLARE
		@w_tuoi		TINYINT		= 0
	IF CONVERT(VARCHAR, GETDATE(), 23) <= @P_birthday
	BEGIN
		SET @w_tuoi = NULL
	END
	ELSE
	BEGIN
		SET @w_tuoi = YEAR(GETDATE()) - YEAR(@P_birthday)
		IF MONTH(GETDATE()) > MONTH(@P_birthday)
		BEGIN
			SET @w_tuoi = @w_tuoi +1
		END
		ELSE IF  MONTH(GETDATE()) = MONTH(@P_birthday) AND DAY(GETDATE()) > DAY(@P_birthday)
		BEGIN
			SET @w_tuoi = @w_tuoi +1
		END
		ELSE
		BEGIN
			SET @w_tuoi = @w_tuoi
		END
	END
	RETURN @w_tuoi
END
GO
--BAI21
--SELECT dbo.FNC_japanese_date ('')
CREATE FUNCTION [FNC_japanese_date]
(
	@P_date	 DATE
)
RETURNS VARCHAR(36)
AS
BEGIN
	DECLARE
		@w_day		VARCHAR(36)		
	SET @w_day = SUBSTRING(CONVERT(CHAR,FORMAT(@P_date,'yyyy年MM月dd日')),1,11)
	SET @w_day = CONCAT(@w_day,'(', (SELECT week_name FROM week_name WHERE week_id = DATEPART(WEEKDAY,@P_date)),')')
	RETURN @w_day
END
GO
-- CAU 22
--TEST
-- EXEC SPC_employee_FND02 0,0,'',''
CREATE PROCEDURE [dbo].[SPC_employee_FND02](
	@P_id_from  INT          										
,	@P_id_to    INT          										
,	@P_name     VARCHAR(50) 								
,	@P_yomigana VARCHAR(50) 																			
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;

	SELECT
	    ISNULL(employee.id,0)			AS id 
	,   ISNULL(employee.name,'')     	AS name
	,   ISNULL(employee.yomigana,'') 	AS yomigana 
	,   ISNULL(employee.alphabet,'') 	AS alphabet
	,   dbo.FNC_japanese_date(employee.birthday) 	AS birthday 
	,	dbo.FNC_years_old(employee.birthday)  		AS year_old
	,   dbo.FNC_gender_name(employee.gender)  		AS gender 
	,   ISNULL(l2.value,'')				AS blood_type
	,   ISNULL(section.name,'')  		AS section 
	,   ISNULL(job_level.name,'')		AS job_level
	,   ISNULL(office.name,'')			AS office 
	,   ISNULL(BOS.name,'')     		AS boss 
	,	ISNULL(l3.value,'')				AS retire
	FROM dbo.employee
	LEFT JOIN section ON (
		employee.section = section.id 
	)
	LEFT JOIN job_level ON (
		employee.job_level = job_level.id 
	)
	LEFT JOIN office ON (
		employee.office = office.id
	)
	LEFT JOIN library AS l2 ON (
		employee.blood_type = l2.id 
	AND l2.section = 'blood_type'
	)
	LEFT JOIN employee AS BOS ON (
		employee.boss = BOS.id
	)
	LEFT JOIN library AS l3 ON (
		employee.retire = l3.id 
	AND l3.section = 'retire'
	)
	WHERE (		
			ISNULL(@P_name,'') = ''
		OR	employee.name LIKE '%'+@P_name+'%'
		)
		AND
		(	ISNULL(@P_yomigana,'') = ''
		OR	employee.yomigana   LIKE '%'+@P_yomigana+'%'
		)
		AND 
		(	ISNULL(@P_id_from,0) = 0
		AND ISNULL(@P_id_to,0) = 0
		)
		OR	employee.id BETWEEN @P_id_from AND @P_id_to		
END
GO
select * from employee
-- CAU 23
--TEST
-- SELECT * FROM FNC_employee_FND03 (0,0,'','')
CREATE FUNCTION [dbo].[FNC_employee_FND03](
	@P_id_from  INT          										
,	@P_id_to    INT          										
,	@P_name     VARCHAR(50) 								
,	@P_yomigana VARCHAR(50) 																			
)
RETURNS TABLE
AS
RETURN
(
	SELECT
	    ISNULL(employee.id,0)						AS id 
	,   ISNULL(employee.name,'')     				AS name
	,   ISNULL(employee.yomigana,'') 				AS yomigana 
	,   ISNULL(employee.alphabet,'') 				AS alphabet
	,   dbo.FNC_japanese_date(employee.birthday) 	AS birthday 
	,	dbo.FNC_years_old(employee.birthday)  		AS year_old
	,   dbo.FNC_gender_name(employee.gender)  		AS gender 
	,   ISNULL(l2.value,'')							AS blood_type
	,   ISNULL(section.name,'')  					AS section 
	,   ISNULL(job_level.name,'')					AS job_level
	,   ISNULL(office.name,'')						AS office 
	,   ISNULL(BOS.name,'')     					AS boss 
	,	ISNULL(l3.value,'')							AS retire
	FROM dbo.employee
	LEFT JOIN section ON (
		employee.section = section.id 
	)
	LEFT JOIN job_level ON (
		employee.job_level = job_level.id 
	)
	LEFT JOIN office ON (
		employee.office = office.id
	)
	LEFT JOIN library AS l2 ON (
		employee.blood_type = l2.id 
	AND l2.section = 'blood_type'
	)
	LEFT JOIN employee AS BOS ON (
		employee.boss = BOS.id
	)
	LEFT JOIN library AS l3 ON (
		employee.retire = l3.id 
	AND l3.section = 'retire'
	)
	WHERE (		
			ISNULL(@P_name,'') = ''
		OR	employee.name LIKE '%'+@P_name+'%'
		)
		AND
		(	ISNULL(@P_yomigana,'') = ''
		OR	employee.yomigana   LIKE '%'+@P_yomigana+'%'
		)
		AND 
		(	ISNULL(@P_id_from,0) = 0
		AND ISNULL(@P_id_to,0) = 0
		)
		OR	employee.id BETWEEN @P_id_from AND @P_id_to		
)
GO
--BAI24
-- exec SPC_employee_FND04 0,0,'',''
CREATE PROCEDURE [dbo].[SPC_employee_FND04]
(
	@P_id_from  INT          										
,	@P_id_to    INT          										
,	@P_name     VARCHAR(50) 								
,	@P_yomigana VARCHAR(50) 																			
)
AS
BEGIN
	SELECT
		ISNULL(id,0)			AS id 
	,   ISNULL(name,'')     	AS name
	,   ISNULL(yomigana,'') 	AS yomigana 
	,   ISNULL(alphabet,'') 	AS alphabet
	,   birthday				AS birthday 
	,	year_old  				AS year_old
	,   gender 					AS gender 
	,   ISNULL(blood_type,'')	AS blood_type
	,   ISNULL(section,'')  	AS section 
	,   ISNULL(job_level,'')	AS job_level
	,   ISNULL(office,'')		AS office 
	,   ISNULL(boss,'')     	AS boss 
	,	ISNULL(retire,'')		AS retire
	FROM FNC_employee_FND03 (@P_id_from,@P_id_to, @P_name, @P_yomigana)
END
GO
select gender, section from employee where section  =3
select * from section
--BAI 25
-- EXEC SPC_employee_CNT01 1 ,1,3
CREATE PROCEDURE [dbo].[SPC_employee_CNT01]
(
	@P_section TINYINT --部署																		
,	@P_male    INT     --男性人数 (参照渡し)																		
,	@P_female  INT     --女性人数 (参照渡し)	
)
AS
BEGIN	
	DECLARE 
		@HEHE TABLE(
			NAM	INT
		,   NU	INT
		)
	SET @P_male		= (SELECT COUNT(gender) FROM employee WHERE section  = @P_section AND gender = 1)
	SET @P_female	= (SELECT COUNT(gender) FROM employee WHERE section  = @P_section AND gender = 2)
	--
	INSERT INTO @HEHE
	SELECT
		@P_male
	,	@P_female
	--
	SELECT * FROM @HEHE
END
GO
-- BAI 26+27
CREATE TABLE [dbo].[employee_copy](
    id              INT                                   NOT NULL --ŽÐˆõ”Ô†(*)
,   name            VARCHAR (50)                          NOT NULL --Žw–¼
,   yomigana        VARCHAR (50) COLLATE Japanese_CI_AS   NULL     --ÖÐ¶ÞÅ
,   alphabet        VARCHAR (50) COLLATE Japanese_CI_AS   NULL     --‰pŽš•\‹L
,   birthday        DATE                                  NULL     --’a¶“ú
,   gender          TINYINT                               NULL     --«•Ê (1:’j« /2:—«)
,   blood_type      TINYINT                               NULL     --ŒŒ‰tŒ^ (1:A / 2:B / 3:AB / 4:O)
,   section         TINYINT                               NULL     --•”
,   job_level       TINYINT                               NULL     --–ðE
,   office          TINYINT                               NULL     --‰c‹ÆŠ
,   boss            INT                                   NULL     --ãŽi‚ÌŽÐˆõ”Ô†
,   retire          TINYINT                               NULL     --‘ÞE (0:ÝE / 1:‘ÞE)
,   input_user      INT                                   NULL     --ƒŒƒR[ƒh‚Ì“o˜^ƒ†[ƒU[
,   input_terminal  VARCHAR   (20) COLLATE Japanese_CI_AS NULL     --ƒŒƒR[ƒh‚Ì“o˜^’[––
,   input_time      DATETIME2                             NULL     --ƒŒƒR[ƒh‚Ì“o˜^“úŽž
,   update_user     INT                                   NULL     --ƒŒƒR[ƒh‚ÌXVƒ†[ƒU[
,   update_terminal VARCHAR   (20) COLLATE Japanese_CI_AS NULL     --ƒŒƒR[ƒh‚ÌXV’[––
,   update_time     DATETIME2                             NULL     --ƒŒƒR[ƒh‚ÌXV“úŽž
,   PRIMARY KEY (
        id
    )
)
DROP TABLE employee_copy;	
DROP TABLE #HIHI
CREATE TABLE #HIHI
(
    id			INT  IDENTITY(1,1)
,	id_fake		INT
,	birthday	DATE
 
)
INSERT INTO #HIHI
SELECT
	id
,	birthday
FROM employee
ORDER BY birthday desc
select * from #HIHI

INSERT INTO employee_copy
SELECT
	    hi.id           
	,   name           
	,   yomigana       
	,   alphabet       
	,   hi.birthday       
	,   gender         
	,   blood_type     
	,   section        
	,   job_level      
	,   office         
	,   boss           
	,   retire         
	,   input_user     
	,   input_terminal 
	,   input_time     
	,   update_user    
	,   update_terminal
	,   update_time    
FROM #HIHI AS hi
LEFT JOIN employee AS em ON (
	hi.id_fake = em.id
)	
select * from employee_copy
--bai 28
CREATE TABLE [dbo].[employee_copy](
    id              INT                                   NOT NULL --ŽÐˆõ”Ô†(*)
,   name            VARCHAR (50)                          NOT NULL --Žw–¼
,   yomigana        VARCHAR (50) COLLATE Japanese_CI_AS   NULL     --ÖÐ¶ÞÅ
,   alphabet        VARCHAR (50) COLLATE Japanese_CI_AS   NULL     --‰pŽš•\‹L
,   birthday        DATE                                  NULL     --’a¶“ú
,   gender          TINYINT                               NULL     --«•Ê (1:’j« /2:—«)
,   blood_type      TINYINT                               NULL     --ŒŒ‰tŒ^ (1:A / 2:B / 3:AB / 4:O)
,   section         TINYINT                               NULL     --•”
,   job_level       TINYINT                               NULL     --–ðE
,   office          TINYINT                               NULL     --‰c‹ÆŠ
,   boss            INT                                   NULL     --ãŽi‚ÌŽÐˆõ”Ô†
,   retire          TINYINT                               NULL     --‘ÞE (0:ÝE / 1:‘ÞE)
,   input_user      INT                                   NULL     --ƒŒƒR[ƒh‚Ì“o˜^ƒ†[ƒU[
,   input_terminal  VARCHAR   (20) COLLATE Japanese_CI_AS NULL     --ƒŒƒR[ƒh‚Ì“o˜^’[––
,   input_time      DATETIME2                             NULL     --ƒŒƒR[ƒh‚Ì“o˜^“úŽž
,   update_user     INT                                   NULL     --ƒŒƒR[ƒh‚ÌXVƒ†[ƒU[
,   update_terminal VARCHAR   (20) COLLATE Japanese_CI_AS NULL     --ƒŒƒR[ƒh‚ÌXV’[––
,   update_time     DATETIME2                             NULL     --ƒŒƒR[ƒh‚ÌXV“úŽž
,   PRIMARY KEY (
        id
    )
)
--DROP TABLE employee_copy;	
DECLARE @table TABLE (
    id			INT  IDENTITY(1,1)
,	id_fake		INT
,	birthday	INT
 
)
INSERT INTO @table
SELECT
	id
,	DAY(birthday)
FROM employee
ORDER BY DAY(birthday) desc
select * from @table

INSERT INTO employee_copy
SELECT
	    hi.id           
	,   name           
	,   yomigana       
	,   alphabet       
	,   em.birthday       
	,   gender         
	,   blood_type     
	,   section        
	,   job_level      
	,   office         
	,   boss           
	,   retire         
	,   input_user     
	,   input_terminal 
	,   input_time     
	,   update_user    
	,   update_terminal
	,   update_time    
FROM @table AS hi
LEFT JOIN employee AS em ON (
	hi.id_fake = em.id
)	
-- bai 29
-- exec SPC_employee_FND031 0,500,'',''
CREATE PROCEDURE [dbo].[SPC_employee_FND031]
(
	@P_id_from  INT          										
,	@P_id_to    INT          										
,	@P_name     VARCHAR(50) 								
,	@P_yomigana VARCHAR(50) 																			
)
AS
BEGIN
	DECLARE @table TABLE (
		id_fake		INT
	,	yomigana 	varchar (50) COLLATE Japanese_CI_AS
	,   birthday	VARCHAR(36)
	,	year_old	INT
	,   gender 		VARCHAR(10)
	)
	DECLARE @table2 TABLE (
	    id			INT  IDENTITY(1,1)
	,	id_fake		INT
	,	yomigana 	VARCHAR (50) COLLATE Japanese_CI_AS
	,   birthday	VARCHAR(36)
	,	year_old	INT
	,   gender 		VARCHAR(10)
	)
	DECLARE 
		@w_i int =1
	INSERT INTO @table
	SELECT
		id
	,	yomigana
	,   birthday
	,	year_old
	,   gender 	
	FROM FNC_employee_FND03 (@P_id_from,@P_id_to, @P_name, @P_yomigana) AS a
	INSERT INTO @table2
	SELECT
		id_fake
	,	yomigana
	,   birthday
	,	year_old
	,   gender 	
	FROM @table
	ORDER BY yomigana 
	WHILE @w_i <= (select COUNT(1) from @table2)
	BEGIN
		SELECT
			ISNULL(employee.id,0)			AS id 
		,   ISNULL(name,'')     	AS name
		,   ISNULL(t.yomigana,'') 	AS yomigana 
		,   ISNULL(alphabet,'') 	AS alphabet
		,   t.birthday		AS birthday 
		,	t.year_old  		AS year_old
		,   t.gender 			AS gender 
		,   ISNULL(blood_type,'')	AS blood_type
		,   ISNULL(section,'')  	AS section 
		,   ISNULL(job_level,'')	AS job_level
		,   ISNULL(office,'')		AS office 
		,   ISNULL(boss,'')     	AS boss 
		,	ISNULL(retire,'')				AS retire
		FROM employee
		INNER JOIN @table2  AS t ON (
			employee.id = t.id_fake
		)
		WHERE
			t.id = @w_i
		SET @w_i = @w_i+1
	END;
	-- SELECT * FROM FNC_employee_FND03 (0,0,'','')
END
GO
DECLARE @i int =1
WHILE @i <= (select COUNT(*) from employee)
BEGIN
select top 1 *
from (select top(@i) * from employee order by id  ) as s
order by s.id desc
set @i = @i+1
END;
select top(5) * from employee order by id 

--BAI 30
CREATE FUNCTION [dbo].[FNC_employee_cnt02](	 																											
)
RETURNS TABLE
AS
RETURN
(
	SELECT
		job_level.id											AS 役職ID
	,	job_level.name											AS 役職 
	,	SUM(CASE WHEN employee.gender = 1 THEN 1 ELSE 0 END)	AS 男性
	,	SUM(CASE WHEN employee.gender = 2 THEN 1 ELSE 0 END)	AS 女性
	,	ISNULL(SUM(employee.gender),0)							AS 合計 
	FROM job_level
	LEFT JOIN employee ON (
		job_level.id = employee.job_level
	)
	GROUP BY job_level.id,job_level.name	
)
GO
-- CAU 31
ALTER PROCEDURE [dbo].[SPC_employee_CNT03]
(
	@P_year		INT          										
,	@P_month	INT          										
,	@P_id		INT																											
)
AS
BEGIN
	DECLARE 
		@w_start date 			
	,	@w_end	 date 
	SET @w_start = CONVERT(VARCHAR,@P_year)+'-'+CONVERT(VARCHAR,@P_month)+'-01'
	SET @w_end	 = DATEADD(day, -1, DATEADD(month, 1, @w_start))
	SELECT 	
		application AS 経費申請日	
	,	(SELECT 
			SUM(cost) 
		FROM expense as he 
		WHERE 
			he.application <= expense.application
		AND he.application >= @w_start
		)				AS 経費小計	
	,	(CASE
			WHEN 
				(SELECT 
					SUM(cost) 
				FROM expense as he 
				WHERE 
					he.application <= expense.application
				AND he.application >= @w_start
				) <= job_level.expense
			THEN 'O'
			ELSE 'X'
		END) AS 支払い	
	FROM expense
	LEFT JOIN employee ON (
		expense.employee_id = employee.id
	)
	INNER JOIN job_level ON (
		employee.job_level = job_level.id
	)
	WHERE
		employee.id          = @P_id
	AND expense.application >= @w_start
	AND expense.application <= @w_end
END		   	
GO
select * from employee
select * from job_level
select * from expense
order by application

--EXEC SPC_employee_CNT03 2012,4,232

SELECT DATEADD(day, -1, '2017/08/01') AS DateAdd;
-- bài 32
CREATE FUNCTION [dbo].[SPC_employee_CNT04]
(
	@P_year		INT         										
,	@P_month	INT       										
,	@P_week		INT																											
)
RETURNS @table TABLE
(
	calender      DATE        
,	week_name     VARCHAR(20) 	
,	holiday_name  VARCHAR(20) 		
,	present_month BIT         			
)
AS
BEGIN
	DECLARE 
		@w_start date 			
	,	@w_end	 date 
	,	@i		int = 0
	,	@j		int = 0
	SET @w_start = CONVERT(VARCHAR,@P_year)+'-'+CONVERT(VARCHAR,@P_month)+'-01'
	SET @w_end	 = DATEADD(day, -1, DATEADD(month, 1, @w_start))
	SET @w_start = DATEADD(day, -7,@w_start)
	SET @w_end	 = DATEADD(day,  7,@w_end)
	WHILE @i <= 7
	BEGIN
		if (DATEADD(day, @i ,@w_start) = @P_week)
		begin
			SET @w_start = DATEADD(day, @i,@w_start)
			break
		end
		set @i = @i+1
	END
	WHILE @j <= 7
	BEGIN
		if (DATEADD(day, -@j ,@w_end) = @P_week)
		begin
			SET @w_end = DATEADD(day, -@j,@w_end)
			break
		end
		set @j = @j+1
	END
	WHILE @w_start < @w_end
	BEGIN
		insert into @table
		select
			calender = @w_start
		set @w_start = DATEADD(day, 1, @w_start)
	END
	INSERT INTO @table 
	SELECT
		tb.calender
	,	(SELECT 
			week_name 
		FROM week_name 
		WHERE 
			week_id = DATEPART(WEEKDAY,tb.calender)
		) AS week_name
	,	holiday.name
	FROM holiday
	right join @table as tb ON (
		holiday.holiday = tb.calender
	)
END



select * from holiday
select * from week_name
SELECT YEAR(GETDATE()) 
	 (SELECT week_id, week_name FROM week_name WHERE week_id = DATEPART(WEEKDAY,'2012-04-25'))
	 select DATEPART(WEEKDAY,'2012-04-25')
	 select DATEADD(day, 0,'2022-04-25')
--BAI 32
alter FUNCTION [dbo].[SPC_employee_CNT04]
(
	@P_year		INT         										
,	@P_month	INT       										
,	@P_week		INT																											
)
RETURNS @table TABLE
(
	calender      DATE        
,	week_name     VARCHAR(20) 	
,	holiday_name  VARCHAR(20) 		
,	present_month BIT         			
)
AS
BEGIN
	DECLARE 
		@w_start date 			
	,	@w_end	 date 
	,	@i		int = 0
	,	@j		int = 0
	SET @w_start = CONVERT(VARCHAR,@P_year)+'-'+CONVERT(VARCHAR,@P_month)+'-01'
	SET @w_end	 = DATEADD(day, -1, DATEADD(month, 1, @w_start))
	SET @w_start = DATEADD(day, -7,@w_start)
	SET @w_end	 = DATEADD(day,  7,@w_end)
	WHILE @i <= 7
	BEGIN
		if (CONVERT(int,DATEPART(WEEKDAY,DATEADD(day, @i ,@w_start))) = @P_week)
		begin
			SET @w_start = DATEADD(day, @i,@w_start)
			break
		end
		set @i = @i+1
	END
	WHILE @j <= 7
	BEGIN
		if (CONVERT(int,DATEPART(WEEKDAY,DATEADD(day, -@j ,@w_end))) = @P_week)
		begin
			SET @w_end = DATEADD(day, -@j,@w_end)
			break
		end
		set @j = @j+1
	END
	WHILE @w_start < @w_end
	BEGIN
		insert into @table (calender)
		select
			@w_start
		set @w_start = DATEADD(day, 1, @w_start)
	END
	UPDATE @table 
	SET
		week_name = (SELECT 
			week_name 
		FROM week_name 
		WHERE 
			week_id = DATEPART(WEEKDAY,calender)
		) 
	,	holiday_name = ISNULL(ho.name,'')
	,	present_month = Case	
							WHEN MONTH(calender) = @P_month THEN 1
							Else 0
						END
	FROM @table AS tb
	left join holiday as ho ON (
		tb.calender = ho.holiday
	)
	return
END



select * from SPC_employee_CNT04 (2012,5,4)
