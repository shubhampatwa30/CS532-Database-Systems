drop table logs;
drop table prerequisites;
drop table enrollments;
drop table classes;
drop table courses;
drop table students;

create table students (sid char(4) primary key check (sid like 'B%'),
firstname varchar2(15) not null, lastname varchar2(15) not null, status varchar2(10) 
check (status in ('freshman', 'sophomore', 'junior', 'senior', 'graduate')), 
gpa number(3,2) check (gpa between 0 and 4.0), email varchar2(20) unique);

create table courses (dept_code varchar2(4) not null, course_no number(3) not null
check (course_no between 100 and 799), title varchar2(20) not null,
primary key (dept_code, course_no));

create table prerequisites (dept_code varchar2(4) not null,
course_no number(3) not null, pre_dept_code varchar2(4) not null,
pre_course_no number(3) not null,
primary key (dept_code, course_no, pre_dept_code, pre_course_no),
foreign key (dept_code, course_no) references courses on delete cascade,
foreign key (pre_dept_code, pre_course_no) references courses
on delete cascade);

create table classes (classid char(5) primary key check (classid like 'c%'), 
dept_code varchar2(4) not null, course_no number(3) not null, 
sect_no number(2), year number(4), semester varchar2(6) 
check (semester in ('Spring', 'Fall', 'Summer')), limit number(3), 
class_size number(3), foreign key (dept_code, course_no) references courses
on delete cascade, unique(dept_code, course_no, sect_no, year, semester),
check (class_size <= limit));

create table enrollments (sid char(4) references students, classid char(5) references classes, 
lgrade char check (lgrade in ('A', 'B', 'C', 'D', 'F', 'I', null)), primary key (sid, classid));

create table logs (logid number(7) primary key, who varchar2(10) not null, time date not null,
table_name varchar2(20) not null, operation varchar2(6) not null, key_value varchar2(14));


insert into students values ('B001', 'Anne', 'Broder', 'junior', 3.6, 'broder@bu.edu');
insert into students values ('B002', 'Terry', 'Buttler', 'senior', 3.7, 'buttler@bu.edu');
insert into students values ('B003', 'Tracy', 'Wang', 'senior', 4.0, 'wang@bu.edu');
insert into students values ('B004', 'Barbara', 'Callan', 'junior', 2.5, 'callan@bu.edu');
insert into students values ('B005', 'Jack', 'Smith', 'graduate', 3.0, 'smith@bu.edu');
insert into students values ('B006', 'Terry', 'Zillman', 'graduate', 4.0, 'zillman@bu.edu');
insert into students values ('B007', 'Becky', 'Lee', 'senior', 4.0, 'lee@bu.edu');
insert into students values ('B008', 'Tom', 'Baker', 'freshman', null, 'baker@bu.edu');








insert into courses values ('CS', 432, 'database systems');
insert into courses values ('Math', 314, 'discrete math');
insert into courses values ('CS', 240, 'data structure');
insert into courses values ('Math', 221, 'calculus I');
insert into courses values ('CS', 532, 'database systems');
insert into courses values ('CS', 552, 'operating systems');
insert into courses values ('CS', 352, 'operating systems');

insert into prerequisites values ('CS',532,'CS',432);
insert into prerequisites values ('CS',552, 'CS', 352);



insert into classes values  ('c0001', 'CS', 432, 1, 2020, 'Fall', 35, 34);
insert into classes values  ('c0002', 'Math', 314, 1, 2020, 'Fall', 25, 24);
insert into classes values  ('c0003', 'CS', 432, 1, 2019, 'Spring', 30, 30);
insert into classes values  ('c0004', 'CS', 240, 1, 2019, 'Fall', 40, 39);
insert into classes values  ('c0005', 'CS', 532, 1, 2019, 'Spring', 29, 28);
insert into classes values  ('c0006', 'Math', 221, 1, 2020, 'Spring', 30, 30);
insert into classes values  ('c0007', 'CS', 352, 1, 2019, 'Spring', 20, 19);




insert into enrollments values  ('B001', 'c0001', 'A');
insert into enrollments values  ('B002', 'c0002', 'B');
insert into enrollments values  ('B003', 'c0004', 'A');
insert into enrollments values  ('B004', 'c0004', 'C');
insert into enrollments values  ('B004', 'c0005', 'B');
insert into enrollments values  ('B005', 'c0006', 'B');
insert into enrollments values  ('B006', 'c0006', 'A');
insert into enrollments values  ('B001', 'c0002', 'C');
insert into enrollments values  ('B003', 'c0005', 'D');
insert into enrollments values  ('B007', 'c0007', 'A');
insert into enrollments values  ('B001', 'c0003', 'B');
insert into enrollments values  ('B001', 'c0006', 'B');
insert into enrollments values  ('B001', 'c0004', 'A');
insert into enrollments values  ('B001', 'c0005', 'B');
insert into enrollments values  ('B008', 'c0007', 'A');
insert into enrollments values  ('B008', 'c0005', 'B');

create sequence seq1
increment by 1
start with 1000001
minvalue 000000
maxvalue 9999999
nocycle
cache 20;



create or replace trigger student_insertion_trigger
after insert on students
for each row
declare
user_name varchar2(15);
begin 
select user into user_name from dual;
insert into logs values(seq1.nextval,user_name,sysdate,'students','insert',:new.sid);
end;
/
show errors

create or replace trigger delete_a_student_trigger
before delete on students
for each row 
declare
sid_in char(4);
user_name varchar2(15);
begin
sid_in := :old.sid;
delete from enrollments where sid = sid_in;
select user into user_name from dual;
insert into logs values(seq1.nextval,user_name,sysdate,'students','delete',sid_in);
end;
/
show errors

create or replace trigger enroll_a_student
after insert on enrollments
for each row 
declare
user_name varchar2(15);
classid_in Classes.classid%type;
begin
classid_in := :new.classid;
update Classes set class_size = class_size +1 where classid = classid_in;
select user into user_name from dual;
insert into logs values(seq1.nextval,user_name,sysdate,'enrollments','insert',classid_in);
end;
/
show errors

create or replace trigger remove_from_classes_trigger
before delete on enrollments
for each row 
declare
user_name varchar2(15);
classid_in Classes.classid%type;
begin
classid_in := :old.classid;
update Classes set class_size = class_size -1 where classid = classid_in;
select user into user_name from dual;
insert into logs values(seq1.nextval,user_name,sysdate,'enrollments','insert',classid_in);
end;
/
show errors





create or replace package project2 as 

procedure
show_students(list out sys_refcursor);

procedure
show_courses(list out sys_refcursor);

procedure
show_prerequisites(list out sys_refcursor);

procedure
show_classes(list out sys_refcursor);

procedure
show_enrollments(list out sys_refcursor);

procedure
show_logs(list out sys_refcursor);

procedure
insert_values(sid_in in students.sid%type,
firstname_in in students.firstname%type,
lastname_in in students.lastname%type,
status_in in students.status%type,
gpa_in in students.gpa%type,
email_in in students.email%type,message out varchar2);

procedure
get_classes(sid_in students.sid%type,message out varchar2,list out sys_refcursor);

procedure
get_prerequisites(dept_code_in in prerequisites.dept_code%type,course_no_in in prerequisites.course_no%type,result out varchar2,checkvar in number,prereq out number);

procedure
query_6(class_id_in in Classes.classid%type,message out varchar2,list out sys_refcursor);

procedure
query_7(sid_in in Students.sid%type,class_id_in in Classes.classid%type,message out varchar2,truthvalue out number);

procedure
final_enroll(sid_in in students.sid%type,
class_id_in in Classes.classid%type);

procedure
check_grade(sid_in in students.sid%type,
dept_code_in in Classes.dept_code%type,
course_no_in in Classes.course_no%type,message out varchar2,truthvalue out number);

procedure
query_8(sid_in in Students.sid%type,class_id_in in Classes.classid%type,message out varchar2,truthvalue out number,list out sys_refcursor,dept_code1 out varchar2,course_no1 out varchar2);

procedure
drop_student(sid_in in students.sid%type,class_id_in in Classes.classid%type,message out varchar2);

procedure
delete_a_student(sid_in in students.sid%type,message out varchar2);


end project2;
/
show errors

create or replace package body project2 as 

procedure
show_students(list out sys_refcursor)
is
begin 
	open list for
	select * from students;
	
end show_students;

procedure
show_courses(list out sys_refcursor)
is
begin 
	open list for
	select * from courses;
	
end show_courses;

procedure
show_prerequisites(list out sys_refcursor)
is
begin 
	open list for
	select * from prerequisites;
	
end show_prerequisites;

procedure
show_classes(list out sys_refcursor)
is
begin 
	open list for
	select * from classes;
	
end show_classes;

procedure
show_enrollments(list out sys_refcursor)
is
begin 
	open list for
	select * from enrollments;
	
end show_enrollments;

procedure
show_logs(list out sys_refcursor)
is
begin 
	open list for
	select * from logs;
	
end show_logs;


procedure
insert_values(sid_in in students.sid%type,
firstname_in in students.firstname%type,
lastname_in in students.lastname%type,
status_in in students.status%type,
gpa_in in students.gpa%type,
email_in in students.email%type,message out varchar2) is
counter number;
begin 
	select count(sid) into counter from students where sid = sid_in;
	if(counter>0) then
		message := 'Error  Sid exists';
	elsif( status_in not in ('freshman', 'sophomore', 'junior', 'senior', 'graduate')) then
		message := 'Error . status wrongly defined.';
	else	
		insert into students values (sid_in, firstname_in, lastname_in, status_in, gpa_in,email_in);
		message := 'Successful';
	end if;
end insert_values;


procedure
get_classes(sid_in students.sid%type,message out varchar2,list out sys_refcursor)
is
counter number;
begin 
	select count(students.sid) into counter from students where students.sid = sid_in;
	if (counter > 0) then
		select count(enrollments.sid) into counter from enrollments where enrollments.sid = sid_in;
		if (counter > 0) then
			open list for
			select s.sid,s.firstname,s.lastname,s.status,e.classid,concat (c.dept_code,c.course_no) as Course_id, c1.title from Students s,Enrollments e, Classes c, Courses c1 where s.sid = e.sid and e.classid = c.classid and c.dept_code = c1.dept_code and c.course_no = c1.course_no and e.sid = sid_in; 
		else
			message := 'Student has not enrolled in any classes';
		end if;
	else
	message:= 'Invalid sid for student';
	end if;
end get_classes;

procedure
get_prerequisites(dept_code_in in prerequisites.dept_code%type,course_no_in in prerequisites.course_no%type,result out varchar2,checkvar in number,prereq out number)
is
CURSOR crefcur is
	select pre_dept_code,pre_course_no from prerequisites where dept_code = dept_code_in and course_no = course_no_in;
	course_row crefcur%rowtype;
	counter number;
	
	begin
		select count(*) into counter from Courses where dept_code = dept_code_in and course_no = course_no_in;
		open crefcur;
		fetch crefcur into course_row;
		if(crefcur%found) then
			while(crefcur%found) loop
				get_prerequisites(course_row.pre_dept_code, course_row.pre_course_no,result,0,prereq);
				if(result is NULL) then	
					result := course_row.pre_dept_code || ' ' || course_row.pre_course_no;
					prereq := 1;
				else
					result := result || ',' || course_row.pre_dept_code || ' ' ||  course_row.pre_course_no;
					prereq := prereq+1;
				end if;
				fetch crefcur into course_row;
			end loop;
		elsif (counter = 1 and checkvar = 1) then
			result := 'No prerequisite';
			prereq := 0;
		elsif (counter < 1 and checkvar = 1) then
			result := 'This course does not exists';
			prereq := 0;
		end if;
end get_prerequisites;

procedure
query_6(class_id_in in Classes.classid%type,message out varchar2,list out sys_refcursor)
is
counter number;
begin	
	select count(classes.classid) into counter from Classes where Classes.classid = class_id_in;
	if (counter >0 ) then
		select count(s.sid) into counter from Students s,Enrollments e, Classes c, Courses c1 where s.sid = e.sid and e.classid = c.classid and c.course_no = c1.course_no and c.dept_code = c1.dept_code and c.classid = class_id_in;
		if (counter > 0) then
			open list for
			select s.sid,s.firstname,s.lastname,c.classid,c1.title,c.semester,c.year from Students s,Enrollments e, Classes c, Courses c1 where s.sid = e.sid and e.classid = c.classid and c.course_no = c1.course_no and c.dept_code = c1.dept_code and c.classid = class_id_in;
		else
			message := 'No students found';		
		end if;
	else
	message := 'Invalid class id';
	end if;
end query_6;


procedure
query_7(sid_in in Students.sid%type,class_id_in in Classes.classid%type,message out varchar2,truthvalue out number)
is
counter number;
limits number;
sizes number;
begin	
	truthvalue := 0;
	select count(students.sid) into counter from students where students.sid = sid_in;
	if (counter > 0) then
		select count(classes.classid) into counter from Classes where classes.classid = class_id_in;
		if (counter > 0) then
			select limit into limits from Classes where classid = class_id_in;
			select class_size into sizes from Classes where classid = class_id_in;
			if (limits - sizes > 0) then
				select count(e.sid) into counter from Enrollments e where e.classid = class_id_in and e.sid = sid_in;
				if (counter > 0) then
					message := 'Student is already enrolled in this class.';
				else
					select count(*) into counter from (select count(e.classid) from Enrollments e,Classes c where c.classid = e.classid and e.sid = sid_in having count(*) > 1 group by (e.sid,c.year,c.semester));
					if (counter > 0) then
						message := 'You are overloaded';
					else
						message := 'All conditions satisifed.Proceed for prerequisite check';
						truthvalue := 1;
					end if;	
				end if;
			
			
			else
				message := 'The class is full';
			end if;
	
		else
			message := 'class id is invalid';
		end if;
	
	else
		message := 'Sid not found';
	end if;
end query_7;

procedure
final_enroll(sid_in in students.sid%type,
class_id_in in Classes.classid%type) is
counter number;
begin 	
	insert into enrollments values(sid_in, class_id_in, null);
	commit;
end;

procedure
check_grade(sid_in in students.sid%type,
dept_code_in in Classes.dept_code%type,
course_no_in in Classes.course_no%type,message out varchar2,truthvalue out number) is
counter number;
begin 	
	truthvalue := 0;
	select count(e.lgrade) into counter from Classes c,Enrollments e where e.classid = c.classid and e.sid =sid_in and c.dept_code =dept_code_in and c.course_no=course_no_in;
	if(counter >0 ) then
	
		select count(e.lgrade) into counter from Classes c,Enrollments e where e.classid = c.classid and e.sid =sid_in and c.dept_code =dept_code_in and c.course_no=course_no_in and e.lgrade not in ('A','A-','B+','B','B-','C+','C','C-');
		if(counter > 0) then
			message := 'Student has failed in prerequisites.';
			truthvalue := 0;
		else
			message := 'Case passed';
			truthvalue :=1;
		end if;
	else
		message:= 'Prerequisite courses have not been completed';
		truthvalue := 0;
	end if;
end check_grade;

procedure
query_8(sid_in in Students.sid%type,class_id_in in Classes.classid%type,message out varchar2,truthvalue out number,list out sys_refcursor,dept_code1 out varchar2,course_no1 out varchar2)
is
counter number;
begin	
	truthvalue := 0;
	select count(sid) into counter from students where sid = sid_in;
	if(counter > 0) then
		select count(classid) into counter from Classes where classid = class_id_in;
		if (counter >0) then
			select count(*) into counter from enrollments where sid = sid_in and classid = class_id_in;
			if(counter >0 ) then
				truthvalue := 1;
				select c.dept_code into dept_code1 from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in and e.classid = class_id_in;
				select c.course_no into course_no1 from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in and e.classid = class_id_in;
				open list for 
				select c.dept_code,c.course_no from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in minus (select c.dept_code,c.course_no from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in and e.classid = class_id_in); 
			else
				message := 'Student not enrolled in class';
			end if;
		else
			message := 'Class id not found';
		end if;
	else
		message := 'sid not found';
	end if;
end query_8;

procedure
drop_student(sid_in in students.sid%type,class_id_in in Classes.classid%type,message out varchar2)
is
begin
	delete from enrollments where sid= sid_in and classid=class_id_in;
	commit;
	message := 'Sucessfully dropped';
end drop_student;


procedure
delete_a_student(sid_in in students.sid%type,message out varchar2)
is
counter number;
begin
	select count(*) into counter from students where sid = sid_in;
	if (counter = 0) then
		message := 'sid not found';
	else
		delete from students where students.sid = sid_in;
		commit;
		message := 'Delete successful';
	end if;


end delete_a_student;

end project2;
/
show errors

