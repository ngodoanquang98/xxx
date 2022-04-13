--Question1 Query ra toàn bộ data của bảng employee				
SELECT
    ISNULL(id,0)			AS id 
,   ISNULL(name,NULL)     	AS name
,   ISNULL(yomigana,NULL) 	AS yomigana 
,   ISNULL(alphabet,NULL) 	AS alphabet
,   ISNULL(birthday,NULL) 	AS birthday 
,   ISNULL(gender,NULL)   	AS gender 
,   ISNULL(blood_type,NULL)	AS blood_type
,   ISNULL(section,NULL)  	AS section 
,   ISNULL(job_level,NULL)	AS job_level
,   ISNULL(office,NULL)   	AS office 
,   ISNULL(boss,NULL)     	AS boss 
,   ISNULL(retire,NULL)   	AS retire
FROM dbo.employee
--Question2			
--Từ bảng employee chỉ querry ra 、id、name、birthday			
SELECT
    ISNULL(id,0)			AS id 
,   ISNULL(name,NULL)     	AS name
,   ISNULL(birthday,NULL) 	AS birthday 
FROM dbo.employee
--Question3						
--	Query ra toàn bộ data của bảng employee 						
--	Phần title của bảng kết quả thì cho hiển thị tiếng Nhật như dưới đây						
SELECT
    ISNULL(id,0)			AS ID 
,   ISNULL(name,NULL)     	AS 氏名
,   ISNULL(yomigana,NULL) 	AS yヨミガナ 
,   ISNULL(alphabet,NULL) 	AS 英字
,   ISNULL(birthday,NULL) 	AS 生年月日 
,   ISNULL(gender,NULL)   	AS 性別
,   ISNULL(blood_type,NULL)	AS 血液型
,   ISNULL(section,NULL)  	AS 部署 
,   ISNULL(job_level,NULL)	AS 役職
,   ISNULL(office,NULL)   	AS 営業所
,   ISNULL(boss,NULL)     	AS 上司 
,   ISNULL(retire,NULL)   	AS 退職
FROM dbo.employee
/*Question4						
Sử dụng bảng employee、section và cho hiển thị tên bộ phận(部署名)						
*/
SELECT
    ISNULL(employee.id,0)		AS ID 
,   ISNULL(employee.name,NULL)  AS 氏名
,   ISNULL(yomigana,NULL) 		AS yヨミガナ 
,   ISNULL(alphabet,NULL) 		AS 英字
,   ISNULL(birthday,NULL) 		AS 生年月日 
,   ISNULL(gender,NULL)   		AS 性別
,   ISNULL(blood_type,NULL)		AS 血液型
,   ISNULL(section.name,NULL)  	AS 部署 
,   ISNULL(job_level,NULL)		AS 役職
,   ISNULL(office,NULL)   		AS 営業所
,   ISNULL(boss,NULL)     		AS 上司 
,   ISNULL(retire,NULL)   		AS 退職
FROM dbo.employee
LEFT JOIN section ON (
	section.id = employee.section
)
/*Question5								
Sử dụng bảng employee、section、job_level và cho hiển thị Tên bộ phận(部署名), tên chức danh(役職名)								
*/
SELECT
    ISNULL(employee.id,0)			AS ID 
,   ISNULL(employee.name,NULL)		AS 氏名
,   ISNULL(yomigana,NULL) 			AS yヨミガナ 
,   ISNULL(alphabet,NULL) 			AS 英字
,   ISNULL(birthday,NULL) 			AS 生年月日 
,   ISNULL(gender,NULL)   			AS 性別
,   ISNULL(blood_type,NULL)			AS 血液型
,   ISNULL(section.name,NULL)  		AS 部署 
,   ISNULL(job_level.name,NULL)		AS 役職
,   ISNULL(office,NULL)   			AS 営業所
,   ISNULL(boss,NULL)     			AS 上司 
,   ISNULL(retire,NULL)   			AS 退職
FROM dbo.employee
LEFT JOIN section ON (
	section.id = employee.section
)
LEFT JOIN job_level ON (
	job_level.id = employee.job_level
)
/*Question6					
Sử dụng table employee、library và cho hiển thị tên giới tính(性別名)					
*/
SELECT
    ISNULL(employee.id,0)		AS ID 
,   ISNULL(employee.name,NULL)  AS 氏名
,   ISNULL(birthday,NULL) 		AS 生年月日 
,   ISNULL(library.value,NULL)  AS 性別
,   ISNULL(blood_type,NULL)		AS 血液型
FROM dbo.employee
JOIN library ON (
	library.id = employee.gender
AND library.section = 'gender'
)	
/*Question7																									
sử dụng table employee、library và cho hiển thị tên giới tính (性別名)、tên nhóm máu(血液型名)																									
*/
SELECT
    ISNULL(employee.id,0)		AS ID 
,   ISNULL(employee.name,NULL)	AS 氏名
,   ISNULL(birthday,NULL) 		AS 生年月日 
,   ISNULL(l1.value,NULL)   	AS 性別
,   ISNULL(l2.value,NULL)		AS 血液型
FROM dbo.employee
LEFT JOIN library AS l1 ON (
	l1.id = employee.gender
AND l1.section = 'gender'
)
LEFT JOIN library AS l2 ON (
	l2.id = employee.blood_type
AND l2.section = 'blood_type'
)
/*Question8			
Sử dụng bảng  employee và cho hiển thị tên của cấp trên(上司名)																								
*/
SELECT 
    ISNULL(emp.id,0)		AS ID 
,   ISNULL(emp.name,NULL)	AS 氏名
,   ISNULL(bos.name,NULL)	AS 上司名
FROM dbo.employee AS emp
LEFT JOIN employee AS bos ON (
	emp.boss = bos.id
)
/*Question9			
Sử dụng table employee  và cho hiển thị tên cấp trên(上司名)			
Ở những item mà tên cấp trên là  NULL  thì cho hiển thị blank.			
*/
SELECT 
    ISNULL(emp.id,0)	AS ID 
,   ISNULL(emp.name,'')	AS 氏名
,   ISNULL(bos.name,'') AS 上司名
FROM dbo.employee AS emp
LEFT JOIN employee AS bos ON (
	emp.boss = bos.id
)
/*Question10				
Phương pháp hiển thị Ngày tháng năm sinh thì cho hiển thị như list Kết quả thực hiện dưới đây				
*/
SELECT
    ISNULL(id,0)					AS ID 
,   ISNULL(name,'')     			AS 氏名
,   convert(varchar, birthday,111) 	AS 生年月日 
,   convert(varchar, birthday, 106) AS birthday
FROM dbo.employee
/*Question11				
Phương pháp hiển thị Ngày tháng năm sinh thì cho hiển thị như list Kết quả thực hiện dưới đây				
*/
SELECT
    ISNULL(id,0)						AS ID 
,   ISNULL(name,'')     				AS 氏名
,   FORMAT(birthday,'yyyy年MM月dd日') 	AS 生年月日 
,   convert(varchar, birthday, 106)		AS birthday
FROM dbo.employee
/*Question12			
Lấy ra những nhân viên thuộc bộ phận(部署) phát triển(開発チーム)			
*/
SELECT
    ISNULL(employee.id,0)		AS ID 
,   ISNULL(employee.name,'')	AS 氏名
,   ISNULL(section.name,'')		AS 部署 
FROM employee
JOIN section ON (
	employee.section = section.id
)
WHERE
	section.name = 'SI事業部第開発ﾁｰﾑ'
/*Question13			
Lấy ra những nhân viên thuộc bộ phận phát triển(開発チーム) và đang làm việc.			
*/
SELECT
    ISNULL(employee.id,0)		AS ID 
,   ISNULL(employee.name,'')	AS 氏名
,   ISNULL(section.name,'')		AS 部署 
FROM employee
JOIN section ON (
	employee.section = section.id
)
WHERE
	section.name = 'SI事業部第開発ﾁｰﾑ'
AND employee.retire = 0
/*Question14		
Lấy ra những nhân viên có tên chứa chữ '田' hoặc chữ '子' từ bảng  employee 		
*/
SELECT
    ISNULL(employee.id,0)		AS ID 
,   ISNULL(employee.name,'')	AS 氏名
FROM employee
WHERE
	employee.name like '%田%'
OR	employee.name like '%子%'
/*Question15					
Lấy ra những nhân viên có tên mà ký tự thứ 6 là chữ h từ bảng employee 					
Ko bao gồm các nhân viên mà tên có ký tự thứ 6 là chữ H (chữ viết hoa) 					
*/
SELECT
    ISNULL(id,0)					AS id 
,   ISNULL(name,'')     			AS name
,   ISNULL(alphabet,'') 			AS alphabet 
FROM dbo.employee
WHERE 
	SUBSTRING(employee.alphabet, 6,1)  = 'h'
and	SUBSTRING(employee.alphabet, 5,1) != ' '
/*Question16				
gắn thêm thông tin và cho hiển thị ra: với những nhân viên có id  250 trở xuống thì hiển thị「250以下」、 nhỏ hơn 300 thì hiển thị 「300未満」				
*/
SELECT 
    ISNULL(emp.id,0)										AS ID 
,   ISNULL(emp.name,'')										AS 氏名
,   CASE	WHEN emp.id <= 250 THEN '250以下'	ELSE '' END	AS 判定1
,	CASE	WHEN emp.id <  300 THEN '300未満'	ELSE '' END	AS 判定2
FROM dbo.employee AS emp
/*Question17			
lấy ra những nhân viên có niên đại của birthday là 1970 			
*/
SELECT
    ISNULL(employee.id,0)				AS ID 
,   ISNULL(employee.name,'')			AS 氏名
,   YEAR(ISNULL(birthday,'1990-01-01'))	AS 誕生年
FROM employee
WHERE
	YEAR(birthday) >=1970
AND	YEAR(birthday) <=1979
/*Question18			
Lấy dữ liệu sắp xếp theo birthday giảm dần			
*/
SELECT
    ISNULL(id,0)					AS ID 
,   ISNULL(name,'')     			AS 氏名
,   ISNULL(birthday,NULL) 	AS 生年月日 
FROM dbo.employee
ORDER BY birthday DESC
/*Question19			
Lấy dữ liệu sắp xếp theo birthday giảm dần			
Với những nhân viên có ngày sinh là NULL thì setting đưa lên trên			
*/
SELECT
    ISNULL(id,0)	AS ID 
,   ISNULL(name,'') AS 氏名
,   birthday 		AS 生年月日 
FROM dbo.employee
ORDER BY 
	CASE 
		WHEN birthday IS NULL THEN 5 
		ELSE 0
	END DESC
,	birthday DESC
/*Question20		
Từ table employee và library, tổng hợp số người theo từng tên nhóm máu. 		
Với những người ko biết nhóm máu thì tổng hợp với tên là 「不明」(ko rõ)		
*/
SELECT
	ISNULL(library.value,'不明')			  AS 血液型
,	COUNT(ISNULL(employee.blood_type,1))  AS 人数
FROM dbo.employee
LEFT JOIN library ON (
	library.id = employee.blood_type
AND	library.section = 'blood_type'
)
GROUP BY  library.value
/*Question21		
Từ bảng employee tổng hợp số Nam(男性) và Nữ(女性) và cho hiển thị trên 1 dòng		
Những người đã nghỉ việc thì ko tính vào.		
*/
SELECT 
	COUNT(CASE WHEN emp.gender = 1 THEN '' END)	AS 女性
,	COUNT(CASE WHEN emp.gender = 2 THEN '' END)	AS 女性
FROM dbo.employee AS emp
WHERE
	emp.retire = 0
/*Question22		
tính tổng từ bảng employee 、với những role(役職) mà có tổng số người từ 5 trở lên thì đưa ra.		
Những người đã nghỉ việc thì ko tính vào.		
*/
SELECT
	ISNULL(job_level.name,'不明')	AS 役職
,	COUNT(employee.job_level)		AS 人数
FROM dbo.employee
LEFT JOIN job_level ON (
	employee.job_level = job_level.id
)
GROUP BY  job_level.name
HAVING	COUNT(employee.job_level) > 5
/*Question23			
Trường alphabet của table employee có cấu trúc First Name + space 1 byte + Last Name 						
Lấy ra và cho hiển thị First Name.			
*/
SELECT 
     ISNULL(id,0)										AS id 
,	 ISNULL(alphabet,'') 								AS alphabet
,	 SUBSTRING(alphabet, 1, CHARINDEX(' ', alphabet)-1)	AS FirstName
FROM employee
/*Question24			
từ các bảng client、client_person、business_charge、employee 			
lấy ra người phụ trách công ty khách hàng và nhân viên phụ trách.			
(bảng tiêu chuẩn là bảng business_charge)			
Trong những người phụ trách khác hàng, người có code nhỏ nhất sẽ làm người đại diện.			
Chỉ lấy ra người đại diện.			
Những người đã nghỉ việc thì ko tính vào kết quả.			
*/
SELECT
    ISNULL(client.name,'')		AS 顧客名
,   ISNULL(p.name +' 様','')    AS 担当者名
,   ISNULL(employee.name,'') 	AS 社員名 
FROM employee
RIGHT JOIN business_charge ON (
	business_charge.employee_id = employee.id
)
LEFT JOIN client ON (
	client.id = business_charge.client_id
)
LEFT JOIN (	select table2.id, table2.code ,name
		from  (select id, min(code) as code from client_person group by id) as table2
		join client_person on (
			table2.id   = client_person.id
		and table2.code = client_person.code
		)
		) as p ON (
	p.id = client.id 
)
WHERE
	employee.retire = 0 
/*Question25								
Add thông tin bản thân mình vào bảng  employee 								
Các item dưới đây cố định								
section   : 開発チーム (development team)								
job_level : 新入社員 (New comer)								
office    : 本社(Head office)								
boss      : 287								
								
sau khi add xong, cho hiển thị mỗi thông tin của bản thân mình như bảng kết quả thực hiện dưới đây. 								
Kết quả thực hiện là trong trường hợp WHERE chưa được chỉ định.								
*/
INSERT INTO [dbo].[employee] (
	[id]
,	[name]
,	[yomigana]
,	[alphabet]
,	[birthday]
,	[gender]
,	[blood_type]
,	[section]
,	[job_level]
,	[office]
,	[boss]
,	[retire])
SELECT
	888,'アルバイトS','ｱﾙﾊﾞｲﾄ ｴｽ','quang ngo','1990-01-01',2,1,4,12,1,287,0;	

SELECT  * from  employee    
/*	Question26					
	copy nội dung từ bảng employee sang bảng new_employee 					
	Loại trừ các trường hợp đã nghỉ việc hoặc part time.					
	 id mới sắp xếp id cũ tăng dần, bắt đầu từ 1.					
*/
INSERT INTO [dbo].[new_employee](
	[id]
,	[name]
,	[yomigana]
,	[alphabet]
,	[birthday]
,	[gender]
,	[blood_type]
,	[section]
,	[job_level]
,	[office]
,	[boss]
,	[retire]
)
SELECT
    ISNULL(id,0)				AS id 
,   ISNULL(name,NULL)     		AS name
,   ISNULL(yomigana,NULL) 		AS yomigana 
,   ISNULL(alphabet,NULL) 		AS alphabet
,   ISNULL(birthday,NULL) 		AS birthday 
,   ISNULL(gender,NULL)  		AS gender 
,   ISNULL(blood_type,NULL)		AS blood_type
,   ISNULL(section,NULL)  		AS section 
,   ISNULL(job_level,NULL)		AS job_level
,   ISNULL(office,NULL)   		AS office 
,   ISNULL(boss,NULL)     		AS boss 
,   ISNULL(retire,NULL)   		AS retire
FROM dbo.employee
WHERE
	retire = 0
/*Question27								
Nhân viên mới hết thời gian thử việc và thành nhân viên chính thức								
job_level sẽ update từ nhân viên mới (新入社員) sang nhân viên bình thường(一般社員)								
*/
UPDATE [dbo].[employee]
   SET [job_level] = 11
 WHERE [job_level] = 12
/*Question28							
ANS đã thêm chi nhánh công ty wor Chiba. Hãy add thêm thông tin office dưới đây. 							
thêm vào bảng office thông tin dưới đây							
id   : 7							
name : 千葉 (Chiba)							
							
Khách hàng HU ガラス (client.id = 421) が đã được chuyển đến Chiba							
Theo đó, nhân viên ANS phụ trách khách hàng UH ガラス cũng được chuyển đến Chiba							
Hãy update data để phù hợp với điều kiện. 							
Lưu ý không update những data của người đã nghỉ việc													
*/
INSERT INTO [dbo].[office]
SELECT		
	 7,'千葉';
UPDATE [dbo].[employee]
SET office = 7
WHERE id in (
	select employee.id
	from employee
	join business_charge on (
		employee.id = business_charge.employee_id 
	)
	where
		business_charge.client_id = 421
)
  

/*Question29					
Xóa những người đã nghỉ việc khỏi bảng employee 					
*/
DELETE FROM employee
WHERE retire = 1
/*Question30									
ở trong bảng business_charge, hãy xóa những data có employee_id mà ko có ràng buộc với id của employee									
*/
DELETE FROM business_charge
WHERE employee_id in ( 
	select employee_id
	from business_charge
	left join employee on (
		business_charge.employee_id = employee.id
	)
	where
		employee.id is null
)


