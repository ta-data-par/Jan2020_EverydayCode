select au_id,city
from authors;

select count(au_id) number_of_authors_per_city,city
from authors
group by city;

select count(au_id) number_of_authors_per_city,city
from authors
where count(au_id)>1
group by city;


select count(au_id) number_of_authors_per_city,city
from authors
group by city
having number_of_authors_per_city>1
order by number_of_authors_per_city desc;

select avg(price), type, group_concat(title)
from titles
group by type;

select title_id, sum(qty) tot
from sales
group by title_id
order by 2 desc
#fsdjfnsdjnfdsfsdfdskj
;

select title_id, sum(qty) tot, group_concat(stor_id)
from sales
group by title_id
order by 2 desc;

select count(title), pub_name
from publishers p inner join titles t on p.pub_id=t.pub_id
group by pub_name, title
;

select au_id, count(title_id)
from titleauthor ta
group by au_id
order by 2 desc;

select ifnull(sum(qty),0)
from sales;

select Store, Num_Titles/Num_Orders, Num_books/Num_Orders
from(
select st.stor_name as Store, count(distinct ord_num) as Num_Orders,
	   count(title_id) as Num_Titles, sum(qty) as Num_books
from sales s
inner join stores st on s.stor_id=st.stor_id
group by stor_name) as summary;

SELECT 
    Store,
    ord_date AS OrderDate,
    title AS Title,
    qty AS Qty,
    price AS Price,
    type AS Type
FROM
    (SELECT 
        st.stor_id AS StoreID,
            st.stor_name AS Store,
            COUNT(DISTINCT ord_num) AS Num_Orders,
            COUNT(title_id) AS Num_Titles,
            SUM(qty) AS Num_books
    FROM
        sales s
    INNER JOIN stores st ON s.stor_id = st.stor_id
    GROUP BY stor_name , st.stor_id) AS summary
        INNER JOIN
    sales s ON summary.StoreID = s.stor_id
        INNER JOIN
    titles t ON s.title_id = t.title_id
WHERE
    num_titles / num_orders > 1




;
create temporary table if not exists stores_sales_summary
SELECT st.stor_id AS StoreID,
            st.stor_name AS Store,
            COUNT(DISTINCT ord_num) AS Num_Orders,
            COUNT(title_id) AS Num_Titles,
            SUM(qty) AS Num_books
FROM sales s
INNER JOIN stores st ON s.stor_id = st.stor_id
GROUP BY stor_name , st.stor_id;

select * from stores_sales_summary;




SELECT Store, ord_date AS OrderDate, title AS Title, qty AS Qty, price AS Price, type AS Type
FROM stores_sales_summary sss
        INNER JOIN sales s ON sss.StoreID = s.stor_id
        INNER JOIN titles t ON s.title_id = t.title_id
WHERE num_titles / num_orders > 1;

create table if not exists stores_sales_summary
SELECT st.stor_id AS StoreID, st.stor_name AS Store, COUNT(DISTINCT ord_num) AS Num_Orders,
            COUNT(title_id) AS Num_Titles,SUM(qty) AS Num_books
FROM sales s
INNER JOIN stores st ON s.stor_id = st.stor_id
GROUP BY stor_name , st.stor_id;


select r.au_id, (r.RoyalSum + (ta.royaltyper/100)*(ti.advance)) as TotalProfits
from (
Select title_id, au_id, sum(RoyPerSale) as RoyalSum
from (
SELECT ta.title_id, ta.au_id, (ti.price * sales.qty * ti.royalty / 100 * ta.royaltyper / 100) as RoyPerSale
from titleauthor ta
inner join titles ti on ta.title_id = ti.title_id
inner join sales on ti.title_id=sales.title_id)
 as RoyPerSaleTable
group by title_id, au_id
) as r
inner join titles ti on r.title_id = ti.title_id
inner join titleauthor ta on r.au_id=ta.au_id
order by TotalProfits desc
