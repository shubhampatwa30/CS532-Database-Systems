create or replace procedure
show_students(list out sys_refcursor)
is
begin 
	open list for
	select * from students;
	
end;
/
show errors
create or replace procedure
show_courses(list out sys_refcursor)
is
begin 
	open list for
	select * from courses;
	
end;
/
show errors
create or replace procedure
show_prerequisites(list out sys_refcursor)
is
begin 
	open list for
	select * from prerequisites;
	
end;
/
show errors
create or replace procedure
show_classes(list out sys_refcursor)
is
begin 
	open list for
	select * from classes;
	
end;
/
show errors
create or replace procedure
show_enrollments(list out sys_refcursor)
is
begin 
	open list for
	select * from enrollments;
	
end;
/
show errors
create or replace procedure
show_logs(list out sys_refcursor)
is
begin 
	open list for
	select * from logs;
	
end;
/
show errors