SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- +--TEST--+
-- exce SPC_TASK_ACT1 
--****************************************************************************************
--*   											
--*  処理概要/process overview	:	SAVE DATA
--*  
--*  作成日/create date			:	2018/09/14											
--*　作成者/creater				:	viettd　								
--*   					
--*  更新日/update date			:  	2022/04/08					
--*　更新者/updater				:　 quangnd　								     	 
--*　更新内容/update content		:	　	
--****************************************************************************************
CREATE PROCEDURE [SPC_TASK_ACT1]
	-- Add the parameters for the stored procedure here
	@P_employee_cd	nvarchar(10)
,	@P_employee_nm	nvarchar(50)
,	@P_sex			tinyint
,	@P_birthday		date
,	@P_position_cd	int
AS
BEGIN
	SET NOCOUNT ON;
	-- START TRANSACTION 
	BEGIN TRANSACTION
	BEGIN TRY
		-- Chỗ này dùng để viết code xử lý dữ liệu sau khi validate xong
			-- UPDATE 
			IF EXISTS (SELECT 1 FROM M001 WHERE employee_cd = @P_employee_cd)											
			BEGIN
				UPDATE M001 SET 
					employee_nm			=	@P_employee_cd
				,	sex					=	@P_sex
				,	birthday			=	@P_birthday
				,	position_cd			=	@P_position_cd
				WHERE
					employee_cd			=	@P_employee_cd
			END
			ELSE
			BEGIN
				INSERT INTO M001
				SELECT 					
					@P_employee_cd
				,	@P_employee_nm
				,	@P_sex			
				,	@P_birthday		
				,	@P_position_cd
			END
		-- END PROCESS
	END TRY
	BEGIN CATCH
	IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION
		END
	END CATCH
	IF(@@TRANCOUNT > 0)
	BEGIN
		COMMIT TRANSACTION
	END
	select * from M001
END
--b
go
create PROCEDURE [SPC_TASK_ACT2]
	-- Add the parameters for the stored procedure here
	@P_position_cd			int
,	@P_position_nm			nvarchar(50)
,	@P_salaray_unit			money
AS
BEGIN
	SET NOCOUNT ON;
	-- START TRANSACTION 
	BEGIN TRANSACTION
	BEGIN TRY
		-- Chỗ này dùng để viết code xử lý dữ liệu sau khi validate xong
			-- UPDATE 
			IF EXISTS (SELECT 1 FROM M002 WHERE position_cd = @P_position_cd)											
			BEGIN
				UPDATE M002 SET 
					position_nm		=	@P_position_nm
				,	salaray_unit	=	@P_salaray_unit
				WHERE
					position_cd		=	@P_position_cd
			END
			ELSE
			BEGIN
				INSERT INTO M001
				SELECT 					
					@P_position_cd	
				,	@P_position_nm	
				,	@P_salaray_unit				
			END
		-- END PROCESS
	END TRY
	BEGIN CATCH
	IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION
		END
	END CATCH
	IF(@@TRANCOUNT > 0)
	BEGIN
		COMMIT TRANSACTION
	END
	select * from M002
END
CREATE PROCEDURE [SPC_TASK_ACT3]
	-- Add the parameters for the stored procedure here
	@P_employee_cd	nvarchar(10)
,	@P_employee_nm	nvarchar(50)
,	@P_sex			tinyint
,	@P_birthday		date
,	@P_position_cd	int
AS
BEGIN
	SET NOCOUNT ON;
	-- START TRANSACTION 
	BEGIN TRANSACTION
	BEGIN TRY
		-- Chỗ này dùng để viết code xử lý dữ liệu sau khi validate xong
			-- UPDATE 
			IF EXISTS (SELECT 1 FROM M001 WHERE employee_cd = @P_employee_cd)											
			BEGIN
				UPDATE M001 SET 
					employee_nm			=	@P_employee_cd
				,	sex					=	@P_sex
				,	birthday			=	@P_birthday
				,	position_cd			=	@P_position_cd
				WHERE
					employee_cd			=	@P_employee_cd
			END
			ELSE
			BEGIN
				INSERT INTO M001
				SELECT 					
					@P_employee_cd
				,	@P_employee_nm
				,	@P_sex			
				,	@P_birthday		
				,	@P_position_cd
			END
		-- END PROCESS
	END TRY
	BEGIN CATCH
	IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION
		END
	END CATCH
	IF(@@TRANCOUNT > 0)
	BEGIN
		COMMIT TRANSACTION
	END
	select * from M001
END
-- bai 2
go
CREATE PROCEDURE [dbo].[SPC_TASK_FND1]
	-- Add the parameters for the stored procedure here
	@P_key	nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	-- START TRANSACTION 
	SET @P_key = ISNULL(@P_key,'')
	SELECT
		employee_cd
	,	employee_nm
	,	sex			
	,	birthday		
	,	position_cd
	FROM M001
	WHERE
		employee_cd LIKE '%'+ @P_key +'%'
	OR	employee_nm LIKE '%'+ @P_key +'%'
END
exec SPC_TASK_FND1 'v'
GO
-- bai 4
alter PROCEDURE [SPC_TASK_RPT1]
	-- Add the parameters for the stored procedure here
	@P_year	int		
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE
		@w_string				NVARCHAR(1000)	= ''
	,	@sql_string				NVARCHAR(MAX)	= ''
	,	@w_text					NVARCHAR(1000)	= ''
	-- tao bang tinh ngay lam theo thang
	CREATE TABLE #hehe(
		year			int
	,	month			int
	,	employee_nm		nvarchar(50)
	,	money			money
	)
	INSERT INTO #hehe
	SELECT
		mon.y
	,	mon.m
	,	M001.employee_nm
	,	SUM(f001.work_status)* M002.salaray_unit
	from f001
	INNER JOIN (SELECT 
					employee_cd
				,	year_month_day
				,	DATEPART(mm,year_month_day) as m
				,	DATEPART(yy,year_month_day) as y
				FROM f001) AS mon ON (
		F001.employee_cd	=	mon.employee_cd
	AND f001.year_month_day =	mon.year_month_day
	)
	INNER JOIN M001 ON (
		F001.employee_cd = M001.employee_cd
	)
	LEFT JOIN M002 ON (
		M001.position_cd = M002.position_cd
	)
	WHERE
		DATEPART(yy,F001.year_month_day) = @P_year
	GROUP BY 
		mon.m
	,	M001.employee_nm
	,	mon.y
	,	M002.salaray_unit
	ORDER BY 
		mon.y
	,	mon.m
	--het
	SET @w_string = STUFF((SELECT DISTINCT', [' +RIGHT('00'+ CAST(cast([month]as int) AS VARCHAR(2)),2) + ']'
								FROM #hehe AS month
								FOR XML PATH('')),1,1,'')
	SET @w_text = STUFF((SELECT DISTINCT', [' +RIGHT('00'+ CAST(cast([month]as int) AS VARCHAR(2)),2) + + ']'+' AS '
								+ '['+cast(@P_year as varchar(4))+'-'+  RIGHT('00'+ CAST(cast([month]as int) AS VARCHAR(2)),2) + ']'
								FROM #hehe AS month
								FOR XML PATH('')),1,1,'')
	SET @sql_string = '
	SELECT
		ROW_NUMBER() OVER (ORDER BY employee_nm) AS [No]	 
	,	employee_nm	AS Name
	,	 '+@w_text+'
	FROM 
	(
		SELECT 
				year		
			,	month		
			,	employee_nm	
			,	money		
		FROM #hehe
	)
	AS A
	PIVOT (sum(money) FOR month IN (' + @w_string + ')) AS P
	'
	EXEC(@sql_string)	
END
GO
select * from m002
select * from m001
select * from f001

exec SPC_TASK_RPT1 2021
