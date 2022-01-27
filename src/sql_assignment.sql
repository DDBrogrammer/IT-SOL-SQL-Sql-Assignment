/* I. CREATE TABLES */
host chcp 1258;
-- faculty (Khoa trong trường)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn học)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- tổng số tiết học
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- giới tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- học bổng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (Bảng điểm)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- số lần thi (thi trên 1 lần được gọi là thi lại) 
	mark number(4,2) not null -- điểm
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'Cơ sở dữ liệu', 45);
insert into subject values (2, n'Trí tuệ nhân tạo', 45);
insert into subject values (3, n'Truyền tin', 45);
insert into subject values (4, n'Đồ họa', 60);
insert into subject values (5, n'Văn phạm', 45);


-- faculty
insert into faculty values (1, n'Anh - Văn');
insert into faculty values (2, n'Tin học');
insert into faculty values (3, n'Triết học');
insert into faculty values (4, n'Vật lý');


-- student
insert into student values (1, n'Nguyễn Thị Hải', n'Nữ', to_date('19900223', 'YYYYMMDD'), 'Hà Nội', 130000, 2);
insert into student values (2, n'Trần Văn Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình Định', 150000, 4);
insert into student values (3, n'Lê Thu Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê Hải Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Trần Anh Tuấn', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà Nội', 180000, 1);
insert into student values (6, n'Trần Thanh Mai', n'Nữ', to_date('19910812', 'YYYYMMDD'), 'Hải Phòng', null, 3);
insert into student values (7, n'Trần Thị Thu Thủy', n'Nữ', to_date('19910102', 'YYYYMMDD'), 'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
SELECT * FROM student ORDER BY id ASC;
--      b. giới tính
SELECT * FROM student ORDER BY gender;
--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN
SELECT * FROM student ORDER BY birthday ;
SELECT * FROM student ORDER BY scholarship DESC ;
-- 2. Môn học có tên bắt đầu bằng chữ 'T'
SELECT * FROM subject WHERE name  LIKE 'T%';
-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'
SELECT * FROM student WHERE name  LIKE '%i';
-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'
SELECT * FROM faculty WHERE name  LIKE '_n%';
-- 5. Sinh viên trong tên có từ 'Thị'
SELECT * FROM student WHERE name  LIKE '%Thị%';
-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên
SELECT * FROM student WHERE REGEXP_LIKE (name, '^[a-mA-M]') ORDER BY name;
-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần
SELECT * FROM student WHERE scholarship>100000 ORDER BY faculty_id DESC;
-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội
SELECT * FROM student WHERE scholarship>150000 and hometown='Hà Nội';
-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992
SELECT * FROM student WHERE birthday>=to_date('01-01-1991','DD-MM-YYYY') and birthday<=to_date('05-06-1991','DD-MM-YYYY');
-- 10. Những sinh viên có học bổng từ 80000 đến 150000
SELECT * FROM student WHERE scholarship>80000 and scholarship<150000;
-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45
SELECT * FROM subject WHERE lesson_quantity >30 and lesson_quantity<45;


-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.
select id ,gender,faculty_id, case when scholarship>500000 then N'Học bổng cao' else N' Mức trung bình' end		
-- 2. Tính tổng số sinh viên của toàn trường
from student;
SELECT COUNT(id) FROM student;
-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ.
SELECT gender, COUNT(id) FROM student GROUP BY gender;
-- 4. Tính tổng số sinh viên từng khoa
SELECT faculty.name, COUNT(student.id) FROM student 
FULL OUTER JOIN faculty
ON student.faculty_id = faculty.id
GROUP BY  faculty.name;
 
-- 5. Tính tổng số sinh viên của từng môn học
SELECT subject.name, COUNT(student_id) FROM exam_management 
FULL OUTER JOIN subject
ON subject.id = exam_management.subject_id
GROUP BY subject.name ;
-- 6. Tính số lượng môn học mà sinh viên đã học
SELECT student.name, COUNT(exam_management.subject_id) FROM exam_management 
FULL OUTER JOIN student
ON student.id = exam_management.student_id
GROUP BY student.name ;
-- 7. Tổng số học bổng của mỗi khoa	
SELECT faculty.name, COUNT(student.id) FROM student 
FULL OUTER JOIN faculty
ON student.faculty_id = faculty.id
where student.scholarship >0
GROUP BY  faculty.name ;
-- 8. Cho biết học bổng cao nhất của mỗi khoa
SELECT faculty.name, MAX(student.scholarship) FROM student 
FULL OUTER JOIN faculty
ON student.faculty_id = faculty.id
GROUP BY  faculty.name ;
-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa
SELECT COUNT(*),gender,faculty_id FROM student GROUP BY faculty_id,gender ;
-- 10. Cho biết số lượng sinh viên theo từng độ tuổi
SELECT COUNT(* ),TO_CHAR(birthday, 'YYYY') FROM student  GROUP BY TO_CHAR(birthday, 'YYYY');
-- 11. Cho biết những nơi nào có ít nhất 2 sinh viên đang theo học tại trường
select hometown, count(id) from student 
 GROUP BY hometown HAVING COUNT(id)>=2;
-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần
select student_id, count(number_of_exam_taking) from exam_management
GROUP BY student_id,subject_id HAVING COUNT(number_of_exam_taking)>=2;
-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 
select st.name,st.gender,avg(mark) FROM student st INNER JOIN
exam_management ex  on 
 ex.student_id=st.id where ex.number_of_exam_taking=1 and gender=N'Nam'
group by name, gender, ex.number_of_exam_taking
having avg(mark)>7.0;
-- 14. Cho biết danh sách các sinh viên rớt ít nhất 2 môn ở lần thi 1 (rớt môn là điểm thi của môn không quá 4 điểm)
select st.name FROM student st INNER JOIN
exam_management ex  on 
 ex.student_id=st.id where ex.number_of_exam_taking=1 and ex.mark<=4
group by name,ex.number_of_exam_taking
having COUNT(st.id)>=2 ;
-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
select faculty_id, count(id) from student 
WHERE gender=N'Nam' GROUP BY faculty_id HAVING COUNT(id)>=2;
-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000
SELECT faculty_id,COUNT(id) from student where scholarship BETWEEN 20000 and 300000 group by faculty_id HAVING COUNT(id)>=2;
-- 17. Cho biết sinh viên nào có học bổng cao nhất
SELECT name,student.scholarship FROM student where scholarship=(select max (scholarship)from student ) ; 

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02
select * from student 
where EXTRACT(MONTH FROM birthday) IN (2);
-- 2. Sinh viên có tuổi lớn hơn 20
select * from student where EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM birthday)>20;
-- 3. Sinh viên sinh vào mùa xuân năm 1990
SELECT * FROM student WHERE birthday>=to_date('04-02-1990','DD-MM-YYYY') and birthday<=to_date('06-05-1990','DD-MM-YYYY');

-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ
select * from student st full OUTER join faculty fa on fa.id=st.faculty_id
where fa.name=N'Anh - Văn' or fa.name=N'Vật lý';
-- 2. Những sinh viên nam của khoa ANH VĂN và khoa TIN HỌC
select * from student st full OUTER join faculty fa on fa.id=st.faculty_id
where fa.name=N'Anh - Văn'and st.gender=N'Nam' or fa.name=N'Tin học' and st.gender=N'Nam';
-- 3. Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất
select st.name,ex.mark,sub.name from student st , exam_management ex ,
 subject sub
where st.id=ex.student_id and sub.id=ex.subject_id and sub.name=N'Cơ sở dữ liệu' and ex.mark=(select max(mark)from exam_management, subject
where exam_management.subject_id=subject.id and subject.name=N'Cơ sở dữ liệu' );
-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.
select st.name,st.birthday from student st where st.birthday=
(select min(to_char(st.birthday)) from student st, faculty fal where fal.name=N'Anh - Văn');
-- 5. Cho biết khoa nào có đông sinh viên nhất
select student.faculty_id,faculty.name, COUNT(student.id) from student,faculty where student.faculty_id=faculty.id group by student.faculty_id, faculty.name  HAVING COUNT(student.id)=
(select max (COUNT(id)) FROM student group by faculty_id)  ;
-- 6. Cho biết khoa nào có đông nữ nhất
select student.faculty_id,faculty.name, COUNT(student.id)from student,faculty where student.faculty_id=faculty.id and student.gender=N'Nữ' group by student.faculty_id, faculty.name  HAVING COUNT(student.id)=
(select max (COUNT(id)) FROM student group by faculty_id)  ;
-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn
select sb.name,student_id, st.name,exam_management.mark from exam_management,(select MAX (mark) as max_mark,subject_id from exam_management group by subject_id)  a, subject sb ,student st
where st.id=exam_management.student_id and exam_management.subject_id=sb.id and a.subject_id=exam_management.subject_id and exam_management.mark=a.max_mark;
-- 8. Cho biết những khoa không có sinh viên học
select * from faculty fa WHERE not EXISTS( SELECT DISTINCT* from student WHERE faculty_id= fa.id ) ;
-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu
select * from student where not exists( select distinct *
from exam_management  where student.id=id and subject_id='01');
-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2
select student_id,st.name from exam_management ex,student st where st.id=ex.student_id and number_of_exam_taking=2 and not EXISTS (select * FROM exam_management where number_of_exam_taking=1 and ex.student_id=exam_management.id )