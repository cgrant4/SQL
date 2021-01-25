--Business Transaction 1 -What are the Top ten Events with highest  Major Propsects ?
SELECT distinct  top 10 e.eveName,max(A.majorProspects) as 'MaxMajorProspects' 
FROM [TerpAlum.Attendance] A,[TerpAlum.Event] e
where e.eveName= A.eveName
GROUP BY e.eveName
ORDER BY max(A.majorProspects) DESC 

--Business Transaction 2 - What are the Top Ten Events with highest Number of First Time Attendees ?
SELECT distinct  top 10 e.eveName,max(A.firstTimeAttendees) as 'MaxFirstTimeAttendees' 
FROM [TerpAlum.Attendance] A,[TerpAlum.Event] e
where e.eveName= A.eveName
GROUP BY e.eveName
ORDER BY max(A.firstTimeAttendees) DESC 

--Business Transaction 3 - What are the highest  Major Propsects ,particpants ,First Time Attendees across years ?
SELECT max(A.majorProspects) as 'TotalMajorProspects' ,
DATEPART(YYYY,e.eveDate) as Year 
FROM [TerpAlum.Attendance] A ,[TerpAlum.Event] e
where e.eveDate= A.eveDate
GROUP BY DATEPART(YYYY,e.eveDate)


-- Business Transaction 4 What are highest Sum of Prospects versus highest First Time attendees across Week Days ?
SELECT max(firstTimeAttendees) as 'TotalFirstTimeAttendees' ,
max(majorProspects) as 'TotalMajorPropsects' ,
DATEPART(WEEKDAY,e.eveDate) as WeekDay
FROM [TerpAlum.Attendance] A ,[TerpAlum.Event] e
where e.eveDate= A.eveDate
GROUP BY DATEPART(WEEKDAY,e.eveDate)
ORDER BY DATEPART(WEEKDAY,e.eveDate)

--- Business Transaction 5  What are the Top 5 locations with the highest number of Major Gift propsects ?
SELECT distinct  top 5 l.locCode,l.locDescription,sum(A.majorProspects) as 'majorProspects' 
FROM [TerpAlum.Attendance] A,[TerpAlum.Location] l
where l.locCode= A.locCode
GROUP BY l.locCode,l.locDescription
ORDER BY sum(A.majorProspects) DESC 

-- Business Transaction 6  What are the total number of First Time attendees from Participnta for top 10 locations and top 10 events ?
SELECT distinct  top 10 l.locCode,e.eveName,max(A.firstTimeAttendees) as 'MaxFirstTimeAttendees' 
FROM [TerpAlum.Attendance] A,[TerpAlum.Event] e,[TerpAlum.Location] l
where e.eveName= A.eveName AND l.locCode=A.locCode 
GROUP BY e.eveName,l.locCode
ORDER BY max(A.firstTimeAttendees) DESC 

-- Business Transaction 7 What are the highest  sum of prospects versus Total First Time Attendees across Months ?
SELECT max(A.firstTimeAttendees) as 'MaxFirstTimeAttendees' ,
max(A.majorProspects) as 'MaxMajorPropsects' ,
DATEPART(MONTH,e.eveDate) as Month
FROM [TerpAlum.Attendance] A , [TerpAlum.Event] e
where e.eveDate=A.eveDate
GROUP BY DATEPART(MONTH,e.eveDate)
ORDER  BY DATEPART(MONTH,e.eveDate)

-- Business Transaction 8 WHat is the correlation ofthe Average age with respect to the Major Prospects and First Time Attendees ?

SELECT SUM(firstTimeAttendees) AS 'FirstTimeAttendees',SUM(majorProspects) AS 'MajorProspects',
avgAge FROM [TerpAlum.Attendance]
GROUP BY avgAge


--------------------------------

-- Queries for Inserting ,Creating and Deleting the tables in the database 

DROP TABLE [TerpAlum.Attendance]
DROP TABLE [TerpAlum.Activity]
DROP TABLE [TerpAlum.Group]
DROP TABLE [TerpAlum.Location]
DROP TABLE [TerpAlum.Event]

CREATE TABLE [TerpAlum.Group]
(grpCode CHAR(3) NOT NULL,
 grpDescription VARCHAR(20),
CONSTRAINT pk_Group_grpCode PRIMARY KEY (grpCode)
)

CREATE TABLE [TerpAlum.Activity]
(actCode CHAR (5),
 actDescription VARCHAR(40),
CONSTRAINT pk_Activity_actCode PRIMARY KEY (actCode)
)

CREATE TABLE [TerpAlum.Location]
(locCode CHAR(4) NOT NULL,
 locDescription VARCHAR(40),
CONSTRAINT pk_Location_locCode PRIMARY KEY (locCode)
)

CREATE TABLE [TerpAlum.Event]
(eveName VARCHAR(100) NOT NULL,
 eveDate DATE NOT NULL,
CONSTRAINT pk_Event_eveName_eveDate PRIMARY KEY (eveName, eveDate)
)

CREATE TABLE [TerpAlum.Attendance](
grpCode CHAR(3) NOT NULL,
actCode CHAR(5) NOT NULL,
locCode CHAR(4) NOT NULL,
eveName VARCHAR(100) NOT NULL,
eveDate DATE,
numOfParticipants INTEGER,
avgAge INTEGER, 
firstTimeAttendees INTEGER, 
majorProspects INTEGER, 
CONSTRAINT pk_Attendance_grpCode_actCode_eveName_eveDate PRIMARY KEY (grpCode,actCode,eveName,eveDate),
CONSTRAINT fk_Attendance_grpCode FOREIGN KEY(grpCode)
	REFERENCES [TerpAlum.Group](grpCode) 
	ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_Attendance_actCode FOREIGN KEY(actCode)
	REFERENCES [TerpAlum.Activity](actCode)
	ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_Attendance_eveName_eveDate FOREIGN KEY(eveName, eveDate)
	REFERENCES [TerpAlum.Event] (eveName, eveDate)
	ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_Attendance_locCode FOREIGN KEY(locCode)
	REFERENCES [TerpAlum.Location] (locCode)
	ON DELETE NO ACTION ON UPDATE CASCADE)
