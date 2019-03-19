CREATE DATABASE IF NOT EXISTS fifa19;
CREATE TABLE IF NOT EXISTS players (
    player_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name_id INTEGER UNSIGNED NOT NULL,
    potential INTEGER (2) NOT NULL,
    club VARCHAR (30) NOT NULL,
    logo_url VARCHAR (500),
    value_market INT NOT NULL,
    position VARCHAR (3) NOT NULL COMMENT 'Position by FIFA',
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modificate_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) CHARSET=utf8;

LOAD DATA LOCAL INFILE'/home/juancalle/Documentos/BasesDatos/fifa19/players1.csv'
INTO TABLE players
FIELDS TERMINATED BY ','
CHARSET=utf8
IGNORE 1 LINES
(name_id, potential, club, logo_url, value_market, position);

CREATE TABLE IF NOT EXISTS name_player(
    name_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    age INTEGER UNSIGNED NOT NULL DEFAULT 1900,
    photo_url VARCHAR(500),
    nationality VARCHAR(80) NOT NULL,
    flag_url VARCHAR(80) NOT NULL,
    preferred_foot VARCHAR(10) NOT NULL,
    height INT NOT NULL,
    whight SMALLINT NOT NULL
) CHARSET=utf8;

LOAD DATA LOCAL INFILE'/home/juancalle/Documentos/BasesDatos/fifa19/name_payer.csv'
INTO TABLE name_player
FIELDS TERMINATED BY ';'
IGNORE 1 LINES
(`name`, age, photo_url, nationality, flag_url, preferred_foot, height, whight);


CREATE TABLE IF NOT EXISTS habilitys (
    hability_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name_id INTEGER UNSIGNED NOT NULL,
    finishing INT(2) NOT NULL,
    short_passing INT(2) NOT NULL,
    long_passing INT(2) NOT NULL,
    ball_control INT(2) NOT NULL,
    dribbling INT(2) NOT NULL,
    aceleration INT(2) NOT NULL,
    sprint_speed INT(2) NOT NULL,
    agility INT(2) NOT NULL,
    balance INT(2) NOT NULL,
    shot_power INT(2) NOT NULL,
    jumping INT(2) NOT NULL,
    stamina INT(2) NOT NULL,
    agresion INT(2) NOT NULL,
    interceptions INT(2) NOT NULL,
    vision INT(2) NOT NULL,
    gk_handling INT(2) NOT NULL,
    gk_kicking INT(2) NOT NULL,
    gk_reflexes INT(2) NOT NULL
);

LOAD DATA LOCAL INFILE'/home/juancalle/Documentos/BasesDatos/fifa19/Habilitys.csv'
INTO TABLE habilitys
FIELDS TERMINATED BY ';'
IGNORE 1 LINES
(name_id, finishing, short_passing, long_passing, ball_control, dribbling, aceleration, sprint_speed,
agility, balance, shot_power, jumping, stamina, agresion, interceptions, vision, gk_handling,
gk_kicking, gk_reflexes);


--Este query indica el nombre del jugador y su nivel de agilidad
SELECT n.name, h.agility
FROM habilitys AS h
JOIN name_player as n
  on n.name_id = h.hability_id
where n.name_id BETWEEN 1 and 10;

--Este query nos muestra el nombre la pisición y el club donde juega la agresión y el balance.
SELECT n.name, p.club, p.position, h.agresion , h.balance
FROM players as p
join name_player as n
    on p.name_id = n.name_id
join habilitys as h
    on p.name_id = h.name_id
WHERE n.nationality = 'Colombia'

 --¿Que cantidad de Clubes hay?
SELECT DISTINCT club from players
ORDER BY club;

--¿Cuantos jugadores hay en cada club?
SELECT club, COUNT(player_id) AS c_player
FROM players
GROUP BY club
ORDER BY c_player DESC, club;

--¿Cual es el promedio/desviación del precio del mercado de los jugadores?
SELECT club, AVG(value_market) AS prom, STDDEV(value_market) AS std
FROM players as p
JOIN name_player as n
 on p.name_id = n.name_id
GROUP BY club
ORDER BY std DESC 
LIMIT 20;

--Cual es el club con los jugadores mas costosos?
SELECT club MAX(value_market) 
FROM players
GROUP BY club
ORDER BY value_market DESC;
 
