create table if not exists stores_sales_summary
SELECT st.stor_id AS StoreID,
            st.stor_name AS Store,
            COUNT(DISTINCT ord_num) AS Num_Orders,
            COUNT(title_id) AS Num_Titles,
            SUM(qty) AS Num_books
FROM sales s
INNER JOIN stores st ON s.stor_id = st.stor_id
GROUP BY stor_name , st.stor_id;

insert into stores_sales_summary
SELECT st.stor_id AS StoreID,
            st.stor_name AS Store,
            COUNT(DISTINCT ord_num) AS Num_Orders,
            COUNT(title_id) AS Num_Titles,
            SUM(qty) AS Num_books
FROM sales s
INNER JOIN stores st ON s.stor_id = st.stor_id
GROUP BY stor_name , st.stor_id;


create table name(
col1 float(5,2) not null,
col2 int not null,
col3 varchar(100),
primary key(col2),
index(col2));

drop table if exists name;

create table name(
col1 float(5,2) not null,
col2 int not null,
col3 varchar(100),
primary key(col2),
index(col2,col3));

drop table if exists name;

create table name(
col1 float(5,2) not null,
col2 int not null unique auto_increment,
col3 varchar(100),
primary key(col2),
index(col2,col3));

alter table name
add column col4 int default null;

select * from name;

insert into name values(
'10.50', '','txt','1');

insert into name (col1,col3,col4) values(
11.00,'qwer',1);

insert into name (col1,col3,col4) values(
11.00,'qwer',1),(
11.00,'qwer',1),(
11.00,'qwer',1),(
11.00,'qwer',1),(
11.00,'qwer',1);