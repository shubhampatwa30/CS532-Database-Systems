insert into students values ('B001', 'Anne', 'Broder', 'junior', 3.6, 'broder@bu.edu');
insert into students values ('B002', 'Terry', 'Buttler', 'senior', 3.7, 'buttler@bu.edu');
insert into students values ('B003', 'Tracy', 'Wang', 'senior', 4.0, 'wang@bu.edu');
insert into students values ('B004', 'Barbara', 'Callan', 'junior', 2.5, 'callan@bu.edu');
insert into students values ('B005', 'Jack', 'Smith', 'graduate', 3.0, 'smith@bu.edu');
insert into students values ('B006', 'Terry', 'Zillman', 'graduate', 4.0, 'zillman@bu.edu');
insert into students values ('B007', 'Becky', 'Lee', 'senior', 4.0, 'lee@bu.edu');
insert into students values ('B008', 'Tom', 'Baker', 'freshman', null, 'baker@bu.edu');








insert into courses values ('CS', 432, 'database systems');
insert into courses values ('Math', 314, 'discrete math');
insert into courses values ('CS', 240, 'data structure');
insert into courses values ('Math', 221, 'calculus I');
insert into courses values ('CS', 532, 'database systems');
insert into courses values ('CS', 552, 'operating systems');
insert into courses values ('CS', 352, 'operating systems');

insert into prerequisites values ('CS',532,'CS',432);
insert into prerequisites values ('CS',552, 'CS', 352);



insert into classes values  ('c0001', 'CS', 432, 1, 2020, 'Fall', 35, 34);
insert into classes values  ('c0002', 'Math', 314, 1, 2020, 'Fall', 25, 24);
insert into classes values  ('c0003', 'CS', 432, 1, 2019, 'Spring', 30, 30);
insert into classes values  ('c0004', 'CS', 240, 1, 2019, 'Fall', 40, 39);
insert into classes values  ('c0005', 'CS', 532, 1, 2019, 'Spring', 29, 28);
insert into classes values  ('c0006', 'Math', 221, 1, 2020, 'Spring', 30, 30);
insert into classes values  ('c0007', 'CS', 352, 1, 2019, 'Spring', 20, 19);




insert into enrollments values  ('B001', 'c0001', 'A');
insert into enrollments values  ('B002', 'c0002', 'B');
insert into enrollments values  ('B003', 'c0004', 'A');
insert into enrollments values  ('B004', 'c0004', 'C');
insert into enrollments values  ('B004', 'c0005', 'B');
insert into enrollments values  ('B005', 'c0006', 'B');
insert into enrollments values  ('B006', 'c0006', 'A');
insert into enrollments values  ('B001', 'c0002', 'C');
insert into enrollments values  ('B003', 'c0005', 'D');
insert into enrollments values  ('B007', 'c0007', 'A');
insert into enrollments values  ('B001', 'c0003', 'B');
insert into enrollments values  ('B001', 'c0006', 'B');
insert into enrollments values  ('B001', 'c0004', 'A');
insert into enrollments values  ('B001', 'c0005', 'B');
insert into enrollments values  ('B008', 'c0007', 'A');
insert into enrollments values  ('B008', 'c0005', 'B');




