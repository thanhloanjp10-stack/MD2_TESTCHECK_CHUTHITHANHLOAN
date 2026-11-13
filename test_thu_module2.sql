CREATE DATABASE IF NOT EXISTS test_module2;
USE test_module2;
-- PHẦN1:DDL‒THIẾTKẾCSDL(15ĐIỂM)
-- Viết câu lệnh:
-- Tạo01cơsởdữliệudùngchohệthốngquảnlýhọcvụ.
-- Tạo05bảng:courses,students, enrollments, enrollment_details, academic_logs.
CREATE TABLE courses (
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(100) NOT NULL,
course_code VARCHAR(100) NOT NULL UNIQUE,
department VARCHAR(100) NOT NULL,
creation_date DATE 
);

CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
full_name VARCHAR(100) NOT NULL,
major VARCHAR(100) NOT NULL,
phone_number VARCHAR(15) NOT NULL UNIQUE,
gpa DECIMAL(3,1) CHECK (gpa BETWEEN 0.0 AND 4.0)
);

CREATE TABLE enrollments (
enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
course_id INT ,
student_id INT,
enroll_time DATETIME NOT NULL,
credits INT CHECK(credits > 0),
status VARCHAR(50) CHECK (status IN ('pending','completed','dropped')),
FOREIGN KEY (course_id) REFERENCES courses (course_id),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE enrollment_details (
detail_id INT PRIMARY KEY AUTO_INCREMENT,
enrollment_id INT ,
attendance_check VARCHAR(100) NOT NULL ,
detail_date DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

CREATE TABLE academic_logs (
log_id INT PRIMARY KEY AUTO_INCREMENT,
enrollment_id INT,
student_id INT,
log_time DATETIME NOT NULL  DEFAULT CURRENT_TIMESTAMP,
note TEXT ,
FOREIGN KEY(enrollment_id) REFERENCES enrollments(enrollment_id),
FOREIGN KEY ( student_id ) REFERENCES students(student_id)
);
 
 -- PHẦN2:DML‒INSERT,UPDATE,DELETE(25ĐIỂM)
-- Câu1‒INSERT(15điểm)
-- Viếtcâulệnhchèndữliệuchocácbảng,sửdụngchínhxácdữliệumẫusau:
-- Bảng1:courses
INSERT INTO courses (course_name,course_code,department,creation_date)VALUES
('laptrinh Java','JAVA01','CNTT','2023-12-03'),
('Cau truc du lieu','DSA21','Khoa hoc may tinh','1996-11-25'),
('Co so du lieu','SQL03','CNTT','2001-07-08'),
('Mang may tinh','NET04','Truyen thong','1998-01-19'),
('Tri tue nhan tao','AI05','Khoa hoc may tinh','2000-09-30');
select*from courses;

-- Bảng2:students
INSERT INTO students (full_name ,major,phone_number,gpa)VALUES 
('Nguyen Van Hai','He thong TT','093112223','3.8'),
('Tran THu Ha','Ky thuat TM','0932223334','4.0'),
('Le Quoc Tuan','An toan TT','0903334445','3.6'),
('Pham Minh Chau','Du lieu lon','0934445556','3.9'),
('Hoang Gia Bao','Ky thuat TM','0935556667','3.7');
select * from students;

-- Bảng3:enrollments
INSERT INTO enrollments ( enrollment_id,course_id,student_id,enroll_time ,credits ,status) VALUES 
(7001,1,1,'2024-05-20 08:00',3,'pending'),
(7002,2,2,'2024-05-20 09:30',4,'completed'),
(7003,3,4,'2024-05-20 10:15',3,'pending'),
(7004,4,4,'2024-05-21 07:00',3,'completed'),
(7005,5,5,'2024-05-21 08:45',4,'Dropped');
SELECT * FROM enrollments ;
DELETE FROM enrollments WHERE enrollment_id<7000;
select * from enrollments;

-- Bảng4:enrollment_details
INSERT INTO enrollment_details( enrollment_id,attendance_check,detail_date)VALUES
(7002,'Du dieu kien thi','2024-05-20 10:00'),
(7004,'Vang 1 buoi','2024-05-21 08:00'),
(7001,'Dang hoc','2024-05-20 09:00'),
(7003,'Nghi phep','2024-05-20 11:00'),
(7005,'Khong di hoc','2024-05-21 09:00');
select*from enrollment_details;

-- Bảng5:academic_logs
INSERT INTO academic_logs ( log_id,enrollment_id ,student_id ,log_time ,note) VALUES
(1,7001,1,'2024-05-20 09:05','Bat dau lop hoc'),
(2,7002,2,'2024-05-20 10:05','Hoan tat mon hoc'),
(3,7003,3,'2024-05-20 11:10','Dang sap xep lich bu'),
(4,7004,5,'2024-05-21 18:10','Cho phe duyet diem'),
(5,7005,4,'2024-05-21 09:05','Huy do vang qua so buoi');
select *from academic_logs;

-- phan 2:update va delete 
USE test_module2;
UPDATE enrollments AS e
INNER JOIN courses AS c ON e.course_id = c.course_id
SET e.credits = e.credits+1
WHERE e.status = 'completed'
AND year ( c.creation_date )< 2000;
select*from enrollments;

DELETE FROM academic_logs 
WHERE log_time < '2024-05-20';
select*from academic_logs;

-- phan 3 truy van 
-- Câu1(5điểm):Liệtkêcácthôngtinsinhviêngồmfull_name,majorvàgpacủanhữngsinhviên
-- có điểmGPAlớnhơn3.8hoặcthuộcchuyênngành“KỹthuậtPM”.
SELECT full_name,major,gpa FROM students
WHERE gpa > 3.8 OR major = 'Ky thuat TM';

-- Câu2(5điểm):Liệtkêcácthôngtinmônhọcgồmcourse_namevàcourse_codecủanhững
-- mônhọccóngàytạotrongkhoảngtừ1998-01-01đến2001-12-31vàmãhọcphầnbắtđầubằng
-- “A”
SELECT course_name,course_code FROM courses 
WHERE creation_date BETWEEN '1998-01-01' AND '2001-12-31'
AND course_code LIKE 'A%';

-- Câu3(5điểm):Liệtkêcácbảnghiđăngkýhọcgồmenrollment_id,enroll_timevàcredits,
-- trong đódanhsáchđượcsắpxếptheosốtínchỉ(credits)giảmdầnvàchỉhiểnthị2bảnghiở
-- trang thứ hai.
SELECT enrollment_id,enroll_time,credits FROM enrollments
ORDER BY credits DESC
LIMIT 2 OFFSET 2;

-- PHẦN4:TRUYVẤNNÂNGCAO(15ĐIỂM)
-- Câu1(5điểm):Liệtkêcácthôngtinxửlýhọcvụgồmtênmônhọc,họtênsinhviên,chuyên
-- ngành, sốtín chỉ và thời gian đăngký, với dữliệu đượclấytừcácbảngliênquantronghệthống.
SELECT c.course_name AS 'Ten mon hoc',
s.full_name AS 'Ho ten sinh vien',
s.major AS 'Chuyen nganh ',
e.credits AS 'So tin chi',
e.enroll_time AS 'Thoi gian dang ky'
FROM enrollments AS e
JOIN courses AS c ON e.course_id = c.course_id
JOIN students AS s ON e.student_id = s.student_id;

-- Câu2(5điểm):Liệtkêcácthôngtinsinhviêngồmhọtênsinhviênvàtổngsốtínchỉmàsinh
-- viên đóđãtíchlũy(chỉ tính các đăngkýtrạngthái Completed), chỉ hiển thị những sinh viên có
-- tổng sốtín chỉ lớn hơn120.
SELECT 
s.full_name AS 'Ho ten sinh vien',
SUM(e.credits) AS 'Tong so tin chi'
FROM students AS s
JOIN enrollments AS e ON e.student_id = s.student_id
WHERE e.status = 'completed'
GROUP BY s.student_id, s.full_name
HAVING SUM(e.credits) > 120;

-- Câu3(5điểm):Liệtkêcácthôngtinsinhviêngồmstudent_id,full_namevàgpacủanhữngsinh
-- viên có điểmtrungbình(GPA)caonhất.

SELECT 
s.student_id AS 'Thong tin sinh vien',
s.full_name AS 'Ho ten sinh vien ',
s.gpa AS ' GPA'
FROM students AS s
WHERE s.gpa = (SELECT MAX(gpa) FROM students);

-- PHẦN5:INDEX&VIEW(10ĐIỂM)
-- Câu1(5điểm):Tạomộtchỉmục(index)trênbảngenrollmentsdựatrênhaithôngtinlàtrạng
-- thái học vàsốtínchỉ nhằmphụcvụviệctốiưutruyvấn.
CREATE INDEX idx_status_credits ON enrollments (status,credits);
SHOW INDEX FROM enrollments;

-- Câu2(5điểm):Tạomộtkhungnhìn(view)dữliệuhiểnthịhọtênsinhviên,tổngsốmônhọcđã
-- đăngkývàtổngsốtínchỉmàsinhviênđóđãtíchlũy,trongđókhôngtínhcácmônbịhủy
-- (Dropped).
CREATE VIEW v_fullname_courses_credits AS 
SELECT 
s.full_name AS 'Ho ten sinh vien',
COUNT(e.course_id) AS 'Tong so mon hoc',
SUM(e.credits) AS 'Tong so tin chi'
FROM students AS s
JOIN enrollments AS e  ON s.student_id = e.student_id 
WHERE e.status !='Dropped'
GROUP BY s.student_id,s.full_name;

-- PHẦN6:TRIGGER(10ĐIỂM)
-- Câu1(5điểm):Viếtmộttriggersaochokhitrạngtháicủamộtbảnghiđăngkýtrongbảng
-- enrollments 
-- đượccậpnhậtsanggiátrịCompletedthìhệthốngtựđộngthêmmộtbảnghi
-- mớivàobảng
-- academic_logs 
-- vớicácthôngtinsau:
-- •
-- enrollment_id :mãbảnghiđăngkývừađượccậpnhật.
-- •
-- student_id 
-- :sinhviênphụtráchbảnghi.
-- •
-- note 
-- :'Coursecompleted'.
-- •
-- log_time 
-- :thờigianhiệntạicủahệthống.
DELIMITER $$
CREATE TRIGGER tr_enrollments_updateinto_academiclogs
AFTER UPDATE ON enrollments
FOR EACH ROW 
BEGIN
IF NEW.status ='Completed' THEN 
INSERT INTO academic_logs (NEW.enrollment_id ,NEW.student_id,note,log_time)
VALUES(NEW.enrollment_id,NEw.Student_id,'Coursecompleted',now());
END IF;
END$$
DELIMITER $$

-- Câu2(5điểm):Viếtmộttriggersaochokhithêmmớimộtbảnghivàobảngenrollmentscó
-- trạng thái Completed thì hệ thốngtựđộngtăngđiểmtrungbìnhGPAcủasinhviêntươngứng
-- trong bảngstudents thêm0.1, nhưngđảmbảođiểmGPAkhôngvượtquá4.0.
DELIMITER $$
CREATE TRIGGER tr_after_insert_status
AFTER INSERT ON enrollments
FOR EACH ROW 
BEGIN
IF NEW.status ='Completed' THEN 
-- truong hop gpa<4.0 
UPDATE students
SET gpa= gpa+0.1
WHERE NEW.student_id = student_id;

-- truong hop gpa>4.0
UPDATE students
SET gpa = 4.0
WHERE NEW.student_id = student_id AND gpa>4.0;
END IF;
END$$
DELIMITER $$

-- PHẦN7:STOREDPROCEDURE(10ĐIỂM)
-- Câu1(5điểm):Viếtmộtstoredprocedurenhậnvàomãsinhviênvàtrảvềmộtthôngbáokết
-- quả, trong đó:
-- •
-- NếutổngsốtínchỉCompletedcủasinhviên>100thìtrảvề'Excellentprogress'.
-- •
-- •
-- Nếubằng100thìtrảvề'Targetmet'.
-- Nếunhỏhơn100thìtrảvề'Normalprogress'
