/* 
*******************************************************************************
* QUANG_HIHI
* 
* 処理概要(process overview) : bai tap
* 作成日/create date : 2022/03/20
* 作成者/creater : quangnd – quangnd@ans-asia.com
* 
* 更新日/update date : 
* 更新者/updater : 
* 更新内容/update content : 
* 
* @package : MODULE NAME
* @copyright : Copyright (c) ANS-ASIA
* @version : 1.0.0
*******************************************************************************
*/
DROP DATABASE IF EXISTS QUANG_HIHI;
CREATE DATABASE QUANG_HIHI;
USE QUANG_HIHI;
--create A_M0010
DROP TABLE IF EXISTS A_M0010; 
CREATE TABLE A_M0010(
		id smallint IDENTITY(1,1) PRIMARY KEY
,		[begin] int
,		price int
,		cre_user nvarchar(20)
,		cre_date datetime
,		upd_user nvarchar(20)
,		upd_date datetime
);
--create A_C0010
DROP TABLE IF EXISTS A_C0010; 
CREATE TABLE A_C0010(
		id int IDENTITY(1,1) PRIMARY KEY
,		[name] nvarchar(30)
,		sex  tinyint
,		card_id	varchar(15)
,		age int
,		address_1	nvarchar(50)
,		address_2	nvarchar(50)
,		tel	varchar(15)
,		email nvarchar(30)
,		cre_user nvarchar(20)
,		cre_date datetime
,		upd_user nvarchar(20)
,		upd_date datetime
);
--create A_L0010
DROP TABLE IF EXISTS A_L0010; 
CREATE TABLE A_L0010(
		id bigint IDENTITY(1,1) PRIMARY KEY
,		customer_id	int
,		year_month	int
,		kwh int
,		[status]  tinyint
,		pay_method tinyint
,		pay_date datetime
,		cre_user nvarchar(20)
,		cre_date datetime
,		upd_user nvarchar(20)
,		upd_date datetime
,		CONSTRAINT FK_A_C0010_A_L0010 FOREIGN KEY (customer_id)
		REFERENCES A_C0010(id)
);
--check sex
ALTER TABLE A_C0010
--DROP CONSTRAINT IF EXISTS CHK_A_C0010sex;
ADD CONSTRAINT CHK_A_C0010sex CHECK (sex in (0,1,9));
--check sdt
ALTER TABLE A_C0010
--DROP CONSTRAINT CHK_phone;
ADD CONSTRAINT CHK_phone check(tel  like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
--
ALTER TABLE A_L0010
ADD CONSTRAINT CHK_A_L0010status CHECK (status in (0,1));
--
ALTER TABLE A_L0010
--DROP CONSTRAINT IF EXISTS CHK_A_C0010sex;
ADD CONSTRAINT CHK_A_L0010pay CHECK (pay_method  in (0,1,2,3));

--bai 2
INSERT INTO A_M0010([begin], price, cre_user, cre_date)
SELECT 1, 1000, 'Test','2014-03-02'

INSERT INTO A_M0010([begin], price, cre_user, cre_date)
SELECT 51, 1200, 'Test', CONVERT(DATETIME, '2014-03-02', 111)

INSERT INTO A_M0010([begin], price, cre_user, cre_date)
SELECT 301, 1500, 'Test', CONVERT(DATETIME, '2014-03-02', 111)

INSERT INTO A_M0010([begin], price, cre_user, cre_date)
SELECT 201, 1800, 'Test', CONVERT(DATETIME, '2014-03-02', 111)
--Thực hiện update price của record có begin = 51
UPDATE A_M0010 SET 
	price = 5000
FROM A_M0010
WHERE 
	A_M0010.[begin] = 51
--Thực hiện xóa record có ID = 4
DELETE D FROM A_M0010 AS D
WHERE 
	D.id = 4
--Thực hiện insert lại record có id = 4
INSERT INTO A_M0010([begin], price, cre_user, cre_date)
SELECT 
	201
,	1800
,	'Test'
,	'2014-03-02'
--Select các item id, begin, price của bảng vừa tạo
SELECT
	id							AS ID
,	ISNULL(A_M0010.[begin],0)	AS [BEGIN]
,	ISNULL(A_M0010.price,0)		AS PRICE
FROM A_M0010
--bai 3
--Thực hiện tạo table Customer và insert vào bảng đó với data như bên trên
INSERT INTO
	A_C0010([name], card_id, age, address_1, address_2, sex, tel, email)
VALUES
	('LE VAN COT ', 1002440, 20, 'duy tan' , 'hang lac', 0, 0124545454, 'to@1214')
,	('NGUYEN HUNG DO', 1002441, 25, 'duy tan4' , 'hang lac2', 0, 0124545454, 'tuydao@1224')
,	('TRINH VAN A', 1002442, 21, 'duy tan3' , 'hang lac1', 0, 0124545454, 'tdao@1244')
,	('NGUYEN THI NO', 1002443, 20, 'duy tan2' , 'hang lac', 1, 0124545454, 'yendao@1254')
,	('CHI DINH ET', 1002444, 27, 'duy tan2' , 'hang lac', 0, 0124545454, 'tuyao@1254')
,	('PHAM DINH LAM', 1002445, 30, 'duy tan2' , 'hang lac', 0, 0124545454, 'ndao@1254')
,	('VU VAN VIEC', 1002446, 30, 'duy tan2' , 'hang lac', 0, 0124545454, 'yendao@1254')
,	('VO HUYEN NHU', 1002447, 30, 'duy tan2' , 'hang lac', 1, 0124545454, 'endao@1254')
,	('NGUYEN VAN TRAU', 1002448, 30, 'duy tan2' , 'hang lac', 0, 0124545454, 'to@1254')
--Thực hiện lấy danh sách khách hàng theo thứ tự giảm dần theo độ tuổi
SELECT
	id								AS id
,	ISNULL(A_C0010.[name],'')		AS names
,	ISNULL(A_C0010.age,0)			AS age
,	ISNULL(A_C0010.tel,'')			AS tel
,	ISNULL(A_C0010.email,'')		AS email
FROM A_C0010
ORDER BY A_C0010.age DESC
--YEU CAU 3
SELECT
	id								AS ID
,	ISNULL(A_C0010.[name],'')		AS NAMES
,	ISNULL(A_C0010.sex,1)			AS SEX
,	ISNULL(A_C0010.age,0)			AS	AGE
,	ISNULL(A_C0010.tel,'')			AS	Tel
,	ISNULL(A_C0010.email,'')		AS	EMAIL
FROM A_C0010
WHERE
	A_C0010.sex = 1
AND A_C0010.age > 24
AND A_C0010.age < 41
AND (
	A_C0010.[name]	LIKE	N'Nguyễn%' 
OR	A_C0010.[name]	LIKE	N'Trịnh%'
	)
AND A_C0010.[name]	LIKE	N'%Văn%'

--Đếm xem có bao nhiêu nữ, bao nhiêu nam và tính độ tuổi trung bình của nam, nữ
SELECT
	COUNT(A_C0010.sex)		AS NU
,	AVG(A_C0010.age)		AS TUOI 
FROM A_C0010
WHERE
	A_C0010.sex = 1
--
SELECT
	COUNT(A_C0010.sex)		AS NAM
,	AVG(A_C0010.age)		AS TUOI 
FROM A_C0010
WHERE
	A_C0010.sex = 0
--bai4
INSERT INTO A_L0010 (customer_id,year_month,kwh,[status],pay_method,pay_date)
VALUES
	(2,201401,150,1,0,'2014/01/24')
,	(5,201401,240,0,0,'')
,	(2,201402,59,0,0,'')
,	(4,201401,139,1,1,'2014/01/24')
,	(6,201401,25,1,1,'2014/01/24')
,	(7,201401,561,0,1,'')
,	(8,201401,300,0,1,'')
,	(9,201401,500,1,0,'2014/01/24')
,	(3,201401,123,1,0,'2014/01/24')
,	(5,201402,120,0,1,'')
,	(7,201402,562,0,1,'')
,	(9,201402,342,1,1,'2014/01/24')
,	(1,201402,345,1,0,'2014/01/24')
,	(3,201402,543,1,1,'2014/01/24')
,	(8,201402,213,0,1,'')
--Hiển thị id khách hàng, tên khách hàng đã thanh toán tiền điện trong tháng 1 của năm 2014 (201401)
SELECT 
	A_L0010.id			AS ID
,	A_C0010.[name]		AS NAMES	
FROM A_L0010
INNER JOIN A_C0010
ON A_L0010.customer_id = A_C0010.id
WHERE 
	A_L0010.year_month = 201401	
AND	A_L0010.pay_method = 1	
--Hiển thị id, tên, số điện đã dùng trong tháng 1 năm 2014 (201401) của từng khách hàng
SELECT 
	A_L0010.id			AS id
,	A_C0010.[name]		AS names
,	A_L0010.kwh			AS kwh
FROM A_L0010
LEFT JOIN A_C0010
ON A_L0010.customer_id = A_C0010.id
WHERE 
	A_L0010.year_month = 201401		
--Hiển thị id, tên, tổng số điện đã dùng của từng khách hàng
SELECT 
	A_C0010.id			AS ID
,	A_C0010.[name]		AS NAMES
,	SUM(A_L0010.kwh)			AS kWH
FROM A_L0010
RIGHT JOIN A_C0010 ON (
	A_L0010.customer_id = A_C0010.id
)
GROUP BY  A_C0010.id, A_C0010.[name]
--Hiển thị id, tên, tổng số điện của khách hàng có tổng số điện >= 500 kwh
SELECT 
	A_C0010.id			AS ID
,	A_C0010.[name]		AS NAMES
,	SUM(A_L0010.kwh)	AS kWH
FROM A_L0010
INNER JOIN A_C0010 ON 
	A_L0010.customer_id = A_C0010.id
GROUP BY  A_C0010.id, A_C0010.[name]	
HAVING SUM(A_L0010.kwh) > 500