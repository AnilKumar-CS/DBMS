show databases;

use bmsce;

create table Branch(
bname varchar(30),
bcity varchar(30),
assests real,
primary key(bname)
);

desc Branch;

insert into Branch values("SBI_Cham","Bengaluru",50000);
insert into Branch values("SBI_Resid","Bengaluru",10000);
insert into Branch values("SBI_Shivaji","Bomay",20000);
insert into Branch values("SBI_parliment","Delhi",10000);
insert into Branch values("SBI_janta","Delhi",20000);

select * from Branch;


create table BranchAccount(
accno integer,
bname varchar(30),
balance real,
primary key(accno),
foreign key(bname) references Branch(bname)
);

desc BranchAccount;

insert into BranchAccount values(11,"SBI_janta",2000);
commit;
insert into BranchAccount values(12,"SBI_Resid",10000);
insert into BranchAccount values(13,"SBI_Shivaji",20000);
insert into BranchAccount values(14,"SBI_parliment",10000);
insert into BranchAccount values(15,"SBI_janta",20000);
select * from BranchAccount;

create table BankCustomer(
cname varchar(30),
cstreet varchar(30),
ccity varchar(30),
primary key(cname)
);

insert into BankCustomer values("Avinash","Bull_temple","Bengaluru");
insert into BankCustomer values("Mohan","National_College","Bengaluru");
insert into BankCustomer values("Nikhil","Akar_road","Dehli");
insert into BankCustomer values("Ravi","prithviraj_road","Delhi");
insert into BankCustomer values("Dinesh","Bannergatta_road","Bengaluru");

select * from BankCustomer;

desc BankCustomer;


create table Depositor(
cname varchar(30),
accno integer,
primary key(cname, accno),
foreign key(cname) references BankCustomer(cname),
foreign key(accno) references BranchAccount(accno)
);

desc Depositor;

insert into Depositor values("Avinash",11);
insert into Depositor values("Mohan",12);
insert into Depositor values("Nikhil",13);
insert into Depositor values("Ravi",14);
insert into Depositor values("Dinesh",15);

select * from Depositor;


create table loan(
lnumber int,
bname varchar(30),
amount real,
primary key(lnumber),
foreign key(bname) references Branch(bname)
);

desc loan;

insert into loan values(2,"SBI_Resid",2000);
insert into loan values(1,"SBI_Cham",1000);
insert into loan values(3,"SBI_Shivaji",3000);
insert into loan values(4,"SBI_parliment",4000);
insert into loan values(5,"SBI_janta",5000);

select * from loan;

SELECT D.cname, BA.bname, COUNT(BA.accno) AS no_of_deposits
FROM Depositor D
JOIN BranchAccount BA ON D.accno = BA.accno
GROUP BY D.cname, BA.bname
HAVING COUNT(BA.accno) >= 2;

SELECT D.cname FROM Depositor D JOIN BranchAccount BA ON D.accno = BA.accno JOIN Branch B ON BA.bname = B.bname
WHERE B.bcity = 'Delhi'
GROUP BY D.cname
HAVING COUNT(DISTINCT B.bname) = ( SELECT COUNT(*) FROM Branch WHERE bcity = 'Delhi'
);

DELETE FROM BranchAccount WHERE bname IN ( SELECT bname FROM Branch WHERE bcity = 'Bomay');

SELECT * FROM LOAN ORDER BY AMOUNT DESC;
SELECT D.cname FROM Depositor D JOIN BranchAccount BA ON D.accno = BA.accno JOIN Branch B ON BA.bname = B.bname
WHERE B.bcity = 'Delhi' GROUP BY D.cname
HAVING COUNT(DISTINCT B.bname) = (SELECT COUNT(*) FROM Branch WHERE bcity = 'Delhi');

SELECT B.cname FROM Depositor B LEFT JOIN Depositor D ON B.cname = D.cname WHERE D.accno IS NULL;

SELECT DISTINCT D.cname FROM Depositor D JOIN BranchAccount BA ON D.accno = BA.accno JOIN Branch B ON BA.bname = B.bname
JOIN loan L ON B.bname = L.bname WHERE B.bcity = 'Bengaluru';

UPDATE loan SET amount = amount * 1.05;

SELECT bname FROM Branch WHERE assests > ALL (SELECT assests FROM Branch WHERE bcity = 'Bengaluru');

DELETE FROM BranchAccount WHERE bname IN ( SELECT bname FROM Branch WHERE bcity = 'Bomay');







