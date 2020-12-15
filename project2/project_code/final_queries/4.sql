create or replace procedure
get_classes(sid_in students.sid%type,message out varchar2,list out sys_refcursor)
is
counter number;
begin 
	select count(students.sid) into counter from students where students.sid = sid_in;
	if (counter > 0) then
		select count(enrollments.sid) into counter from enrollments where enrollments.sid = sid_in;
		if (counter > 0) then
			open list for
			select s.sid,s.firstname,s.lastname,s.status,e.classid,concat (c.dept_code,c.course_no) as Course_id, c1.title from Students s,Enrollments e, Classes c, Courses c1 where s.sid = e.sid and e.classid = c.classid and c.dept_code = c1.dept_code and c.course_no = c1.course_no and e.sid = sid_in; 
		else
			message := 'Student has not enrolled in any classes';
		end if;
	else
	message:= 'Invalid sid for student';
	end if;
end;
/
show errors
