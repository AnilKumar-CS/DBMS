show databases;

create database emp;
use emp;

CREATE TABLE dept (
deptno decimal(2,0) primary key,
dname varchar(14) default NULL,
loc varchar(13) default NULL
);

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'MUMBAI');
INSERT INTO dept VALUES (20, 'RESEARCH', 'BENGALURU');
INSERT INTO dept VALUES (30, 'SALES', 'DELHI');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'CHENNAI');

select * from dept;

CREATE TABLE emp (
empno decimal(4,0) primary key,
ename varchar(10) default NULL,
mgr_no decimal(4,0) default NULL,
hiredate date default NULL,
sal decimal(7,2) default NULL,
deptno decimal(2,0) references dept(deptno) on delete cascade on update cascade
);

INSERT INTO emp VALUES (7369, 'Adarsh', 7902, '2012-12-17', '80000.00', '20');
INSERT INTO emp VALUES (7499, 'Shruthi', 7698, '2013-02-20', '16000.00', '30');
INSERT INTO emp VALUES (7521, 'Anvitha', 7698, '2015-02-22', '12500.00', '30');
INSERT INTO emp VALUES (7566, 'Tanvir', 7839, '2008-04-02', '29750.00', '20');

select * from emp;

create table incentives (
empno decimal(4,0) references emp(empno) on delete cascade on update cascade,
incentive_date date,
incentive_amount decimal(10,2),
primary key(empno,incentive_date)
);

INSERT INTO incentives VALUES (7499, '2019-02-01', 5000.00);
INSERT INTO incentives VALUES (7521, '2019-03-01', 2500.00);
INSERT INTO incentives VALUES (7566, '2022-02-01', 5070.00);
INSERT INTO incentives VALUES (7654, '2020-02-01', 2000.00);

select * from incentives;


Create table project (
pno int primary key,
pname varchar(30) not null,
ploc varchar(30)
);

INSERT INTO project VALUES (101, 'AI Project', 'BENGALURU');
INSERT INTO project VALUES (102, 'IOT', 'HYDERABAD');
INSERT INTO project VALUES (103, 'BLOCKCHAIN', 'BENGALURU');
INSERT INTO project VALUES (104, 'DATA SCIENCE', 'MYSURU');

select * from project;


Create table assigned_to (
empno decimal(4,0) references emp(empno) on delete cascade on update cascade,
pno int references project(pno) on delete cascade on update cascade,
job_role varchar(30),
primary key(empno,pno)
);

INSERT INTO assigned_to VALUES (7499, 101, 'Software Engineer');
INSERT INTO assigned_to VALUES (7521, 101, 'Software Architect');
INSERT INTO assigned_to VALUES (7566, 101, 'Project Manager');
INSERT INTO assigned_to VALUES (7654, 102, 'Sales');

select * from assigned_to;


show tables;

SELECT m.ename, count(*) FROM emp e,emp m WHERE e.mgr_no = m.empno GROUP BY m.ename
HAVING count(*) =(SELECT MAX(mycount) from (SELECT COUNT(*) mycount FROM emp
GROUP BY mgr_no) a);

SELECT * FROM emp m WHERE m.empno IN (SELECT mgr_no FROM emp) AND m.sal > (SELECT AVG(e.sal) FROM emp e WHERE e.mgr_no = m.empno);

SELECT * FROM emp e, incentives i WHERE e.empno = i.empno AND 2 = 
( SELECT COUNT(*) FROM incentives j WHERE i.incentive_amount <= j.incentive_amount );

SELECT * FROM EMP E WHERE E.DEPTNO = (SELECT E1.DEPTNO FROM EMP E1 WHERE E1.EMPNO=E.MGR_NO);

SELECT e.empno FROM emp e, assigned_to a, project p WHERE e.empno = a.empno AND a.pno = p.pno
AND p.ploc IN ('Bengaluru', 'Hyderabad', 'Mysuru');

SELECT DISTINCT e.ename FROM emp e, incentives i WHERE (SELECT MAX(e2.sal + i2.incentive_amount)
FROM emp e2, incentives i2 WHERE e2.empno = i2.empno) >= ANY (SELECT e1.sal FROM emp e1
WHERE e.deptno = e1.deptno);


