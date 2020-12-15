create or replace procedure
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
end;
/
show errors
