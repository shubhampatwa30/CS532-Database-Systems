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