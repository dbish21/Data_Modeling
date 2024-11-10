CREATE TABLE Regions (
    RegionID SERIAL PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    PhoneNumber VARCHAR(20),
    PreferredRegionID INT,
    FOREIGN KEY (PreferredRegionID) REFERENCES Regions(RegionID)
);

CREATE TABLE Categories (
    CategoryID SERIAL PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Posts (
    PostID SERIAL PRIMARY KEY,
    Title VARCHAR(255),
    Text TEXT,
    UserID INT,
    Location VARCHAR(255),
    RegionID INT,
    PostDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

CREATE TABLE PostCategories (
    PostID INT,
    CategoryID INT,
    PRIMARY KEY (PostID, CategoryID),
    FOREIGN KEY (PostID) REFERENCES Posts(PostID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
