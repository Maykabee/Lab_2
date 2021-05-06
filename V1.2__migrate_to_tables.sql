-- заповнюємо таблицю Location даними з таблиці,створеної у кп1
INSERT INTO Location (TerName, AreaName, RegName)
SELECT        TerName,       AreaName,       RegName       FROM zno_2019_2020
UNION SELECT  EOTerName,     EOAreaName,     EORegName     FROM zno_2019_2020
UNION SELECT  ukrPTTerName,  ukrPTAreaName,  ukrPTRegName  FROM zno_2019_2020
UNION SELECT  mathPTTerName, mathPTAreaName, mathPTRegName FROM zno_2019_2020
UNION SELECT  histPTTerName, histPTAreaName, histPTRegName FROM zno_2019_2020
UNION SELECT  physPTTerName, physPTAreaName, physPTRegName FROM zno_2019_2020
UNION SELECT  chemPTTerName, chemPTAreaName, chemPTRegName FROM zno_2019_2020
UNION SELECT  bioPTTerName,  bioPTAreaName,  bioPTRegName  FROM zno_2019_2020
UNION SELECT  geoPTTerName,  geoPTAreaName,  geoPTRegName  FROM zno_2019_2020
UNION SELECT  engPTTerName,  engPTAreaName,  engPTRegName  FROM zno_2019_2020
UNION SELECT  fraPTTerName,  fraPTAreaName,  fraPTRegName  FROM zno_2019_2020
UNION SELECT  deuPTTerName,  deuPTAreaName,  deuPTRegName  FROM zno_2019_2020
UNION SELECT  spaPTTerName,  spaPTAreaName,  spaPTRegName  FROM zno_2019_2020
WHERE TerName IS NOT NULL;


UPDATE Location 
SET TerTypeName = zno_2019_2020.TerTypeName
FROM zno_2019_2020
WHERE (zno_2019_2020.TerName  = Location.TerName AND
      zno_2019_2020.AreaName = Location.AreaName AND
      zno_2019_2020.RegName  = Location.RegName) ;

UPDATE Location 
SET TerTypeName = zno_2019_2020.TerTypeName
FROM zno_2019_2020
WHERE zno_2019_2020.EOTerName  = Location.TerName AND
    zno_2019_2020.EOAreaName = Location.AreaName AND
    zno_2019_2020.EORegName  = Location.RegName;




-- заповнюємо таблицю Educational_institution даними з таблиці,створеної у кп1
INSERT INTO Educational_institution(EOName, EOTYPENAME, EOParent , locationID)
SELECT DISTINCT ON (EducInfo.InstitutionName)
	EducInfo.InstitutionName, 
	zno_2019_2020.EOTypeName, 
	zno_2019_2020.EOParent,
	Location.locationID
FROM (
    select distinct * 
    FROM (
        SELECT  EOName, EOTerName, EOAreaName, EORegName FROM zno_2019_2020
        UNION SELECT  ukrPTName,  ukrPTTerName,  ukrPTAreaName,  ukrPTRegName  FROM zno_2019_2020
        UNION SELECT  mathPTName, mathPTTerName, mathPTAreaName, mathPTRegName FROM zno_2019_2020
        UNION SELECT  histPTName, histPTTerName, histPTAreaName, histPTRegName FROM zno_2019_2020
        UNION SELECT  physPTName, physPTTerName, physPTAreaName, physPTRegName FROM zno_2019_2020
        UNION SELECT  chemPTName, chemPTTerName, chemPTAreaName, chemPTRegName FROM zno_2019_2020
        UNION SELECT  bioPTName,  bioPTTerName,  bioPTAreaName,  bioPTRegName  FROM zno_2019_2020
        UNION SELECT  geoPTName,  geoPTTerName,  geoPTAreaName,  geoPTRegName  FROM zno_2019_2020
        UNION SELECT  engPTName,  engPTTerName,  engPTAreaName,  engPTRegName  FROM zno_2019_2020
        UNION SELECT  fraPTName,  fraPTTerName,  fraPTAreaName,  fraPTRegName  FROM zno_2019_2020
        UNION SELECT  deuPTName,  deuPTTerName,  deuPTAreaName,  deuPTRegName  FROM zno_2019_2020
        UNION SELECT  spaPTName,  spaPTTerName,  spaPTAreaName,  spaPTRegName  FROM zno_2019_2020
    ) info
) AS EducInfo (InstitutionName, TerName, AreaName, RegName)
LEFT JOIN zno_2019_2020 ON 
	EducInfo.InstitutionName = zno_2019_2020.EOName
LEFT JOIN Location ON
	EducInfo.TerName = Location.TerName AND
	EducInfo.AreaName = Location.AreaName AND
	EducInfo.RegName = Location.RegName
WHERE EducInfo.InstitutionName IS NOT NULL;




-- заповнюємо таблицю Entrant даними з таблиці,створеної у кп1
INSERT INTO Entrant (OutID,YEAR, birth, SEXTYPENAME, REGTYPENAME, 
					 ClassProfileName, ClassLangName, locationID, EOName)
SELECT DISTINCT ON (OutID) OutID, YEAR, birth, SEXTYPENAME, REGTYPENAME, 
					 ClassProfileName, ClassLangName, locationID, EOName
FROM zno_2019_2020
INNER JOIN Location
ON zno_2019_2020.TerTypeName = Location.TerTypeName
    AND zno_2019_2020.TerName = Location.TerName
    AND zno_2019_2020.AreaName = Location.AreaName
    AND zno_2019_2020.RegName = Location.RegName;




-- заповнюємо таблицю Result_languages даними з таблиці,створеної у кп1
INSERT INTO Result_languages (OutID, NameTest, Year, TestStatus,
     Ball100, Ball12, Ball, AdaptScale, PTName)
SELECT OutID, ukrTest, Year, ukrTestStatus, 
       ukrBall100, ukrBall12, ukrBall, ukrAdaptScale, UkrPTName
FROM zno_2019_2020
WHERE ukrTest IS NOT NULL;


INSERT INTO Result_languages (OutID, NameTest, Year, TestStatus,
     Ball100, Ball12, DPALevel, Ball, PTName)
SELECT OutID, engTest, Year, engTestStatus, 
       engBall100, engBall12, engDPALevel ,engBall, engPTName
FROM zno_2019_2020
WHERE engTest IS NOT NULL;


INSERT INTO Result_languages (OutID, NameTest, Year, TestStatus,
     Ball100, Ball12, DPALevel, Ball, PTName)
SELECT OutID, fraTest, Year, fraTestStatus, 
       fraBall100, fraBall12, fraDPALevel ,fraBall, fraPTName
FROM zno_2019_2020
WHERE fraTest IS NOT NULL;


INSERT INTO Result_languages (OutID, NameTest, Year, TestStatus,
     Ball100, Ball12, DPALevel, Ball, PTName)
SELECT OutID, deuTest, Year, deuTestStatus, 
       deuBall100, deuBall12, deuDPALevel ,deuBall, deuPTName
FROM zno_2019_2020
WHERE deuTest IS NOT NULL;


INSERT INTO Result_languages (OutID, NameTest, Year, TestStatus,
     Ball100, Ball12, DPALevel, Ball, PTName)
SELECT OutID, spaTest, Year, spaTestStatus, 
       spaBall100, spaBall12, spaDPALevel ,spaBall, spaPTName
FROM zno_2019_2020
WHERE spaTest IS NOT NULL;


-- заповнюємо таблицю Result_another даними з таблиці,створеної у кп1
INSERT INTO Result_another (OutID, NameTest, Year, TestStatus, Language,
							Ball100, Ball12, Ball,  PTName)
SELECT OutID, histTest, Year,  histTestStatus,histLang, 
    histBall100, histBall12, histBall, histPTName
FROM zno_2019_2020
WHERE histTest IS NOT NULL;


INSERT INTO Result_another (OutID, NameTest, Year, TestStatus, Language,
							Ball100, Ball12, Ball,  PTName)
SELECT OutID, mathTest, Year, mathTestStatus, mathLang, 
    mathBall100, mathBall12, mathBall, mathPTName
FROM zno_2019_2020
WHERE mathTest IS NOT NULL;


INSERT INTO Result_another (OutID, NameTest, Year, TestStatus, Language,
							Ball100, Ball12, Ball,  PTName)
SELECT OutID, physTest, Year, physTestStatus,physLang, 
    physBall100, physBall12, physBall, physPTName
FROM zno_2019_2020
WHERE physTest IS NOT NULL;


INSERT INTO Result_another (OutID, NameTest, Year, TestStatus, Language,
							Ball100, Ball12, Ball,  PTName)
SELECT OutID, chemTest, Year, chemTestStatus, chemLang, 
    chemBall100, chemBall12, chemBall, chemPTName
FROM zno_2019_2020
WHERE chemTest IS NOT NULL;


INSERT INTO Result_another (OutID, NameTest, Year, TestStatus, Language,
							Ball100, Ball12, Ball,  PTName)
SELECT OutID, bioTest, Year,  bioTestStatus, bioLang, 
    bioBall100, bioBall12, bioBall, bioPTName
FROM zno_2019_2020
WHERE bioTest IS NOT NULL;


INSERT INTO Result_another (OutID, NameTest, Year, TestStatus, Language,
							Ball100, Ball12, Ball,  PTName)
SELECT OutID, geoTest, Year,  geoTestStatus, geoLang, 
    geoBall100, geoBall12, geoBall, geoPTName
FROM zno_2019_2020
WHERE geoTest IS NOT NULL;