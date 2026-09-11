CREATE TABLE batting_stats (
    player_id INTEGER,
    player_name VARCHAR(100),
    team_id INTEGER,
    team_name VARCHAR(100),
    age INTEGER,
    games_played INTEGER,
    runs INTEGER,
    doubles INTEGER,
    triples INTEGER,
    home_runs INTEGER,
    strikeouts INTEGER,
    walks INTEGER,
    hits INTEGER,
    batting_average DECIMAL(5,3),
    at_bats INTEGER,
    obp DECIMAL(5,3),
    slg DECIMAL(5,3),
    ops DECIMAL(5,3),
    stolen_bases INTEGER,
    plate_appearances INTEGER,
    total_bases INTEGER,
    rbi INTEGER
);

CREATE TABLE pitching_stats (
    player_name VARCHAR(100),
    innings_pitched DECIMAL,
    strikeouts INTEGER,
    wins INTEGER,
    quality_starts INTEGER,
    saves INTEGER,
    era DECIMAL,
    whip DECIMAL,
    earned_runs INTEGER,
    hits_allowed INTEGER,
    walks INTEGER,
    home_runs_allowed INTEGER,
    games_played INTEGER,
    games_started INTEGER,
    losses INTEGER,
    complete_games INTEGER
);


CREATE TABLE team_stats (
    team_id INTEGER,
    team_name VARCHAR(100),
    league VARCHAR(50),
    division VARCHAR(100),
    games_played INTEGER,
    runs INTEGER,
    doubles INTEGER,
    triples INTEGER,
    home_runs INTEGER,
    walks INTEGER,
    strikeouts INTEGER,
    hits INTEGER,
    batting_average DECIMAL(5,3),
    obp DECIMAL(5,3),
    slg DECIMAL(5,3),
    ops DECIMAL(5,3),
    stolen_bases INTEGER
);



SELECT
    player_name,
    team_name,
    ops
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY ops DESC
LIMIT 10;

SELECT
    player_name,
    team_name,
    ops
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY ops ASC
LIMIT 10;


SELECT 
    player_name,
    team_name,
    home_runs
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY home_runs DESC
LIMIT 10;

SELECT 
    player_name,
    team_name,
    home_runs
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY home_runs ASC
LIMIT 10;



SELECT
	player_name,
	team_name,
	batting_average
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY batting_average DESC
LIMIT 10;

SELECT
	player_name,
	team_name,
	batting_average
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY batting_average ASC
LIMIT 10;


SELECT
	player_name,
	team_name,
	age
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY age DESC
LIMIT 10;

SELECT
	player_name,
	team_name,
	age
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY age ASC
LIMIT 10;


SELECT
	player_name,
	team_name,
	triples
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY triples DESC
LIMIT 10;

SELECT 
	player_name,
	team_name,
	doubles
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY doubles DESC 
LIMIT 10;

SELECT
	player_name,
	team_name,
	stolen_bases
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY stolen_bases DESC
LIMIT 10;

SELECT
	player_name,
	team_name,
	stolen_bases
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY stolen_bases ASC
LIMIT 10;



SELECT
	player_name,
	team_name,
	total_bases
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY total_bases DESC
LIMIT 10;


SELECT
	player_name,
	team_name,
	total_bases
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY total_bases ASC
LIMIT 10;


SELECT
	player_name,
	team_name,
	rbi
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY rbi DESC
LIMIT 10;

SELECT
	player_name,
	team_name,
	rbi
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY rbi ASC
LIMIT 10;


SELECT
    team_name,
    ops,
    runs
FROM team_stats
WHERE ops > (
    SELECT AVG(ops)
    FROM team_stats
)
ORDER BY ops DESC;

SELECT
    team_name,
    runs
FROM team_stats
WHERE runs > (
    SELECT AVG(runs)
    FROM team_stats
)
ORDER BY runs DESC;

SELECT
    team_name,
    home_runs
FROM team_stats
WHERE home_runs > (
    SELECT AVG(home_runs)
    FROM team_stats
)
ORDER BY home_runs DESC;

SELECT
    team_name,
    stolen_bases
FROM team_stats
WHERE stolen_bases > (
    SELECT AVG(stolen_bases)
    FROM team_stats
)
ORDER BY stolen_bases DESC
LIMIT 10;

SELECT
    team_name,
    stolen_bases
FROM team_stats
WHERE stolen_bases > (
    SELECT AVG(stolen_bases)
    FROM team_stats
)
ORDER BY stolen_bases ASC
LIMIT 10;








SELECT
	player_name,
	team_name,
	ops
FROM batting_stats
WHERE ops > .800
	AND plate_appearances >= 200
	AND plate_appearances <= 400
ORDER BY ops DESC
LIMIT 10;

SELECT 
	division,
	AVG(runs) AS average_runs,
	AVG(ops) AS average_ops,
	AVG(home_runs) AS average_home_runs
FROM team_stats
GROUP BY division
ORDER BY average_ops DESC;

SELECT
    CASE
        WHEN age <= 25 THEN 'Young'
        WHEN age <= 30 THEN 'Prime'
        ELSE 'Veteran'
    END AS age_group,
    AVG(ops) AS average_ops,
    AVG(batting_average) AS average_batting_average,
    AVG(home_runs) AS average_home_runs
FROM batting_stats
WHERE plate_appearances >= 200
GROUP BY age_group
ORDER BY average_ops DESC;

SELECT
	player_name,
	era
FROM pitching_stats
WHERE innings_pitched >= 100
ORDER BY era ASC
LIMIT 10;

SELECT 
	player_name,
	strikeouts
FROM pitching_stats
WHERE innings_pitched >= 100
ORDER BY strikeouts DESC
LIMIT 10;

SELECT 
	player_name,
	whip
FROM pitching_stats
WHERE innings_pitched >= 100
ORDER BY whip ASC
LIMIT 10;

SELECT
	player_name,
	wins
FROM pitching_stats
ORDER BY wins DESC 
LIMIT 10;

SELECT
	player_name,
	strikeouts,
	innings_pitched,
	ROUND((strikeouts::NUMERIC / innings_pitched) * 9 AS kPer9)
FROM pitching_stats
WHERE innings_pitched >= 100
ORDER BY kPer9 DESC
LIMIT 10;

SELECT
	player_name,
	innings_pitched,
	ROUND((walks::NUMERIC / innings_pitched) * 9 AS bbPer9)
FROM pitching_stats
WHERE innings_pitched >= 100
ORDER BY bbPer9 ASC
LIMIT 10;

SELECT
    CASE
        WHEN games_started >= 10 THEN 'Starter'
        ELSE 'Reliever'
    END AS pitcher_type,
    AVG(era) AS average_era,
    AVG(whip) AS average_whip,
    AVG(strikeouts) AS average_strikeouts
FROM pitching_stats
GROUP BY pitcher_type;

SELECT
    player_name,
    innings_pitched,
    home_runs_allowed,
    ROUND((home_runs_allowed::NUMERIC / innings_pitched) * 9, 2) AS hr_per_9
FROM pitching_stats
WHERE innings_pitched >= 100
ORDER BY hr_per_9 ASC
LIMIT 10;

SELECT
    player_name,
    quality_starts,
    games_started,
    ROUND(
        (quality_starts::NUMERIC / NULLIF(games_started, 0)) * 100,
        1
    ) AS quality_start_percentage
FROM pitching_stats
WHERE games_started >= 10
ORDER BY quality_start_percentage DESC
LIMIT 10;

SELECT
    player_name,
    walks,
    plate_appearances,
    ROUND(
        (walks::NUMERIC / plate_appearances) * 100,
        1
    ) AS walk_percentage
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY walk_percentage DESC
LIMIT 10;


SELECT
    player_name,
    walks,
    plate_appearances,
    ROUND(
        (walks::NUMERIC / plate_appearances) * 100,
        1
    ) AS walk_percentage
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY walk_percentage ASC
LIMIT 10;

SELECT
    player_name,
    team_name,
    strikeouts,
    plate_appearances,
    ROUND(
        (strikeouts::NUMERIC / plate_appearances) * 100,
        1
    ) AS strikeout_percentage
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY strikeout_percentage ASC
LIMIT 10;

SELECT
    player_name,
    team_name,
    strikeouts,
    plate_appearances,
    ROUND(
        (strikeouts::NUMERIC / plate_appearances) * 100,
        1
    ) AS strikeout_percentage
FROM batting_stats
WHERE plate_appearances >= 400
ORDER BY strikeout_percentage DESC
LIMIT 10;

