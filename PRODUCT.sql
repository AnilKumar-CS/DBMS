show databases;
use cse;
show databases;
create table product(
pid int(5),
pcode varchar(30),
pname varchar(30),
pquantity int(10),
pprice float(3)
);
insert into product(pid, pcode, pname, pquantity, pprice, pcompany)
values(1, 'PEN', 'RED PEN', 2000, 5.45, 'Ball');
insert into product(pid, pcode, pname, pquantity, pprice)
values(2, 'PEN', 'BLUE PEN', 5000, 10);
insert into product(pid, pcode, pname, pquantity, pprice)
values(3, 'PEN', 'BLACK PEN', 800, 3.3);
insert into product(pid, pcode, pname, pquantity, pprice)
values(4, 'PENCIL', 'APSARA', 500, 5);
ALTER TABLE product ADD pcompany varchar(30);
alter table product rename column pcompany to pcom;
alter table product rename to product_details;
alter table product_details drop column pprice;
delete from product_details where pquantity = 2000;
select * from product_details;
desc Product;
