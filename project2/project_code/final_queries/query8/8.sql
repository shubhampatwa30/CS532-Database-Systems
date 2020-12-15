create or replace procedure
query_8(sid_in in Students.sid%type,class_id_in in Classes.classid%type,message out varchar2,truthvalue out number,list out sys_refcursor,dept_code1 out varchar2,course_no1 out varchar2)
is
counter number;
begin	
	truthvalue := 0;
	select count(sid) into counter from students where sid = sid_in;
	if(counter > 0) then
		select count(classid) into counter from Classes where classid = class_id_in;
		if (counter >0) then
			select count(*) into counter from enrollments where sid = sid_in and classid = class_id_in;
			if(counter >0 ) then
				truthvalue := 1;
				select c.dept_code into dept_code1 from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in and e.classid = class_id_in;
				select c.course_no into course_no1 from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in and e.classid = class_id_in;
				open list for 
				select c.dept_code,c.course_no from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in minus (select c.dept_code,c.course_no from Students s,Enrollments e, Classes c where s.sid = e.sid and e.classid = c.classid and e.sid = sid_in and e.classid = class_id_in); 
			else
				message := 'Student not enrolled in class';
			end if;
		else
			message := 'Class id not found';
		end if;
	else
		message := 'sid not found';
	end if;
end;
/
show errors
