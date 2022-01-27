/* I. CREATE TABLES */
host chcp 1258;
-- faculty (Khoa trong tr??ng)
create table faculty (
                         id number primary key,
                         name nvarchar2(30) not null
);

-- subject (Môn h?c)
create table subject(
                        id number primary key,
                        name nvarchar2(100) not null,
                        lesson_quantity number(2,0) not null -- t?ng s? ti?t h?c
);

-- student (Sinh viên)
create table student (
                         id number primary key,
                         name nvarchar2(30) not null,
                         gender nvarchar2(10) not null, -- gi?i tính
                         birthday date not null,
                         hometown nvarchar2(100) not null, -- quê quán
                         scholarship number, -- h?c b?ng
                         faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (B?ng ?i?m)
create table exam_management(
                                id number primary key,
                                student_id number not null constraint student_id references student(id),
                                subject_id number not null constraint subject_id references subject(id),
                                number_of_exam_taking number not null, -- s? l?n thi (thi trên 1 l?n ???c g?i là thi l?i)
                                mark number(4,2) not null -- ?i?m
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'C? s? d? li?u', 45);
insert into subject values (2, n'Trí tu? nhân t?o', 45);
insert into subject values (3, n'Truy?n tin', 45);
insert into subject values (4, n'?? h?a', 60);
insert into subject values (5, n'V?n ph?m', 45);


-- faculty
insert into faculty values (1, n'Anh - V?n');
insert into faculty values (2, n'Tin h?c');
insert into faculty values (3, n'Tri?t h?c');
insert into faculty values (4, n'V?t lý');


-- student
insert into student values (1, n'Nguy?n Th? H?i', n'N?', to_date('19900223', 'YYYYMMDD'), 'Hà N?i', 130000, 2);
insert into student values (2, n'Tr?n V?n Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình ??nh', 150000, 4);
insert into student values (3, n'Lê Thu Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê H?i Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Tr?n Anh Tu?n', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà N?i', 180000, 1);
insert into student values (6, n'Tr?n Thanh Mai', n'N?', to_date('19910812', 'YYYYMMDD'), 'H?i Phòng', null, 3);
insert into student values (7, n'Tr?n Th? Thu Th?y', n'N?', to_date('19910102', 'YYYYMMDD'), 'H?i Phòng', 10000, 1);


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

-- 1. Li?t kê danh sách sinh viên s?p x?p theo th? t?:
--      a. id t?ng d?n
SELECT * FROM student ORDER BY id ASC;
--      b. gi?i tính
SELECT * FROM student ORDER BY gender;
--      c. ngày sinh T?NG D?N và h?c b?ng GI?M D?N
SELECT * FROM student ORDER BY birthday ;
SELECT * FROM student ORDER BY scholarship DESC ;
-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
SELECT * FROM subject WHERE name  LIKE 'T%';
-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
SELECT * FROM student WHERE name  LIKE '%i';
-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
SELECT * FROM faculty WHERE name  LIKE '_n%';
-- 5. Sinh viên trong tên có t? 'Th?'
SELECT * FROM student WHERE name  LIKE '%Th?%';
-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên
SELECT * FROM student WHERE REGEXP_LIKE (name, '^[a-mA-M]') ORDER BY name;
-- 7. Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n
SELECT * FROM student WHERE scholarship>100000 ORDER BY faculty_id DESC;
-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i
SELECT * FROM student WHERE scholarship>150000 and hometown='Hà N?i';
-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
SELECT * FROM student WHERE birthday>=to_date('01-01-1991','DD-MM-YYYY') and birthday<=to_date('05-06-1991','DD-MM-YYYY');
-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
SELECT * FROM student WHERE scholarship>80000 and scholarship<150000;
-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
SELECT * FROM subject WHERE lesson_quantity >30 and lesson_quantity<45;


-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã
-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr?
-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.
select id ,gender,faculty_id, case when scholarship>500000 then N'H?c b?ng cao' else N' M?c trung bình' end
-- 2. Tính t?ng s? sinh viên c?a toàn tr??ng
from student;
SELECT COUNT(id) FROM student;
-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
SELECT gender, COUNT(id) FROM student GROUP BY gender;
-- 4. Tính t?ng s? sinh viên t?ng khoa
SELECT faculty.name, COUNT(student.id) FROM student
                                                FULL OUTER JOIN faculty
                                                                ON student.faculty_id = faculty.id
GROUP BY  faculty.name;

-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
SELECT subject.name, COUNT(student_id) FROM exam_management
                                                FULL OUTER JOIN subject
                                                                ON subject.id = exam_management.subject_id
GROUP BY subject.name ;
-- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
SELECT student.name, COUNT(exam_management.subject_id) FROM exam_management
                                                                FULL OUTER JOIN student
                                                                                ON student.id = exam_management.student_id
GROUP BY student.name ;
-- 7. T?ng s? h?c b?ng c?a m?i khoa
SELECT faculty.name, COUNT(student.id) FROM student
                                                FULL OUTER JOIN faculty
                                                                ON student.faculty_id = faculty.id
where student.scholarship >0
GROUP BY  faculty.name ;
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
SELECT faculty.name, MAX(student.scholarship) FROM student
                                                       FULL OUTER JOIN faculty
                                                                       ON student.faculty_id = faculty.id
GROUP BY  faculty.name ;
-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
SELECT COUNT(*),gender,faculty_id FROM student GROUP BY faculty_id,gender ;
-- 10. Cho bi?t s? l??ng sinh viên theo t?ng ?? tu?i
SELECT COUNT(* ),TO_CHAR(birthday, 'YYYY') FROM student  GROUP BY TO_CHAR(birthday, 'YYYY');
-- 11. Cho bi?t nh?ng n?i nào có ít nh?t 2 sinh viên ?ang theo h?c t?i tr??ng
select hometown, count(id) from student
GROUP BY hometown HAVING COUNT(id)>=2;
-- 12. Cho bi?t nh?ng sinh viên thi l?i ít nh?t 2 l?n
select student_id, count(number_of_exam_taking) from exam_management
GROUP BY student_id,subject_id HAVING COUNT(number_of_exam_taking)>=2;
-- 13. Cho bi?t nh?ng sinh viên nam có ?i?m trung bình l?n 1 trên 7.0
select st.name,st.gender,avg(mark) FROM student st INNER JOIN
                                        exam_management ex  on
                                                ex.student_id=st.id where ex.number_of_exam_taking=1 and gender=N'Nam'
group by name, gender, ex.number_of_exam_taking
having avg(mark)>7.0;
-- 14. Cho bi?t danh sách các sinh viên r?t ít nh?t 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)
select st.name FROM student st INNER JOIN
                    exam_management ex  on
                            ex.student_id=st.id where ex.number_of_exam_taking=1 and ex.mark<=4
group by name,ex.number_of_exam_taking
having COUNT(st.id)>=2 ;
-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam
select faculty_id, count(id) from student
WHERE gender=N'Nam' GROUP BY faculty_id HAVING COUNT(id)>=2;
-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
SELECT faculty_id,COUNT(id) from student where scholarship BETWEEN 20000 and 300000 group by faculty_id HAVING COUNT(id)>=2;
-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t
SELECT name,student.scholarship FROM student where scholarship=(select max (scholarship)from student ) ;

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02
select * from student
where EXTRACT(MONTH FROM birthday) IN (2);
-- 2. Sinh viên có tu?i l?n h?n 20
select * from student where EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM birthday)>20;
-- 3. Sinh viên sinh vào mùa xuân n?m 1990
SELECT * FROM student WHERE birthday>=to_date('04-02-1990','DD-MM-YYYY') and birthday<=to_date('06-05-1990','DD-MM-YYYY');

-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
select * from student st full OUTER join faculty fa on fa.id=st.faculty_id
where fa.name=N'Anh - V?n' or fa.name=N'V?t lý';
-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
select * from student st full OUTER join faculty fa on fa.id=st.faculty_id
where fa.name=N'Anh - V?n'and st.gender=N'Nam' or fa.name=N'Tin h?c' and st.gender=N'Nam';
-- 3. Cho bi?t sinh viên nào có ?i?m thi l?n 1 môn c? s? d? li?u cao nh?t
select st.name,ex.mark,sub.name from student st , exam_management ex ,
                                     subject sub
where st.id=ex.student_id and sub.id=ex.subject_id and sub.name=N'C? s? d? li?u' and ex.mark=(select max(mark)from exam_management, subject
                                                                                              where exam_management.subject_id=subject.id and subject.name=N'C? s? d? li?u' );
-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.
select st.name,st.birthday from student st where st.birthday=
                                                 (select min(to_char(st.birthday)) from student st, faculty fal where fal.name=N'Anh - V?n');
-- 5. Cho bi?t khoa nào có ?ông sinh viên nh?t
select student.faculty_id,faculty.name, COUNT(student.id) from student,faculty where student.faculty_id=faculty.id group by student.faculty_id, faculty.name  HAVING COUNT(student.id)=
                                                                                                                                                                     (select max (COUNT(id)) FROM student group by faculty_id)  ;
-- 6. Cho bi?t khoa nào có ?ông n? nh?t
select student.faculty_id,faculty.name, COUNT(student.id)from student,faculty where student.faculty_id=faculty.id and student.gender=N'N?' group by student.faculty_id, faculty.name  HAVING COUNT(student.id)=
                                                                                                                                                                                             (select max (COUNT(id)) FROM student group by faculty_id)  ;
-- 7. Cho bi?t nh?ng sinh viên ??t ?i?m cao nh?t trong t?ng môn
select sb.name,student_id, st.name,exam_management.mark from exam_management,(select MAX (mark) as max_mark,subject_id from exam_management group by subject_id)  a, subject sb ,student st
where st.id=exam_management.student_id and exam_management.subject_id=sb.id and a.subject_id=exam_management.subject_id and exam_management.mark=a.max_mark;
-- 8. Cho bi?t nh?ng khoa không có sinh viên h?c
select * from faculty fa WHERE not EXISTS( SELECT DISTINCT* from student WHERE faculty_id= fa.id ) ;
-- 9. Cho bi?t sinh viên ch?a thi môn c? s? d? li?u
select * from student where not exists( select distinct *
                                        from exam_management  where student.id=id and subject_id='01');
-- 10. Cho bi?t sinh viên nào không thi l?n 1 mà có d? thi l?n 2
select student_id,st.name from exam_management ex,student st where st.id=ex.student_id and number_of_exam_taking=2 and not EXISTS (select * FROM exam_management where number_of_exam_taking=1 and ex.student_id=exam_management.id )