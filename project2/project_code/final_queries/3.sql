create or replace procedure
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
end;
/
show errors