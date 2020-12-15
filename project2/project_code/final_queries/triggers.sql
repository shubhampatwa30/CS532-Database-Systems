
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