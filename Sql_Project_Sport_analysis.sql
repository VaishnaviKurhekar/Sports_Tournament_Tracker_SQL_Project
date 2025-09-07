-- SQL PROJECT- Sports Tournament Tracker

-- Objective: Manage match results and player statistics.

-- Tools: MySQL Workbench

-- Create Databse
CREATE DATABASE sql_Project_p1;
USE sql_Project_p1;

-- Create TABLES: teams, players, matches, and stats.

-- Teams Table
CREATE TABLE teams (
  team_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  coach VARCHAR(100),
  city VARCHAR(100)
);

-- Players Table
CREATE TABLE players (
  player_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  team_id INT,
  position VARCHAR(50),
  FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- Matches Table
CREATE TABLE matches (
  match_id INT AUTO_INCREMENT PRIMARY KEY,
  team1_id INT,
  team2_id INT,
  match_date DATE,
  team1_score INT,
  team2_score INT,
  FOREIGN KEY (team1_id) REFERENCES teams(team_id),
  FOREIGN KEY (team2_id) REFERENCES teams(team_id)
);

-- Stats Table
CREATE TABLE stats (
  stat_id INT AUTO_INCREMENT PRIMARY KEY,
  match_id INT,
  player_id INT,
  goals INT DEFAULT 0,
  assists INT DEFAULT 0,
  minutes_played INT,
  FOREIGN KEY (match_id) REFERENCES matches(match_id),
  FOREIGN KEY (player_id) REFERENCES players(player_id)
);
 --  Insert Data into Tables
 -- Teams
INSERT INTO teams (name, coach, city) VALUES
('Falcons', 'Amit Rao', 'Mumbai'),
('Warriors', 'Neha Singh', 'Delhi');
INSERT INTO teams (name, coach, city) VALUES
('Titans', 'Rohit Desai', 'Bangalore'),
('Strikers', 'Meera Iyer', 'Chennai'),
('Blazers', 'Anil Kapoor', 'Hyderabad');

-- Players
INSERT INTO players (name, team_id, position) VALUES
('Ravi Kumar', 1, 'Forward'),
('Arjun Mehta', 1, 'Midfielder'),
('Karan Joshi', 2, 'Forward'),
('Sahil Verma', 2, 'Defender');
INSERT INTO players (name, team_id, position) VALUES
('Manish Reddy', 3, 'Forward'),
('Vikram Shah', 3, 'Goalkeeper'),
('Devika Nair', 4, 'Midfielder'),
('Rohan Bhatia', 4, 'Defender'),
('Sneha Kulkarni', 5, 'Forward'),
('Aditya Menon', 5, 'Midfielder');


-- Matches
INSERT INTO matches (team1_id, team2_id, match_date, team1_score, team2_score) VALUES
(1, 2, '2025-08-15', 3, 2);
INSERT INTO matches (team1_id, team2_id, match_date, team1_score, team2_score) VALUES
(3, 4, '2025-08-20', 1, 1),
(2, 5, '2025-08-22', 2, 3),
(1, 3, '2025-08-25', 0, 2),
(4, 5, '2025-08-27', 1, 1);
-- Stats
INSERT INTO stats (match_id, player_id, goals, assists, minutes_played) VALUES
(1, 1, 2, 1, 90),
(1, 2, 1, 0, 85),
(1, 3, 2, 0, 90),
(1, 4, 0, 1, 80);
-- Match 2 (Titans vs Strikers)
INSERT INTO stats (match_id, player_id, goals, assists, minutes_played) VALUES
(2, 5, 1, 0, 90),
(2, 6, 0, 1, 90),
(2, 7, 1, 0, 85),
(2, 8, 0, 1, 80);

-- Match 3 (Warriors vs Blazers)
INSERT INTO stats (match_id, player_id, goals, assists, minutes_played) VALUES
(3, 9, 2, 1, 90),
(3, 10, 1, 0, 88),
(3, 3, 1, 0, 90),
(3, 4, 1, 1, 85);

-- Match 4 (Falcons vs Titans)
INSERT INTO stats (match_id, player_id, goals, assists, minutes_played) VALUES
(4, 1, 0, 0, 90),
(4, 2, 0, 0, 85),
(4, 5, 1, 0, 90),
(4, 6, 1, 1, 88);

-- Match 5 (Strikers vs Blazers)
INSERT INTO stats (match_id, player_id, goals, assists, minutes_played) VALUES
(5, 7, 1, 0, 90),
(5, 8, 0, 1, 85),
(5, 9, 1, 0, 90),
(5, 10, 0, 1, 88);




SELECT * From teams;
SELECT * From players;
SELECT * From matches;
SELECT * From stats;

-- 1.Create schema: Teams, Players, Matches, Stats.
-- 2.Insert sample tournament data.
-- 3.Write queries for match results, player scores.
-- 4.Create views for leaderboards and points tables.
-- 5.Use CTE for average player performance.
-- 6.Export team performance reports.
-- Queries on  Basic Match Summary

-- Q: What were the scores and participating teams for each match?
SELECT 
  m.match_id,
  t1.name AS team1,
  t2.name AS team2,
  m.match_date,
  m.team1_score,
  m.team2_score
FROM matches m
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id;

-- Q: Which team won each match?
SELECT 
  m.match_id,
  CASE 
    WHEN m.team1_score > m.team2_score THEN t1.name
    WHEN m.team2_score > m.team1_score THEN t2.name
    ELSE 'Draw'
  END AS winner,
  m.match_date
FROM matches m
JOIN teams t1 ON m.team1_id = t1.team_id
JOIN teams t2 ON m.team2_id = t2.team_id;
-- Team-wise Match Performance
SELECT 
  t.name AS team,
  COUNT(m.match_id) AS matches_played,
  SUM(
    CASE 
      WHEN t.team_id = m.team1_id THEN m.team1_score
      WHEN t.team_id = m.team2_id THEN m.team2_score
      ELSE 0
    END
  ) AS total_goals_scored
FROM teams t
LEFT JOIN matches m ON t.team_id IN (m.team1_id, m.team2_id)
GROUP BY t.team_id;
--  Player Performance Queries
-- Top Goal Scorers
SELECT 
  p.name AS player_name,
  t.name AS team,
  SUM(s.goals) AS total_goals
FROM stats s
JOIN players p ON s.player_id = p.player_id
JOIN teams t ON p.team_id = t.team_id
GROUP BY p.player_id
ORDER BY total_goals DESC;

--  Player Stats in a Specific Match

SELECT 
  p.name AS player,
  t.name AS team,
  s.goals,
  s.assists,
  s.minutes_played
FROM stats s
JOIN players p ON s.player_id = p.player_id
JOIN teams t ON p.team_id = t.team_id
WHERE s.match_id = 3;

-- Average Player Performance (CTE)

WITH player_avg AS (
  SELECT 
    p.name,
    AVG(s.goals) AS avg_goals,
    AVG(s.assists) AS avg_assists,
    AVG(s.minutes_played) AS avg_minutes
  FROM stats s
  JOIN players p ON s.player_id = p.player_id
  GROUP BY p.player_id
)
SELECT * FROM player_avg ORDER BY avg_goals DESC;

-- Team performance queries
-- Most Matches Played by Team
SELECT 
  t.name AS team,
  COUNT(m.match_id) AS matches_played
FROM teams t
LEFT JOIN matches m ON t.team_id IN (m.team1_id, m.team2_id)
GROUP BY t.team_id
ORDER BY matches_played DESC;
-- Team Points Table (Win = 3, Draw = 1, Loss = 0)

SELECT 
  t.name AS team,
  SUM(
    CASE 
      WHEN t.team_id = m.team1_id AND m.team1_score > m.team2_score THEN 3
      WHEN t.team_id = m.team2_id AND m.team2_score > m.team1_score THEN 3
      WHEN m.team1_score = m.team2_score AND (t.team_id = m.team1_id OR t.team_id = m.team2_id) THEN 1
      ELSE 0
    END
  ) AS points
FROM teams t
LEFT JOIN matches m ON t.team_id IN (m.team1_id, m.team2_id)
GROUP BY t.team_id
ORDER BY points DESC;