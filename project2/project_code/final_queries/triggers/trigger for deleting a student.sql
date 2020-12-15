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