/* create and use database */
CREATE DATABASE EsportDB;
USE EsportDB;

/* info */
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



/* create table */
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

CREATE TABLE Awards (
	PlayerName varchar(40) NOT NULL,
    Awards_name varchar(255) NOT NULL,
    PRIMARY KEY (PlayerName, Awards_name),
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



/* insert */
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

INSERT INTO Awards (PlayerName, Awards_name) 
VALUES 
('Alice', 'Hearthstone Tournament 2019 - Champion'),
('Alice', 'Hearthstone Tournament 2018 - Best Player'),
('Bob', 'League of Legend Winter Championship 2022 - MVP'),
('Charlie', 'Monopoly Gamer Showcase 2022 - Best Gamer');

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
('Monopoly Gamer Showcase 2022', 'Charlie', 8000, 'iPass');

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



/* create two views (Each view should be based on two tables.)*/
CREATE VIEW PrizeEarned AS
SELECT p.Name, p.Age, SUM(pm.PrizeMoney) AS TotalPrize
FROM Player AS p
JOIN PrizeMoney AS pm ON p.Name = pm.PlayerName
GROUP BY p.Name, p.Age;

CREATE VIEW SummerGamers AS
SELECT p.PlayerName, p.GameName, g.Date
FROM plays AS p
JOIN Game AS g ON p.GameName = g.Name
WHERE g.Date BETWEEN '2024-06-01' AND '2024-08-31';



/* select from all tables and views */
SELECT * FROM Player;
SELECT * FROM Awards;
SELECT * FROM Professional;
SELECT * FROM Ametuer;
SELECT * FROM PrizeMoney;
SELECT * FROM Coach;
SELECT * FROM TeamMember;
SELECT * FROM Game;
SELECT * FROM SponseredGame;
SELECT * FROM LiveBroadcastingGame;
SELECT * FROM Broadcasters;
SELECT * FROM plays;
SELECT * FROM directs;
SELECT * FROM PrizeEarned;
SELECT * FROM SummerGamers;



/* drop database */
DROP DATABASE EsportDB;