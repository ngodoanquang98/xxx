USE [ans_sql]
GO
-- +--TEST--+
-- EXEC [SPC_BAI4_LST1] 
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
	SELECT
	    ISNULL(employee.id,0)								AS id 
	,   ISNULL(employee.name,'')     						AS name
	,   ISNULL(employee.yomigana,'') 						AS yomigana 
	,   ISNULL(employee.alphabet,'') 						AS alphabet
	,   ISNULL(convert(varchar, employee.birthday,3) ,'') 	AS birthday 
	,   ISNULL(l1.value,'')   								AS gender 
	,   ISNULL(l2.value,'')									AS blood_type
	,   ISNULL(section.name,'')  							AS section 
	,   ISNULL(job_level.name,'')							AS job_level
	,   ISNULL(office.name,'')								AS office 
	,   ISNULL(BOS.name,'')     							AS boss 
	,	ISNULL(l3.value,'')									AS retire
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
	LEFT JOIN library AS l1 ON (
		employee.gender = l1.id  
	AND l1.section = 'gender'
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
--bai5
-- +--TEST--+
-- EXEC [SPC_BAI5_LST1] 
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE VIEW v_employee
AS
	SELECT
	    ISNULL(employee.id,0)								AS id 
	,   ISNULL(employee.name,'')     						AS name
	,   ISNULL(employee.yomigana,'') 						AS yomigana 
	,   ISNULL(employee.alphabet,'') 						AS alphabet
	,   ISNULL(convert(varchar, employee.birthday,3) ,'') 	AS birthday 
	,   ISNULL(l1.value,'')   								AS gender 
	,   ISNULL(l2.value,'')									AS blood_type
	,   ISNULL(section.name,'')  							AS section 
	,   ISNULL(job_level.name,'')							AS job_level
	,   ISNULL(office.name,'')								AS office 
	,   ISNULL(BOS.name,'')     							AS boss 
	,	ISNULL(l3.value,'')									AS retire
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
	LEFT JOIN library AS l1 ON (
		employee.gender = l1.id  
	AND l1.section = 'gender'
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
	);
GO
--bai6
-- +--TEST--+
-- EXEC [SPC_BAI6_LST1] 
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
	SELECT *
	FROM v_employee
--bai7
-- +--TEST--+
-- EXEC [SPC_employee_INQ01] 
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_INQ01]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	SELECT
	    ISNULL(employee.id,0)			AS id 
	,   ISNULL(employee.name,'')     	AS name
	,   ISNULL(employee.yomigana,'') 	AS yomigana 
	,   ISNULL(employee.alphabet,'') 	AS alphabet
	,   ISNULL(employee.birthday ,'') 	AS birthday 
	,   ISNULL(l1.value,'')   			AS gender 
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
	LEFT JOIN library AS l1 ON (
		employee.gender = l1.id  
	AND l1.section = 'gender'
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
END
GO
--bai8
-- +--TEST--+
-- EXEC [SPC_BAI8_ACT01] 889, 'quang', 'ｲﾄｳ ﾏｻﾋﾄ', 'Masahito Itou', '1976-03-04',	1, 3, 3, 7, 2
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_BAI8_ACT01]
	-- Add the parameters for the stored procedure here
	@P_id         INT          
,	@P_name       VARCHAR (50) 
,	@P_yomigana   VARCHAR (50) 
,	@P_alphabet   VARCHAR (50) 
,	@P_birthday   DATE         
,	@P_gender     TINYINT      
,	@P_blood_type TINYINT      
,	@P_section    TINYINT      
,	@P_job_level  TINYINT      
,	@P_office     TINYINT       
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT 1 FROM employee WHERE id = @P_id)
	BEGIN
		INSERT INTO employee
		SELECT 
			@P_id 
		,	@P_name      
		,	@P_yomigana  
		,	@P_alphabet  
		,	@P_birthday  
		,	@P_gender    
		,	@P_blood_type
		,	@P_section   
		,	@P_job_level 
		,	@P_office   
		,	NULL
		,	0
	END
END
GO
--bai9
-- +--TEST--+
-- EXEC [SPC_BAI9_ACT01] 8888, 'quang', 'ｲﾄｳ ﾏｻﾋﾄ', 'Masahito Itou', '1976-03-04',	1, 3, 3, 7, 2, 1, 0
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_BAI9_ACT01]
	-- Add the parameters for the stored procedure here
	@P_id         INT          
,	@P_name       VARCHAR (50) 
,	@P_yomigana   VARCHAR (50) 
,	@P_alphabet   VARCHAR (50) 
,	@P_birthday   DATE         
,	@P_gender     TINYINT      
,	@P_blood_type TINYINT      
,	@P_section    TINYINT      
,	@P_job_level  TINYINT      
,	@P_office     TINYINT   
,	@P_boss       INT          
,	@P_retire     TINYINT      
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	UPDATE employee SET
		name		= @P_name      
	,	yomigana	= @P_yomigana  
	,	alphabet	= @P_alphabet  
	,	birthday	= @P_birthday  
	,	gender		= @P_gender    
	,	blood_type	= @P_blood_type
	,	section		= @P_section   
	,	job_level	= @P_job_level 
	,	office		= @P_office   
	,	boss		= @P_boss   
	,	retire		= @P_retire
	WHERE 
		id = @P_id
END	 
GO
--bai10
-- +--TEST--+
-- EXEC [SPC_employee_ACT03] 88888
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_ACT03]
	-- Add the parameters for the stored procedure here
	@P_id         INT       
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	DELETE d
	FROM employee  AS d
	WHERE 
		d.id = @P_id
END	 
GO
--bai11
-- +--TEST--+
-- EXEC [SPC_employee_ACT11] 1888, 'quang', 'ｲﾄｳ ﾏｻﾋﾄ', 'Masahito Itou', '1976-03-04',1, 3, 3, 1, 2
-- select * from employee
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_ACT11]
	-- Add the parameters for the stored procedure here
	@P_id         INT          
,	@P_name       VARCHAR (50) 
,	@P_yomigana   VARCHAR (50) 
,	@P_alphabet   VARCHAR (50) 
,	@P_birthday   DATE         
,	@P_gender     TINYINT      
,	@P_blood_type TINYINT      
,	@P_section    TINYINT      
,	@P_job_level  TINYINT      
,	@P_office     TINYINT       
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT 1 FROM employee WHERE id = @P_id)
	BEGIN
		IF EXISTS (SELECT 1 FROM job_level WHERE id = @P_job_level)
		BEGIN		
			IF EXISTS (SELECT 1 FROM library WHERE id = @P_gender AND section = 'gender')
			BEGIN
				IF EXISTS (SELECT 1 FROM section WHERE id = @P_section)
				BEGIN
					INSERT INTO employee
					SELECT 
						@P_id 
					,	@P_name      
					,	@P_yomigana  
					,	@P_alphabet  
					,	@P_birthday  
					,	@P_gender    
					,	@P_blood_type
					,	@P_section   
					,	@P_job_level 
					,	@P_office   
					,	NULL
					,	0
				END
			END
		END
	END
END
GO
--select *from employee
--bai12
-- +--TEST--+
-- EXEC [SPC_employee_ACT12] 888, 'quang', 'ｲﾄｳ ﾏｻﾋﾄ', 'xxxxx', '1976-03-04',11, 3, 3, 7, 2,1,0
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_ACT12]
	-- Add the parameters for the stored procedure here
	@P_id         INT          
,	@P_name       VARCHAR (50) 
,	@P_yomigana   VARCHAR (50) 
,	@P_alphabet   VARCHAR (50) 
,	@P_birthday   DATE         
,	@P_gender     TINYINT      
,	@P_blood_type TINYINT      
,	@P_section    TINYINT      
,	@P_job_level  TINYINT      
,	@P_office     TINYINT   
,	@P_boss       INT          
,	@P_retire     TINYINT        
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM job_level WHERE id = @P_job_level)
	BEGIN		
		IF EXISTS (SELECT 1 FROM library WHERE id = @P_gender AND section = 'gender')
		BEGIN
			IF EXISTS (SELECT 1 FROM library WHERE id = @P_section)
			BEGIN
				UPDATE employee SET
					name		= @P_name      
				,	yomigana	= @P_yomigana  
				,	alphabet	= @P_alphabet  
				,	birthday	= @P_birthday  
				,	gender		= @P_gender    
				,	blood_type	= @P_blood_type
				,	section		= @P_section   
				,	job_level	= @P_job_level 
				,	office		= @P_office   
				,	boss		= @P_boss   
				,	retire		= @P_retire
				WHERE 
					id = @P_id
			END
		END
	END
END
GO
--select *from employee
--bai13
-- +--TEST--+
-- EXEC [SPC_employee_ACT13] 888
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_ACT13]
	-- Add the parameters for the stored procedure here
	@P_id         INT                
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;	
	DELETE d
	FROM employee  AS d
	WHERE 
		d.id     = @P_id
	AND d.retire = 0
END
GO
--bai14
-- +--TEST--+
-- EXEC [SPC_employee_ACT21] 1888, 'quang', 'ｲﾄｳ ﾏｻﾋﾄ', 'Masahito Itou', '1976-03-04',11, 133, 31, 112, 2
-- select * from employee
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_ACT21]
	-- Add the parameters for the stored procedure here
	@P_id         INT          
,	@P_name       VARCHAR (50) 
,	@P_yomigana   VARCHAR (50) 
,	@P_alphabet   VARCHAR (50) 
,	@P_birthday   DATE         
,	@P_gender     TINYINT      
,	@P_blood_type TINYINT      
,	@P_section    TINYINT      
,	@P_job_level  TINYINT      
,	@P_office     TINYINT       
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	DECLARE
		@w_count	bigint	=	0
	DECLARE 
		@error_set table(
							id      int
						,   [message] varchar(256)
						)	
	IF NOT EXISTS (SELECT 1 FROM employee WHERE id = @P_id)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			1
		,	'ID DA TON TAI'
	END
	IF EXISTS (SELECT 1 FROM job_level WHERE id = @P_job_level)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			2
		,	'ID job_level khong thoa man'
	END
	IF EXISTS (SELECT 1 FROM library WHERE id = @P_gender AND section = 'gender')
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			3
		,	'gender sai'
	END
	IF EXISTS (SELECT 1 FROM section WHERE id = @P_section)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			1
		,	'ID section khong ton tai'
	END
	IF (@w_count = 0)
	BEGIN
		INSERT INTO employee
		SELECT 
			@P_id 
		,	@P_name      
		,	@P_yomigana  
		,	@P_alphabet  
		,	@P_birthday  
		,	@P_gender    
		,	@P_blood_type
		,	@P_section   
		,	@P_job_level 
		,	@P_office   
		,	NULL
		,	0
	END	
	SELECT *
	FROM @error_set
END
GO
--bai15
-- +--TEST--+
-- EXEC [SPC_employee_ACT22] 1878, 'quang', 'ｲﾄｳ ﾏｻﾋﾄ', 'Masahito Itou', '1976-03-04',10, 13, 31, 11, 2,1,0
-- select * from employee
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_ACT22]
	-- Add the parameters for the stored procedure here
	@P_id         INT          
,	@P_name       VARCHAR (50) 
,	@P_yomigana   VARCHAR (50) 
,	@P_alphabet   VARCHAR (50) 
,	@P_birthday   DATE         
,	@P_gender     TINYINT      
,	@P_blood_type TINYINT      
,	@P_section    TINYINT      
,	@P_job_level  TINYINT      
,	@P_office     TINYINT   
,	@P_boss       INT          
,	@P_retire     TINYINT        
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	DECLARE
		@w_count	bigint	=	0
	DECLARE 
		@error_set table(
							id      int
						,   message varchar(256)
						)	
	IF NOT EXISTS (SELECT 1 FROM employee WHERE id = @P_id)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			1
		,	'ID KHONG TON TAI'
	END
	IF EXISTS (SELECT 1 FROM job_level WHERE id = @P_job_level)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			2
		,	'ID job_level khong thoa man'
	END
	IF EXISTS (SELECT 1 FROM library WHERE id = @P_gender AND section = 'gender')
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			3
		,	'gender sai'
	END
	IF EXISTS (SELECT 1 FROM section WHERE id = @P_section)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			1
		,	'ID section khong ton tai'
	END
	IF (@w_count = 0)
	BEGIN
		UPDATE employee SET
			name		= @P_name      
		,	yomigana	= @P_yomigana  
		,	alphabet	= @P_alphabet  
		,	birthday	= @P_birthday  
		,	gender		= @P_gender    
		,	blood_type	= @P_blood_type
		,	section		= @P_section   
		,	job_level	= @P_job_level 
		,	office		= @P_office   
		,	boss		= @P_boss   
		,	retire		= @P_retire
		WHERE 
			id = @P_id
	END	 
	SELECT *
	FROM @error_set
END
GO
--bai6
-- +--TEST--+
-- EXEC [SPC_employee_ACT23] 889
-- select * from employee
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
CREATE PROCEDURE [dbo].[SPC_employee_ACT23]
	-- Add the parameters for the stored procedure here
	@P_id         INT                 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	DECLARE 
		@error_set table(
							id      int
						,   message varchar(256)
						)	
	IF NOT EXISTS (SELECT 1 FROM employee WHERE id = @P_id)
	BEGIN
		INSERT INTO @error_set
		SELECT
			1
		,	'ID KHONG TON TAI'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT 1 FROM employee WHERE retire != 0 AND  id = @P_id )
		BEGIN
			INSERT INTO @error_set
			SELECT
				2
			,	'retire khac 0'
		END
	END
	DELETE d
	FROM employee  AS d
	WHERE 
		d.id     = @P_id
	AND d.retire = 0
	SELECT *
	FROM @error_set
END
GO
--select *from employee
--bai17
-- +--TEST--+
-- EXEC [SPC_employee_SPC01] 'A', 888, 'quang', 'ｲﾄｳ ﾏｻﾋﾄ', 'xxxxx', '1976-03-04',11, 3, 3, 7, 2,1,0
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	LIST DATA
--*  
--*  作成日/create date			:	2022/03/29											
--*　作成者/creater				:	quangnd　								
--*   					
--*  更新日/update date			:			
--*　更新者/updater				:　					     	 
--*　更新内容/update content		:	
--****************************************************************************************
ALTER PROCEDURE [dbo].[SPC_employee_SPC01]
	-- Add the parameters for the stored procedure here
	@P_mode		  VARCHAR(1) 
,	@P_id         INT          
,	@P_name       VARCHAR (50)	=''
,	@P_yomigana   VARCHAR (50)	=''
,	@P_alphabet   VARCHAR (50)	=''
,	@P_birthday   DATE			=''
,	@P_gender     TINYINT		= 0
,	@P_blood_type TINYINT		= 0
,	@P_section    TINYINT		= 0
,	@P_job_level  TINYINT		= 0
,	@P_office     TINYINT		= 0
,	@P_boss       INT			= 0
,	@P_retire     TINYINT       = 0 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;	
	DECLARE
		@w_count	bigint	=	0
	DECLARE 
		@error_set table(
							id      int
						,   [message] varchar(256)
						)	
	IF NOT EXISTS (SELECT 1 FROM employee WHERE id = @P_id)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			1
		,	'ID DA TON TAI'
	END
	IF EXISTS (SELECT 1 FROM job_level WHERE id = @P_job_level)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			2
		,	'ID job_level khong thoa man'
	END
	IF EXISTS (SELECT 1 FROM library WHERE id = @P_gender AND section = 'gender')
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			3
		,	'gender sai'
	END
	IF EXISTS (SELECT 1 FROM section WHERE id = @P_section)
	BEGIN
		SET @w_count = @w_count + 1
		INSERT INTO @error_set
		SELECT
			1
		,	'ID section khong ton tai'
	END
	IF @P_mode ='A' AND @w_count = 0
	BEGIN
		EXEC SPC_employee_ACT11  
			@P_id 
		,	@P_name
		,	@P_yomigana
		,	@P_alphabet
		,	@P_birthday
		,	@P_gender
		,	@P_blood_type
		,	@P_section
		,	@P_job_level
		,	@P_office  
	END
	ELSE IF @P_mode ='U' AND @w_count = 1
	BEGIN
		EXEC SPC_employee_ACT12
			@P_id        
		,	@P_name      
		,	@P_yomigana  
		,	@P_alphabet  
		,	@P_birthday  
		,	@P_gender    
		,	@P_blood_type
		,	@P_section   
		,	@P_job_level 
		,	@P_office    
		,	@P_boss      
		,	@P_retire  
	END
	ELSE IF @P_mode ='D' 
	BEGIN
		EXEC SPC_employee_ACT13
			@P_id 
	END
	ELSE
	BEGIN
		PRINT N'BAN NHAP SAI';
	END
END
GO
