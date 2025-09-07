# Sports_Tournament_Tracker_SQL_Project


##  Overview

This project is a relational database system built using **MySQL Workbench** to track and analyze sports tournament data. It includes tables for teams, players, matches, and individual player stats. The goal was to create a clean, scalable structure that could simulate real-world match scenarios and generate useful insights like match summaries, player leaderboards, and team rankings.

---

##  Objectives

- Design a normalized schema for storing tournament data  
- Insert realistic sample data for teams, players, and matches  
- Write SQL queries to analyze match results and player performance  
- Create views for leaderboards and team points  
- Use CTEs to calculate average player stats  


---

##  Tools Used

- **MySQL Workbench** – for schema design, query writing, and testing  
- **SQL** – used for table creation, data manipulation, and analysis  


---

##  Schema Design

The database includes four main tables:

- `teams` – stores team name, coach, and city  
- `players` – links each player to a team and defines their position  
- `matches` – records match date, teams involved, and scores  
- `stats` – tracks goals, assists, and minutes played by each player in each match



---


##  Views Created

- `top_scorers` – leaderboard of players by goals  
- `team_points` – points table based on match outcomes  
- `team_performance_report` – summary of team stats across matches

---

##  Conclusion

This project helped me practice real-world SQL skills—from designing a clean schema to writing advanced queries and generating reports. It’s flexible enough to be extended with features like tournament stages, penalties, or player transfers. I’m including this in my portfolio to showcase my backend and data-handling capabilities.

---
