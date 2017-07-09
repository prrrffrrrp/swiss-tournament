-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

drop database if exists tournament;

create database tournament;

\c tournament;

create table players (
  name text,
  id serial primary key
);

create table matches (
  winner int references players(id),
  looser int references players(id),
  game_played int default 1
);

insert into players values ('Abraham');
insert into players values ('Marta');
insert into players values ('Pataam');
insert into players values ('Albert');
insert into players values ('Mikel');
insert into players values ('Beatrix');

insert into matches values (2,1);
insert into matches values (3,4);
insert into matches values (6,5);
insert into matches values (2,3);
insert into matches values (4,1);
insert into matches values (5,6);
insert into matches values (2,3);

  
create view wins as 
select players.id, players.name, count(matches.winner) as total_wins
from players left join matches on players.id = matches.winner
group by players.id
order by total_wins desc;

create view loses as
select players.id, players.name, count(matches.game_played) as total_matches
from players left join matches on players.id = matches.winner or players.id = matches.looser
group by players.id
order by count(winner) desc;

create view ranking as
select * from wins full join loses using(id,name)
order by total_wins desc;
