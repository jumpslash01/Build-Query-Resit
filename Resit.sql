-- ZAKARY SMITH 
--                                          1. RELATIONAL SCHEMA
-- Tour (TourName, Descriotion)
--      PK(TourName)
-- Client (ClientID, Surname, GivenName, Gender)
--      PK (ClientID)
-- Event (TourName, EventYear, EventMonth, EventDay, Fee)
--      PK (TourName, EventYear, EventMonth, EventDay)
--      FK (TourName) REFERENCES Tour
-- Booking (ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
--      PK (ClientID, TourName, EventYear, EventMonth, EventDay) 
--      FK (TourName, EventYear, EventMonth, EventDay) REFERENCES EVENT
--      FK (ClientID) REFERENCES CLIENT

USE resit;

GO
--                                          TASK 2
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS [Event];
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Tour;


CREATE TABLE Tour
(
    TourName NVARCHAR (100),
    Descriotion NVARCHAR (500),
    PRIMARY KEY (TourName)
);

CREATE TABLE Client
(
    ClientId INT,
    Surname NVARCHAR(100),
    GivenName NVARCHAR(100),
    Gender NVARCHAR(1)
        PRIMARY KEY (ClientId)
);
CREATE TABLE [Event]
(
    TourName NVARCHAR (100),
    EventYear INT,
    EventMonth NVARCHAR(3),
    EventDay INT,
    Fee MONEY,
    PRIMARY KEY (TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY (TourName) REFERENCES Tour
)
CREATE TABLE Booking
(
    ClientId INT,
    TourName NVARCHAR (100),
    EventYear INT,
    EventMonth NVARCHAR(3),
    EventDay INT,
    Payment MONEY,
    DateBooked DATE,
    PRIMARY KEY (ClientID, TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY (ClientId) REFERENCES Client,
    FOREIGN KEY (TourName, EventYear, EventMonth, EventDay) REFERENCES [Event]
);

--                                          TASK 3


INSERT INTO Tour
    (TourName, Descriotion)
VALUES
    ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region'),
    ('South', 'Tour of wineries and outlets of Mornington Penisula'),
    ('West', 'Tour of wineries and outlets of the Geelong and Otways region');

INSERT INTO Client
    (ClientId, Surname, GivenName, Gender)
VALUES
    (1, 'Price', 'Taylor', 'M'),
    (2, 'Gamble', 'Ellyse', 'F'),
    (3, 'Tan', 'Tilly', 'F'),
    (6820492, 'Smith', 'Zakary', 'M');

INSERT INTO [Event]
    (TourName, EventMonth, EventDay, EventYear, Fee)
VALUES
    ('North', 'Jan', 9, 2016, 200),
    ('North', 'Feb', 13, 2016, 225),
    ('South', 'Jan', 9, 2016, 200),
    ('South', 'Jan', 16, 2016, 200),
    ('West', 'Jan', 29, 2016, 225);

INSERT INTO Booking
    (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
VALUES
    (1, 'North', 'Jan', 9, 2016, 200, '10/12/2015'),
    (2, 'North', 'Jan', 9, 2016, 200, '12-16-2015'),
    (1, 'North', 'Feb', 13, 2016, 225, '01-08-2016'),
    (2, 'North', 'Feb', 13, 2016, 125, '01-14-2016'),
    (3, 'North', 'Feb', 13, 2016, 225, '02-03-2016'),
    ( 1, 'South', 'Jan', 9, 2016, 200, '12-10-2015'),
    ( 2, 'South', 'Jan', 16, 2016, 200, '12-18-2015'),
    ( 3, 'South', 'Jan', 16, 2016, 200,'01-09-2016'),
    (2, 'West', 'Jan', 29, 2016, 225, '12-17-2015'),
    (3, 'West', 'Jan', 29, 2016, 200, '12-18-2015');


--                                          TASK 4

--4.1
SELECT C.GivenName, C.Surname, B.TourName, T.Descriotion, E.EventYear, E.EventMonth, E.EventDay, B.Payment FROM (((Client C
INNER JOIN Booking B ON B.ClientId = C.ClientId)
INNER JOIN Tour T ON T.TourName = B.TourName)
INNER JOIN [EVENT] E ON E.TourName = B.TourName AND E.EventMonth = B.EventMonth AND E.EventDay = B.EventDay);

--4.2
SELECT EventMonth, TourName, Count(*) AS NumBookings FROM Booking GROUP BY EventMonth, TourName;

--4.3
SELECT * FROM Booking WHERE Payment > (Select AVG(Payment) FROM Booking);

--                                          TASK 5

GO

CREATE VIEW VIEWTASK AS 
SELECT C.GivenName, C.Surname, B.TourName, T.Descriotion, E.EventYear, E.EventMonth, E.EventDay, B.Payment FROM (((Client C
INNER JOIN Booking B ON B.ClientId = C.ClientId)
INNER JOIN Tour T ON T.TourName = B.TourName)
INNER JOIN [EVENT] E ON E.TourName = B.TourName AND E.EventMonth = B.EventMonth AND E.EventDay = B.EventDay);

GO

--                                          TASK 6


Select Count(*) FROM VIEWTASK
--Q1 This View count verifies that the joined data contains no addionatal or removed cells as the number of rows counted is the same as the original bookings tabel

SELECT AVG(Payment) FROM Booking;
SELECT COUNT(*) FROM BOOKING WHERE PAYMENT <= 200;
--Q2 This Query shows us the average payment to be 200, where the orignial query is only reporting values over 200.
--Furthermore, the original query return 3 of the 10 values. When searching for values equal or under the average it returns 7 of the 10 values. This shows that no values are being left out. 
