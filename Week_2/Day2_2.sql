select ta.title_id, ta.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyPerSale,t.advance * ta.royaltyper / 100 as advance
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on t.title_id=s.title_id;

#create temp table
create temporary table Step1
select ta.title_id, ta.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyPerSale,t.advance * ta.royaltyper / 100 as advance
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on t.title_id=s.title_id;

select *
from Step1;

select title_id, au_id, sum(RoyPerSale) as RoyalSum, group_concat(distinct advance) as finaladvance
from Step1
group by title_id,au_id;

create temporary table Step2
select title_id, au_id, sum(RoyPerSale) as RoyalSum, group_concat(distinct advance) as finaladvance
from Step1
group by title_id,au_id;

select RoyalSum+(t.advance * ta.royaltyper / 100), t.title_id, Step2.au_id
from Step2
inner join titles t on t.title_id = Step2.title_id
inner join titleauthor ta on ta.au_id = Step2.au_id;

create temporary table Step2_1
select title_id, au_id, sum(RoyPerSale) as RoyalSum, group_concat(distinct advance) as finaladvance
from Step1
group by title_id,au_id;

select RoyalSum+finaladvance, title_id, au_id
from Step2_1;


select group_concat(totrev),au_id
from (select RoyalSum+(t.advance * ta.royaltyper / 100) totrev, Step2.au_id
from Step2
inner join titles t on t.title_id = Step2.title_id
inner join titleauthor ta on ta.au_id = Step2.au_id) as blaah
group by au_id
;

select RoyalSum+(t.advance * ta.royaltyper / 100), Step2.au_id
from (select title_id, au_id, sum(RoyPerSale) as RoyalSum, group_concat(distinct advance) as finaladvance
from (select ta.title_id, ta.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyPerSale,t.advance * ta.royaltyper / 100 as advance
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on t.title_id=s.title_id)
group by title_id,au_id) as Step2
inner join titles t on t.title_id = Step2.title_id
inner join titleauthor ta on ta.au_id = Step2.au_id
order by 1 desc
limit 3;