-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
drop database tournament;
create database tournament;
\c tournament;
\i tournament;
create table players (
id_p serial primary key,
name text);

create table matches (
id_m serial primary key,
winner integer references players (id_p),
loser integer references players (id_p)
);

create view standings as
select a.id_p as player_id, a.name,
(select count(*) from matches where matches.winner=a.id_p) as matches_won,
(select count(*) from matches where a.id_p in (winner, loser)) as matches_played
FROM players a GROUP BY a.id_p ORDER BY matches_won DESC;



