CREATE TABLE Seasons (
    SeasonID SERIAL PRIMARY KEY,
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE Teams (
    TeamID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    City VARCHAR(255)
);

CREATE TABLE Players (
    PlayerID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Position VARCHAR(50),
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

CREATE TABLE Matches (
    MatchID SERIAL PRIMARY KEY,
    HomeTeamID INT,
    AwayTeamID INT,
    MatchDate DATE,
    SeasonID INT,
    HomeTeamScore INT,
    AwayTeamScore INT,
    FOREIGN KEY (HomeTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (AwayTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (SeasonID) REFERENCES Seasons(SeasonID)
);

CREATE TABLE Referees (
    RefereeID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    CertificationLevel VARCHAR(50)
);

CREATE TABLE MatchReferees (
    MatchID INT,
    RefereeID INT,
    PRIMARY KEY (MatchID, RefereeID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (RefereeID) REFERENCES Referees(RefereeID)
);

CREATE TABLE Goals (
    GoalID SERIAL PRIMARY KEY,
    MatchID INT,
    PlayerID INT,
    MinuteScored INT,
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

CREATE VIEW Standings AS
SELECT 
    Teams.TeamID,
    SUM(CASE WHEN Matches.HomeTeamID = Teams.TeamID AND Matches.HomeTeamScore > Matches.AwayTeamScore THEN 1 ELSE 0 END +
        CASE WHEN Matches.AwayTeamID = Teams.TeamID AND Matches.AwayTeamScore > Matches.HomeTeamScore THEN 1 ELSE 0 END) AS Wins,
    SUM(CASE WHEN Matches.HomeTeamID = Teams.TeamID AND Matches.HomeTeamScore < Matches.AwayTeamScore THEN 1 ELSE 0 END +
        CASE WHEN Matches.AwayTeamID = Teams.TeamID AND Matches.AwayTeamScore < Matches.HomeTeamScore THEN 1 ELSE 0 END) AS Losses,
    SUM(CASE WHEN Matches.HomeTeamID = Teams.TeamID AND Matches.HomeTeamScore = Matches.AwayTeamScore THEN 1 ELSE 0 END +
        CASE WHEN Matches.AwayTeamID = Teams.TeamID AND Matches.AwayTeamScore = Matches.HomeTeamScore THEN 1 ELSE 0 END) AS Draws
FROM Teams
LEFT JOIN Matches ON Matches.HomeTeamID = Teams.TeamID OR Matches.AwayTeamID = Teams.TeamID
GROUP BY Teams.TeamID;
