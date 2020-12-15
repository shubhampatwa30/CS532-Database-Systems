create or replace procedure
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
end;
/
show errors
