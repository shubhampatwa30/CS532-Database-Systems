create or replace procedure
check_grade(sid_in in students.sid%type,
dept_code_in in Classes.dept_code%type,
course_no_in in Classes.course_no%type,message out varchar2,truthvalue out number) is
counter number;
begin 	
	truthvalue := 0;
	select count(e.lgrade) into counter from Classes c,Enrollments e where e.classid = c.classid and e.sid =sid_in and c.dept_code =dept_code_in and c.course_no=course_no_in;
	if(counter >0 ) then
	
		select count(e.lgrade) into counter from Classes c,Enrollments e where e.classid = c.classid and e.sid =sid_in and c.dept_code =dept_code_in and c.course_no=course_no_in and e.lgrade not in ('A','A-','B+','B','B-','C+','C','C-');
		if(counter > 0) then
			message := 'Student has failed in prerequisites.';
			truthvalue := 0;
		else
			message := 'Case passed';
			truthvalue :=1;
		end if;
	else
		message:= 'Prerequisite courses have not been completed';
		truthvalue := 0;
	end if;
end;
/
show errors