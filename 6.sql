show databases;
use cse;

create table department(
DeptNo int,
Dname varchar(30),
Dloc varchar(40),
primary key(DeptNo)
);

insert into department values(1, "CSE", "BasavanGudi");
insert into department values(2, "ECE", "JPNagar");
insert into department values(3, "EEE", "Bansankri");
insert into department values(4, "CE", "JayaNagar");
insert into department values(5, "MECH", "MysoreRoad");

select * from department;

desc department;

create table employe(
emp_no int,
Ename varchar(30),
MGR_no varchar(30),
Hiredate date,
salary int,
DeptNo int,
primary key(emp_no),
foreign key(DeptNo) references department(DeptNo)
);


insert into employe values(11, "Alexa", "9380","2019-03-11",23000,1);
insert into employe values(12, "Robin", "9757","2020-12-08",20000,2);
insert into employe values(13, "Maxi", "1994","2019-04-07",50000,3);
insert into employe values(14, "Hazelhood", "5843","2014-10-01",60000,4);
insert into employe values(15, "Strac", "6888","2011-05-02",100000,5);

select * from employe;

desc employe;

create table project1(
Pno int,
pname varchar(35),
ploc varchar(40),
primary key(Pno)
);

insert into project1 values(201, "Expense Tracker","Delhi");
insert into project1 values(202, "Hospetal Mangment","Mumbai");
insert into project1 values(203, "library Mangment","Kolkata");
insert into project1 values(204, "Security chat","Bengaluru");
insert into project1 values(205, "Project-k","London");

select * from project1;

desc project;

create table incentives(
emp_no int,
incentive_date date,
insentive_amount int,
primary key(incentive_date),
foreign key(emp_no) references employe(emp_no)
);

insert into incentives values(11,"1993-12-15",150000);
insert into incentives values(12,"1947-08-05",20000);
insert into incentives values(13,"1963-07-07",32000);
insert into incentives values(14,"1991-11-19",40000);
insert into incentives values(15,"1987-08-15",100000);

select * from incentives;

desc incentive;

create table assigned(
emp_no int,
pno int,
job_role varchar(30),
foreign key(emp_no) references employe(emp_no),
foreign key(Pno) references project1(Pno)
);

insert into assigned values(11, 201, "Developer");
insert into assigned values(12, 202, "Testing");
insert into assigned values(13, 203, "Contractor");
insert into assigned values(14, 204, "Manger");
insert into assigned values(15, 205, "Client");

select * from assigned;


desc assigned;

show tables;

SELECT m.ename, count(*) FROM employe e,employe m WHERE e.mgr_no = m.emp_no GROUP BY m.ename HAVING count(*) =(SELECT MAX(mycount) from (SELECT COUNT(*) mycount FROM employe GROUP BY mgr_no) a);

SELECT *
FROM employe m
WHERE m.emp_no IN
(SELECT mgr_no
FROM employe)
AND m.salary > (SELECT avg(e.salary)
FROM employe e
WHERE e.mgr_no = m.emp_no );

select distinct m.mgr_no from employe e, employe m where e.mgr_no =m.mgr_no and e.deptno=m.deptno and e.emp_no in(select distinct m.mgr_no from employe e, employe m where e.mgr_no =m.mgr_no and e.deptno=m.deptno);

select *
from employe e,incentives i
where e.emp_no=i.emp_no and 2 = ( select count(*)

from incentives j
where i.insentive_amount <= j.insentive_amount );

 