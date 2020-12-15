create or replace procedure
drop_student(sid_in in students.sid%type,class_id_in in Classes.classid%type,message out varchar2)
is
begin
	delete from enrollments where sid= sid_in and classid=class_id_in;
	commit;
	message := 'Sucessfully dropped';
end;
/
show errors