use czech;

select district_id, count(distinct account_id) as ac_freq
from account
group by district_id
order by ac_freq desc
limit 5;

select account_id, group_concat(distinct bank_to) as  bank_to, 
					  count(amount) as diff, group_concat(distinct amount) as rent
from czech.order
where k_symbol='SIPO'
group by account_id
having diff>1
order by diff desc;

select district_id, max(ml.amount) as total 
from account
inner join (
select account_id, amount from czech.order
where k_symbol='UVER') as ml
on ml.account_id=account.account_id
group by district_id
order by total desc;

select ml.account_id,district_id, max(amount) from account inner join (
select account_id, amount from czech.loan
) ml on ml.account_id=account.account_id
group by district_id
order by district_id,amount desc
;

create table xxx
select l.account_id, district_id, amount
from account a
inner join loan l on l.account_id=a.account_id;

select x1.district_id, x1.amount, xxx.account_id from (select district_id, max(amount) amount, group_concat(account_id) from xxx
group by district_id) x1
inner join xxx on xxx.district_id=x1.district_id
where xxx.amount=x1.amount;


select district_id, sum(amount) amount from xxx
group by district_id
order by amount desc
limit 5;

select * from (select x1.district_id, x1.amount, count(x2.amount) rank
from xxx x1, xxx x2
where x1.amount<x2.amount and x1.district_id=x2.district_id
group by x1.district_id, x1.amount
order by x1.district_id,x1.amount, x2.amount) ranked;

select x1.district_id, ceil(count(x1.amount)/2) rank
from xxx x1
group by district_id;


select district_id, amount,rank from (select x1.district_id, x1.amount, count(x2.amount) rank
from xxx x1, xxx x2
where x1.amount<x2.amount and x1.district_id=x2.district_id
group by x1.district_id, x1.amount
order by x1.district_id,x1.amount, x2.amount) ranked
where EXISTS (
select x1.district_id, ceil(count(x1.amount)/2) rank
from xxx x1
group by district_id
having ranked.district_id = x1.district_id
	AND ranked.rank = rank)
	;
