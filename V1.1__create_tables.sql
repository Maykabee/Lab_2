DROP TABLE IF EXISTS Result_languages;
DROP TABLE IF EXISTS Result_another;
DROP TABLE IF EXISTS Entrant;
DROP TABLE IF EXISTS Educational_institution;
DROP TABLE IF EXISTS Location;



CREATE TABLE Location (
    locationID SERIAL PRIMARY KEY,
    TerTypeName VARCHAR(60),
    TerName VARCHAR(255),
    AreaName VARCHAR(255),
    RegName VARCHAR(255)
);


CREATE TABLE Educational_institution(
    EOName VARCHAR(255) PRIMARY KEY,
    EOTypeName VARCHAR(255),
    EOParent VARCHAR(255),
	locationID SERIAL REFERENCES Location(locationID)
);


CREATE TABLE Entrant (
    OutID VARCHAR(60) PRIMARY KEY,
	YEAR  INT,
    birth INT,
	SEXTYPENAME VARCHAR(255),
    REGTYPENAME VARCHAR(255),
    ClassProfileName VARCHAR(255),
    ClassLangName VARCHAR(255),
	locationID SERIAL REFERENCES Location(locationID),
    EOName VARCHAR(255) REFERENCES Educational_institution(EOName)
);


CREATE TABLE Result_languages (
    OutID VARCHAR(60) REFERENCES Entrant(OutID),
    NameTest VARCHAR(255),
    Year INT,
    TestStatus VARCHAR(255),
    Ball100 REAL,
    Ball12 REAL,
    DPALevel VARCHAR(255),
    Ball REAL,
    AdaptScale VARCHAR(20),
    PTName VARCHAR(255) REFERENCES Educational_institution(EOName),
    PRIMARY KEY(OutID, NameTest, Year)
);


CREATE TABLE Result_another (
    OutID VARCHAR(60) REFERENCES Entrant(OutID),
    NameTest VARCHAR(255),
    Year INT,
    TestStatus VARCHAR(255),
    Language VARCHAR(255),
    Ball100 REAL,
    Ball12 REAL,
    Ball REAL,
    PTName VARCHAR(255) REFERENCES Educational_institution(EOName),
    PRIMARY KEY(OutID, NameTest, Year)
);