use czech;

select *
from client;

select (case when substr(birth_number, 3,2)>12 then 'F' else 'M' end) as gender, birth_number
from client;

select (case 
		when birth_number%10000>1300 then 'F' 
        else 'M' 
        end) as gender, 
        birth_number,
        birth_number%10000
from client;

