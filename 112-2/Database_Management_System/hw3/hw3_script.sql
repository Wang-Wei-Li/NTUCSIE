/***** create and use database *****/
CREATE DATABASE EsportDB;
USE EsportDB;

/***** info *****/
CREATE TABLE self (
    StuID char(10) NOT NULL,
    Department varchar(10) NOT NULL,
    SchoolYear int DEFAULT 1,
    Name varchar(10) NOT NULL,
    PRIMARY KEY (StuID)
);

INSERT INTO self
VALUES ('r12922116', '資工所', 1, '王偉力');

SELECT DATABASE();
SELECT * FROM self;



/***** table creation and insertion *****/
CREATE TABLE TeamMember (
	register_id int AUTO_INCREMENT,
	TeamName varchar(40),
    PRIMARY KEY (register_id)
);

CREATE TABLE Coach (
	Name varchar(40) NOT NULL,
    Age int DEFAULT 0,
    Tenure int DEFAULT 0,
    register_id int,
    PRIMARY KEY (Name),
    CONSTRAINT catagory2 FOREIGN KEY (register_id) REFERENCES TeamMember(register_id)
);

CREATE TABLE Player (
    Name varchar(40) NOT NULL,
    Age int DEFAULT 0 CHECK (Age >= 0),
    is_paid enum('T', 'F'),
    LeaderName varchar(40) NULL,
    CoachName varchar(40) NULL,
    register_id int NULL,
    PRIMARY KEY (Name),
    CONSTRAINT leads FOREIGN KEY (LeaderName) REFERENCES Player(Name),
    CONSTRAINT coaches FOREIGN KEY (CoachName) REFERENCES Coach(Name),
    CONSTRAINT catagory1 FOREIGN KEY (register_id) REFERENCES TeamMember(register_id)
);

CREATE TABLE RecentAwards (
	PlayerName varchar(40) NOT NULL,
    GameName varchar(255) NOT NULL,
    Award varchar(255) NOT NULL,
    PRIMARY KEY (PlayerName, GameName, Award),
    FOREIGN KEY (PlayerName) REFERENCES Player(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Professional (
	PlayerName varchar(40) NOT NULL,
    Salary int DEFAULT 0 CHECK (Salary >= 0),
    PRIMARY KEY (PlayerName),
    FOREIGN KEY (PlayerName) REFERENCES Player(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ametuer (
	PlayerName varchar(40) NOT NULL,
    JobForALiving enum('sport-related job', 'other') DEFAULT 'other',
    PRIMARY KEY (PlayerName),
    FOREIGN KEY (PlayerName) REFERENCES Player(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PrizeMoney (
	GameName varchar(255) NOT NULL,
    PlayerName varchar(40) NOT NULL,
    PrizeMoney int DEFAULT 0 CHECK (PrizeMoney >= 0),
    PaymentMethod enum('Cash', 'Credit Card', 'iPass') DEFAULT 'Cash',
    PRIMARY KEY (GameName, PlayerName),
    CONSTRAINT earns FOREIGN KEY (PlayerName) REFERENCES Player(Name) ON DELETE CASCADE
);

CREATE TABLE Game (
    Name varchar(40) NOT NULL,
    Location_City varchar(40) DEFAULT 'Taipei',
    Location_Country varchar(40) DEFAULT 'Taiwan (ROC)',
    Date DATE,
    PRIMARY KEY (Name)
);

CREATE TABLE SponseredGame (
    GameName varchar(255) NOT NULL,
    Sponsership int DEFAULT 0,
    PRIMARY KEY (GameName),
    FOREIGN KEY (GameName) REFERENCES Game(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LiveBroadcastingGame (
    GameName varchar(255) NOT NULL,
    PRIMARY KEY (GameName),
    FOREIGN KEY (GameName) REFERENCES Game(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Broadcasters (
	GameName varchar(255) NOT NULL,
    Broadcasters_name varchar(40) NOT NULL,
    PRIMARY KEY (GameName, Broadcasters_name),
    FOREIGN KEY (GameName) REFERENCES LiveBroadcastingGame(GameName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE plays (
    PlayerName varchar(40) NOT NULL,
    GameName varchar(255) NOT NULL,
    PRIMARY KEY (PlayerName, GameName),
    FOREIGN KEY (PlayerName) REFERENCES Player(Name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (GameName) REFERENCES Game(Name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE directs (
	CoachName varchar(40) NOT NULL,
    GameName varchar(255) NOT NULL,
    PRIMARY KEY (CoachName, GameName),
    FOREIGN KEY (CoachName) REFERENCES Coach(Name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (GameName) REFERENCES Game(Name) ON DELETE CASCADE ON UPDATE CASCADE
);



INSERT INTO TeamMember (TeamName)
VALUES
('Team Fortress'),
('Team Fortress'),
('Team Fortress'),
('Team Lightening'),
('Team Killer'),
('Team Killer'),
('Team Killer');

INSERT INTO Coach (Name, Age, Tenure, register_id)
VALUES 
('Anna', 40, 10, 3),
('Brian', 35, 5, 5),
('Clara', 45, 15, NULL);

INSERT INTO Player (Name, Age, is_paid, LeaderName, CoachName, register_id) 
VALUES 
('Bob', 25, 'T', NULL, 'Anna', 1),
('Alice', 30, 'F', 'Bob', NULL, NULL),
('Charlie', 28, 'T', 'Bob', 'Anna', 2),
('Peter', 22, 'F', NULL, 'Brian', 7),
('Emily', 17, 'F', 'Peter', 'Brian', 6),
('Richard', 19, 'T', NULL, NULL, 4);

INSERT INTO RecentAwards (PlayerName, GameName, Award) 
VALUES
('Bob', 'League of Legend Winter Championship 2022', 'MVP'),
('Charlie', 'Monopoly Gamer Showcase 2022', 'Best Gamer'),
('Emily', 'League of Legend Ametuer Championship 2023', 'First Place'),
('Emily', 'League of Legend Ametuer Championship 2022', 'First Place'),
('Peter', 'Plants vs. Zombies Speedrun 2023', 'Bronze Medal');

INSERT INTO Professional (PlayerName, Salary)
VALUES
('Bob', 50000),
('Charlie', 45000),
('Richard', 30000);

INSERT INTO Ametuer (PlayerName, JobForALiving)
VALUES
('Alice', 'sport-related job'),
('Peter', 'sport-related job'),
('Emily', 'other');

INSERT INTO PrizeMoney (GameName, PlayerName, PrizeMoney, PaymentMethod) 
VALUES 
('Hearthstone Tournament 2019', 'Alice', 10000, 'Cash'),
('Hearthstone Tournament 2018', 'Alice', 20000, 'Cash'),
('League of Legend Winter Championship 2022', 'Bob', 6000, 'Credit Card'),
('Monopoly Gamer Showcase 2022', 'Charlie', 8000, 'iPass'),
('League of Legend Ametuer Championship 2023', 'Emily', 20000, 'Credit Card'),
('League of Legend Ametuer Championship 2022', 'Emily', 20000, 'Credit Card'),
('Plants vs. Zombies Speedrun 2023', 'Peter', 2500, 'iPass');

INSERT INTO Game (Name, Location_City, Location_Country, Date) 
VALUES
('Hearthstone Tournament 2024', 'New York', 'USA', '2024-05-01'),
('League of Legend Championship 2024', 'Berlin', 'Germany', '2024-06-01'),
('Maplestory who is the richest? 2024', 'Tokyo', 'Japan', '2024-07-01'),
('Call of Duty World Competition 2024', 'Sydney', 'Australia', '2024-08-31'),
('Plants vs. Zombies Classic Game 2024', 'Beijing', 'China', '2024-11-03'),
('Overwatch: The Last Game', 'Singapore', 'Singapore', '2024-12-27');

INSERT INTO SponseredGame (GameName, Sponsership) 
VALUES 
('League of Legend Championship 2024', 10000000),
('Maplestory who is the richest? 2024', 500000),
('Call of Duty World Competition 2024', 300000),
('Overwatch: The Last Game', 100000);

INSERT INTO LiveBroadcastingGame (GameName) 
VALUES 
('Hearthstone Tournament 2024'),
('League of Legend Championship 2024'),
('Call of Duty World Competition 2024');

INSERT INTO Broadcasters (GameName, Broadcasters_name) 
VALUES 
('Hearthstone Tournament 2024', 'ESPN'),
('League of Legend Championship 2024', 'Fox Sports'),
('League of Legend Championship 2024', 'NHK'),
('Call of Duty World Competition 2024', 'NHK');

INSERT INTO plays (PlayerName, GameName) 
VALUES 
('Alice', 'Hearthstone Tournament 2024'),
('Alice', 'League of Legend Championship 2024'), 
('Bob', 'Plants vs. Zombies Classic Game 2024'),
('Charlie', 'Call of Duty World Competition 2024'),
('Charlie', 'Overwatch: The Last Game'),
('Emily', 'League of Legend Championship 2024'),
('Richard', 'Maplestory who is the richest? 2024');

INSERT INTO directs (CoachName, GameName) 
VALUES
('Anna', 'Plants vs. Zombies Classic Game 2024'),
('Anna', 'Call of Duty World Competition 2024'),
('Brian', 'League of Legend Championship 2024');

/* Table for UNION, Intersect and Difference */
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES ROW(4,2), ROW(3,4);
CREATE TABLE t2 (a INT, b INT);
INSERT INTO t2 VALUES ROW(1,2), ROW(3,4);

/* Table for Advanced Problems */
CREATE TABLE student(ID INT, YEAR INT);
INSERT INTO student VALUES ROW(11, 3),
ROW(12,3), ROW(13,4), ROW(14,4) ;
CREATE TABLE staff(ID INT, RANKING INT);
INSERT INTO staff VALUES ROW(15,22),
ROW(16,23);

/***** homework 3 commands *****/

/* basic select */
SELECT *
FROM Player
WHERE NOT (Age < 20) AND (is_paid = 'T' OR LeaderName IS NOT NULL);

/* basic projection */
SELECT DISTINCT
	Name,
	is_paid, 
	CoachName
FROM Player
WHERE CoachName IS NOT NULL;

/* basic rename */
SELECT 
	Name, 
    Age, 
    is_paid AS Professional, 
    LeaderName AS Leader, 
    CoachName AS Coach, 
    register_id AS `ID No.`
FROM Player;

/* equijoin */
SELECT 
	p.Name AS Player,
	P.Age AS P_age,
	c.Name AS Coach, 
    c.Age AS C_age,
    c.Tenure AS C_tenure
FROM Player AS p, Coach AS c
WHERE p.CoachName = c.Name;

/* natural join */
SELECT *
FROM plays AS p
NATURAL JOIN directs AS d;

/* theta join */
SELECT 
	p.PlayerName AS Player,
	g.Name AS Game,
    g.Date
FROM plays AS p, Game AS g
WHERE (p.GameName = G.Name) AND (g.Date >= '2024-06-01')
ORDER BY Date;

/* three table join */
SELECT
    p.GameName AS Game, 
	p_er.Name AS Player,
	p_er.Age,
    g.Date
FROM Player AS p_er, plays AS p, Game AS g
WHERE p_er.Name = p.PlayerName AND p.GameName = g.Name
ORDER BY Date;

/* aggregate */
SELECT
	p.CoachName AS Coach,
	COUNT(p.Name) AS `Player Coached`,
    MAX(Age) AS `Oldest Player's Age`,
    MIN(Age) AS `Youngest Player's Age`
FROM Player AS p
WHERE p.CoachName IS NOT NULL
GROUP BY Coach;

/* aggregate 2 */
SELECT 
	p.LeaderName AS Leader,
    COUNT(*) AS `Number of Teammate`,
    SUM(pm.PrizeMoney) AS `Total Prize`,
    AVG(p.Age) AS `Teammate Avg. Age`
FROM Player AS p, PrizeMoney AS pm
WHERE p.Name = pm.PlayerName
GROUP BY p.LeaderName
HAVING Leader IS NOT NULL;

/* in */
SELECT *
FROM Player
WHERE register_id IN (2, 6, 7);

/* in 2 */
SELECT *
FROM Player
WHERE Name IN(
SELECT DISTINCT PlayerName
FROM plays);

/* correlated nested query */
SELECT *
FROM PrizeMoney AS pm
WHERE PlayerName IN(
SELECT DISTINCT PlayerName
FROM RecentAwards AS ra
WHERE pm.PlayerName = ra.PlayerName  AND pm.PrizeMoney >= 5000);

/* correlated nested query 2 */
SELECT *
FROM PrizeMoney AS pm
WHERE EXISTS(
SELECT *
FROM RecentAwards AS ra
WHERE pm.PlayerName = ra.PlayerName  AND pm.PrizeMoney >= 5000);

/* correlated nested query 3 */
SELECT *
FROM PrizeMoney AS pm
WHERE NOT EXISTS (
SELECT *
FROM RecentAwards AS ra
WHERE pm.PlayerName = ra.PlayerName  AND pm.PrizeMoney >= 5000);

/* UNION */
SELECT * FROM t1
UNION
SELECT * FROM t2;

/* Intersect */
SELECT *
FROM t1
WHERE EXISTS (
SELECT *
FROM t2
WHERE t1.a = t2.a AND t1.b = t2.b);

/* Difference */
SELECT *
FROM t1
WHERE NOT EXISTS (
SELECT *
FROM t2
WHERE t1.a = t2.a AND t1.b = t2.b);

/* Advanced 1 */
SELECT *
FROM student
NATURAL LEFT JOIN staff
UNION
SELECT
	sta.ID,
    stu.YEAR,
    sta.RANKING
FROM staff AS sta
NATURAL LEFT JOIN student AS stu;

/* Advanced 2 */
SELECT *
FROM staff
WHERE NOT EXISTS (
SELECT *
FROM student
WHERE staff.ID = student.ID);

/***** drop database *****/
DROP DATABASE EsportDB;
