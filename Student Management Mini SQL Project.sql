/* Build a Simple SQL-Based system to store, manage, and report student details and their 
subject-wise marks.
> maintain student personal records
> Rocord marks for different subjects
> Generate useful reports: average, top scores , student counts
> Performs basic CURD(create, Read, update, delete) operations 
*/


create database studentManagementDB;
use studentManagementDB;

create table students(
student_id int primary key auto_increment,
student_name varchar(50),
student_gender enum("M","F"),
student_contact varchar(50),
student_email varchar(50)
);

create table subjects(
 subject_id int primary key auto_increment,
 subject_name varchar(50)
 );

create table marks(
 mark_id int primary key auto_increment,
 student_id int,
 subject_id int,
 marks int,
 foreign key (student_id) references students(Student_id),
 foreign key (subject_id) references subjects(subject_id)
 );
 
 DELIMITER $$
 
create procedure addStudent(
 student_name varchar(50),
student_gender enum("M","F"),
student_contact varchar(50),
student_email varchar(50)
 )
 begin
 insert into students(student_name,student_gender,student_contact,student_email)
   values (student_name, student_gender, student_contact, student_email);
 end $$
 DELIMITER ;
 
 
call addStudent('Arpita', 'F','+918973594324','arpita@gmail.com');
 
 select * from students;
 
 insert into subjects(subject_name)
 values("Hindi"),("Math"),("English");
 
 
  insert into marks(student_id,subject_id,marks)
 values(1,1,59),(1,2,69),(1,3,55);
 
  insert into marks(student_id,subject_id,marks)
 values(2,1,75),(2,2,55),(2,3,68);

 insert into marks(student_id,subject_id,marks)
 values(3,1,88),(3,2,69),(3,3,67);

 insert into marks(student_id,subject_id,marks)
 values(4,1,77),(4,2,55),(4,3,62);

select m.mark_id,m.marks,s.subject_name,st.student_name from marks m
join subjects s on m.subject_id=s.subject_id
join students st on m.student_id=st.student_id
 order  by mark_id;

select
s.student_id,
s.student_name,
sum(m.marks) as sum , avg(m.marks) as avgvalue
from students s join marks m on s.student_id = m.student_id
group by s.student_id,s.student_name order by sum desc;

DELIMITER $$
CREATE PROCEDURE getStudentCount()
BEGIN
    SELECT COUNT(*) AS total_students
    FROM students;
END $$

DELIMITER ;

CALL getStudentCount();






