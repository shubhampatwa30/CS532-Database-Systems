create or replace procedure
get_prerequisites(dept_code_in in prerequisites.dept_code%type,course_no_in in prerequisites.course_no%type,result out varchar2,checkvar in number,prereq out number)
is
CURSOR crefcur is
	select pre_dept_code,pre_course_no from prerequisites where dept_code = dept_code_in and course_no = course_no_in;
	course_row crefcur%rowtype;
	counter number;
	
	begin
		select count(*) into counter from Courses where dept_code = dept_code_in and course_no = course_no_in;
		open crefcur;
		fetch crefcur into course_row;
		if(crefcur%found) then
			while(crefcur%found) loop
				get_prerequisites(course_row.pre_dept_code, course_row.pre_course_no,result,0,prereq);
				if(result is NULL) then	
					result := course_row.pre_dept_code || ' ' || course_row.pre_course_no;
					prereq := 1;
				else
					result := result || ',' || course_row.pre_dept_code || ' ' ||  course_row.pre_course_no;
					prereq := prereq+1;
				end if;
				fetch crefcur into course_row;
			end loop;
		elsif (counter = 1 and checkvar = 1) then
			result := 'No prerequisite';
			prereq := 0;
		elsif (counter < 1 and checkvar = 1) then
			result := 'This course does not exists';
			prereq := 0;
		end if;
end get_prerequisites;
/
show errors