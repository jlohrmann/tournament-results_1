-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP TABLE IF EXISTS players CASCADE;

CREATE TABLE players (
   playerid serial PRIMARY KEY,
   playername  varchar(100),
   numberofwins	integer,
   numberofmatches integer
);


DROP TABLE IF EXISTS matches CASCADE; 
 
CREATE TABLE matches (
     matchId serial PRIMARY KEY,
     winnerid integer,
     loserid integer
);


CREATE VIEW view_swiss_pairings AS 
 SELECT DISTINCT winnerid, winnername, loserid, losername
   FROM 
   ( SELECT p.playerid as winnerid, p.playername as winnername, p.numberofwins as wins
      FROM players p 
          Group By p.playerid, p.playername, p.numberofwins
            ORDER BY p.numberofwins DESC ) as junk,
   ( SELECT p2.playerid as loserid, p2.playername as losername, p2.numberofwins as wins2
        FROM players p2 
            Group By p2.playerid, p2.playername, p2.numberofwins
              ORDER BY p2.numberofwins DESC ) as junk2
  WHERE junk2.wins2 = junk.wins AND winnerid > loserid;

