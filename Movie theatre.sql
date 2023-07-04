CREATE DATABASE Theatre;
USE Theatre;

CREATE TABLE Movie(
movie_ID VARCHAR(6) NOT NULL,
movie_title VARCHAR(20) NOT NULL,
movie_director VARCHAR(20) NOT NULL,
movie_length INT NOT NULL,
movie_genre VARCHAR(7) NOT NULL,
PRIMARY KEY(movie_ID)
);
SELECT * FROM Movie;
DESC Movie;
SELECT * FROM Movie;

INSERT INTO Movie VALUES('M1','RRR','SS RAJAMOULI','189','DRAMA');
INSERT INTO Movie VALUES('M2','BHEEMLA NAYAK','SAGAR K CHANDRA','178','ACTION');
INSERT INTO Movie VALUES('M3','MIRCHI','KORATALA SIVA','180','FAMILY');
INSERT INTO Movie VALUES('M4','DARLING','KARUNAKARAN','175','LOVE');
INSERT INTO Movie VALUES('M5','ROBO','SHANKAR','173','SCIFI');


CREATE TABLE Hall(
hall_ID VARCHAR(6) NOT NULL,
no_of_seats INT NOT NULL,
hall_name VARCHAR(10) NOT NULL,
PRIMARY KEY(hall_ID)
);
SELECT * FROM Hall;
DESC Hall;
SELECT * FROM Hall;

INSERT INTO Hall VALUES('H1','5','Platinum');
INSERT INTO Hall VALUES('H2','6','Gold');
INSERT INTO Hall VALUES('H3','7','Silver');


CREATE TABLE People(
people_ID VARCHAR(6) NOT NULL,
NAME VARCHAR(20) NOT NULL,
Age INT NOT NULL,
phone_number CHAR(10) NOT NULL,
PRIMARY KEY(people_ID)
);
SELECT * FROM People;
DESC People;
SELECT * FROM People;

INSERT INTO People VALUES('P1','Dhruva','20','7995556100');
INSERT INTO People VALUES('P2','Tanuja','16','7995129576');
INSERT INTO People VALUES('P3','Rishi','17','8977703366');
INSERT INTO People VALUES('P4','Tony','19','9390254779');
INSERT INTO People VALUES('P5','Likhith','18','9908087704');
INSERT INTO People VALUES('P6','Bharath','17','6305677735');


CREATE TABLE Screening(
screening_ID VARCHAR(6) NOT NULL,
movie_ID VARCHAR(6) NOT NULL,
hall_ID VARCHAR(6) NOT NULL,
screen_time TIME NOT NULL,
screen_date DATE NOT NULL,
PRIMARY KEY(screening_ID),
FOREIGN KEY (movie_ID) REFERENCES Movie(movie_ID),
FOREIGN KEY (hall_ID) REFERENCES Hall(hall_ID)
);
SELECT * FROM Screening;
DESC Screening;
SELECT * FROM Screening;

INSERT INTO Screening VALUES('SCR1','M1','H2','17:35:00','2019-10-05');
INSERT INTO Screening VALUES('SCR2','M4','H1','18:40:00','2019-10-05');
INSERT INTO Screening VALUES('SCR3','M3','H2','13:20:00','2019-10-06');
INSERT INTO Screening VALUES('SCR4','M2','H3','17:35:00','2019-10-06');
INSERT INTO Screening VALUES('SCR5','M1','H2','11:00:00','2019-10-07');

CREATE TABLE Seat(
seat_ID VARCHAR(6) NOT NULL,
seat_number INT NOT NULL,
seat_row CHAR(6) NOT NULL,
hall_ID VARCHAR(6) NOT NULL,
PRIMARY KEY(seat_ID),
FOREIGN KEY (hall_ID) REFERENCES Hall(hall_ID)
);
SELECT * FROM Seat;
DESC Seat;
SELECT * FROM Seat;

INSERT INTO Seat VALUES('H1S1','2','B','H1');
INSERT INTO Seat VALUES('H1S2','1','A','H1');
INSERT INTO Seat VALUES('H1S3','3','C','H1');
INSERT INTO Seat VALUES('H1S4','2','D','H1');
INSERT INTO Seat VALUES('H1S5','5','A','H1');
INSERT INTO Seat VALUES('H2S1','4','B','H2');
INSERT INTO Seat VALUES('H2S2','7','B','H2');
INSERT INTO Seat VALUES('H2S3','8','C','H2');
INSERT INTO Seat VALUES('H2S4','3','R','H2');
INSERT INTO Seat VALUES('H2S5','5','A','H2');
INSERT INTO Seat VALUES('H2S6','9','C','H2');
INSERT INTO Seat VALUES('H3S1','6','R','H3');
INSERT INTO Seat VALUES('H3S2','7','R','H3');
INSERT INTO Seat VALUES('H3S3','1','A','H3');
INSERT INTO Seat VALUES('H3S4','9','A','H3');
INSERT INTO Seat VALUES('H3S5','6','C','H3');
INSERT INTO Seat VALUES('H3S6','2','B','H3');
INSERT INTO Seat VALUES('H3S7','4','R','H3');

CREATE TABLE Booking(
booking_ID VARCHAR(6) NOT NULL,
price INT NOT NULL,
screening_ID VARCHAR(6) NOT NULL,
people_ID VARCHAR(6) NOT NULL,
PRIMARY KEY(booking_ID),
FOREIGN KEY (screening_ID) REFERENCES Screening(screening_ID),
FOREIGN KEY (people_ID) REFERENCES People(people_ID)
);
SELECT * FROM Booking;
DESC Booking;
SELECT * FROM Booking;

INSERT INTO Booking VALUES('B1','120','SCR1','P5');
INSERT INTO Booking VALUES('B2','150','SCR4','P1');
INSERT INTO Booking VALUES('B3','145','SCR3','P4');
INSERT INTO Booking VALUES('B4','100','SCR2','P2');
INSERT INTO Booking VALUES('B5','150','SCR4','P3');
INSERT INTO Booking VALUES('B6','160','SCR3','P6');


CREATE TABLE Seat_Reserverd(
seat_Reserv_ID VARCHAR(6) NOT NULL,
screening_ID VARCHAR(6) NOT NULL,
seat_ID VARCHAR(6) NOT NULL,
booking_ID VARCHAR(6) NOT NULL,
PRIMARY KEY(seat_Reserv_ID),
FOREIGN KEY (screening_ID) REFERENCES Screening(screening_ID),
FOREIGN KEY (seat_ID) REFERENCES Seat(seat_ID),
FOREIGN KEY (booking_ID) REFERENCES Booking(booking_ID)
);
SELECT * FROM Seat_Reserverd;
DESC Seat_Reserverd;
SELECT * FROM Seat_Reserverd;

INSERT INTO Seat_Reserverd VALUES('SR1','SCR1','H3S3','B1');
INSERT INTO Seat_Reserverd VALUES('SR2','SCR4','H1S2','B2');
INSERT INTO Seat_Reserverd VALUES('SR3','SCR3','H2S1','B3');
INSERT INTO Seat_Reserverd VALUES('SR4','SCR2','H3S3','B4');
INSERT INTO Seat_Reserverd VALUES('SR5','SCR4','H1S1','B5');
INSERT INTO Seat_Reserverd VALUES('SR6','SCR3','H2S2','B6');


#QUERIES:

#1.Which movies are screened on 2019-10-06?
SELECT movie_title, movie_director, movie_length, movie_genre, hall_ID 
FROM Movie
INNER JOIN Screening
ON Screening.movie_ID = Movie.movie_ID
WHERE screen_date = "2019-10-06";

#2.Show seat map of hall Royal?
SELECT seat_ID, seat_row, seat_number
FROM Seat
INNER JOIN Hall
ON Seat.hall_ID = Hall.hall_ID
WHERE hall_name = "Silver";

#3.Show the date, time and hall when the film “RRR” will be screened
SELECT movie_title, hall_ID, screen_date, screen_time
FROM Screening
INNER JOIN Movie
ON Screening.movie_ID = Movie.movie_ID WHERE movie_title = "RRR";

#4.Show all the details of people who booked for the film “BHEEMLA NAYAK”?
SELECT Name, Age, phone_number FROM People
INNER JOIN Booking
ON People.people_ID = Booking.people_ID
INNER JOIN Screening
ON Screening.screening_ID = Booking.screening_ID INNER JOIN Movie
ON Screening.movie_ID = Movie.movie_ID
WHERE movie_title = "BHEEMLA NAYAK";


#5.
SELECT Seat.hall_ID, movie_title, screen_time, seat_row, seat_number
FROM Seat
INNER JOIN Seat_Reserverd
ON Seat.seat_ID = Seat_Reserverd.seat_ID
INNER JOIN Screening
ON Screening.screening_ID = Seat_Reserverd.screening_ID 
INNER JOIN Movie
ON Screening.movie_ID = Movie.movie_ID
WHERE screen_date = "2019-10-05" AND Seat.hall_ID = "H2";
