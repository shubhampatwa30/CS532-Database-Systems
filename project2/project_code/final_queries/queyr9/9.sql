create or replace procedure
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


end;
/
show errors
