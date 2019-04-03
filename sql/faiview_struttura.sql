drop view vw_struttura1;
drop view vw_struttura2;
drop view vw_struttura3;
drop view vw_struttura4;
drop view vw_struttura5;
drop view vw_struttura6;
drop view vw_struttura7;

create view vw_struttura1 as (select * from struttura where livello= 1);
create view vw_struttura2 as (select * from struttura where livello= 2);
create view vw_struttura3 as (select * from struttura where livello= 3);
create view vw_struttura4 as (select * from struttura where livello= 4);
create view vw_struttura5 as (select * from struttura where livello= 5);
create view vw_struttura6 as (select * from struttura where livello= 6);
create view vw_struttura7 as (select * from struttura where livello= 7);

grant all on vw_struttura1 to public;
grant all on vw_struttura2 to public;
grant all on vw_struttura3 to public;
grant all on vw_struttura4 to public;
grant all on vw_struttura5 to public;
grant all on vw_struttura6 to public;
grant all on vw_struttura7 to public;

