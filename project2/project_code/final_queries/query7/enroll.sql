create or replace procedure
final_enroll(sid_in in students.sid%type,
class_id_in in Classes.classid%type) is
counter number;
begin 	
	insert into enrollments values(sid_in, class_id_in, null);
end;
/
show errors