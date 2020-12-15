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
