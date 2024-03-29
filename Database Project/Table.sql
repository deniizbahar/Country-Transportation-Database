CREATE TABLE CITIZEN_CARD (
    Card_ID INT PRIMARY KEY NOT NULL,
    Money_Amount DECIMAL(10, 2) NOT NULL CHECK (Money_Amount >= 0)
);

CREATE TABLE PERSON (
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL,
    TC CHAR(11) PRIMARY KEY NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    Birth_Date DATE NOT NULL,
    Phone NVARCHAR(15),
    Email NVARCHAR(100),
    Card_ID INT NOT NULL DEFAULT 0,
    FOREIGN KEY (Card_ID) REFERENCES CITIZEN_CARD(Card_ID) ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE COMPANY (
    Company_Name NVARCHAR(255) PRIMARY KEY NOT NULL
);

CREATE TABLE LOCATIONS (
    Location_Id INT NOT NULL,
    Company_Name NVARCHAR(255) NOT NULL DEFAULT 'NO NAME',
    Address NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Company_Name) REFERENCES COMPANY(Company_Name) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    PRIMARY KEY (Location_Id, Company_Name)
);

CREATE TABLE JOURNEY (
    Journey_Id INT PRIMARY KEY NOT NULL,
    Company_Name NVARCHAR(255) NOT NULL  DEFAULT 'NO NAME',
    FOREIGN KEY (Company_Name) REFERENCES COMPANY(Company_Name) ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE TRANSACTIONS (
    Transaction_Id INT NOT NULL,
    TC CHAR(11) NOT NULL DEFAULT '00000000000',
    Journey_Id INT NOT NULL DEFAULT 0000,
    Seat_Number INT,
    Total_Price DECIMAL(10, 2) NOT NULL,
    Scheduled_Arr_Date DATE,
    Scheduled_Arr_Time TIME,
    Scheduled_Dep_Date DATE,
    Scheduled_Dep_Time TIME,
    Ticket_Category NVARCHAR(50),
	Departure_Place NVARCHAR(255),
    Receive_Place NVARCHAR(255),
    Departure_Place_X DECIMAL(9,6),
    Departure_Place_Y DECIMAL(9,6),
    Receive_Place_X DECIMAL(9,6),
    Receive_Place_Y DECIMAL(9,6),
    Pet BIT,
    Seat_Reservation BIT,
    Extra_Baggage_Charges DECIMAL(10, 2),
    Purchase_Date DATE NOT NULL,
    Purchase_Time TIME NOT NULL,
    FOREIGN KEY (TC) REFERENCES PERSON(TC) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (Journey_Id) REFERENCES JOURNEY(Journey_Id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
	PRIMARY KEY (Transaction_Id, TC, Journey_Id)
);

CREATE TABLE TRANSACTION_HISTORY (
    History_Id INT NOT NULL,
    TC CHAR(11) NOT NULL DEFAULT '00000000000',
    Transaction_Id INT NOT NULL DEFAULT 0,
    Journey_Id INT NOT NULL DEFAULT 0000,
    FOREIGN KEY (Transaction_Id, TC, Journey_Id) REFERENCES TRANSACTIONS(Transaction_Id,TC, Journey_Id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    PRIMARY KEY (History_Id, TC)
);

CREATE TABLE SEARCH_HISTORY (
    History_Id INT NOT NULL,
    TC CHAR(11) NOT NULL DEFAULT '00000000000',
    Journey_Id INT NOT NULL DEFAULT 0000,
    Search_Time TIME NOT NULL,
    Search_Date DATE NOT NULL,
    PRIMARY KEY (History_Id, TC),
    FOREIGN KEY (TC) REFERENCES PERSON(TC) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (Journey_Id) REFERENCES JOURNEY(Journey_Id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
	
);

CREATE TABLE AIRPORT (
    Airport_Name NVARCHAR(255) PRIMARY KEY  NOT NULL,
    City NVARCHAR(100) NOT NULL
);

CREATE TABLE AIRPLANE (
    Aircraft_Type NVARCHAR(255) PRIMARY KEY NOT NULL ,
    Max_Range INT NOT NULL,
    High_Max_Speed INT NOT NULL,
    Wingspan_Length INT NOT NULL
);

CREATE TABLE PLANE_JOURNEY (
    Journey_Id INT PRIMARY KEY NOT NULL CHECK (Journey_Id >= 1000 AND Journey_Id < 2000),
    Aircraft_Type NVARCHAR(255) NOT NULL,
    Arrival_Airport_Name NVARCHAR(255) NOT NULL,
    Departure_Airport_Name NVARCHAR(255) NOT NULL,
    Departure_Time TIME NOT NULL,
    Departure_Date DATE NOT NULL,
    Arrival_Time TIME NOT NULL,
    Arrival_Date DATE NOT NULL,
    Next_Journey_ID INT,
    FOREIGN KEY (Aircraft_Type) REFERENCES AIRPLANE(Aircraft_Type),
    FOREIGN KEY (Arrival_Airport_Name) REFERENCES AIRPORT(Airport_Name),
    FOREIGN KEY (Departure_Airport_Name) REFERENCES AIRPORT(Airport_Name),
    FOREIGN KEY (Next_Journey_ID) REFERENCES PLANE_JOURNEY(Journey_Id),
    FOREIGN KEY (Journey_Id) REFERENCES Journey(Journey_Id)
);

CREATE TABLE BUS (
    Bus_ID INT PRIMARY KEY NOT NULL,
    Fuel_Type NVARCHAR(50) NOT NULL,
    Number_of_Seats INT NOT NULL,
    Transmission_Type NVARCHAR(50) NOT NULL,
    Bus_Model NVARCHAR(50) NOT NULL
);

CREATE TABLE BUS_STATION (
    Station_Name NVARCHAR(255) PRIMARY KEY NOT NULL
);
CREATE TABLE BUS_JOURNEY (
    Journey_Id INT PRIMARY KEY NOT NULL CHECK (Journey_Id >= 2000 AND Journey_Id < 3000),
    Bus_Id INT NOT NULL,
    Arrival_Time TIME,
	Arrival_Date Date,
    Arrival_Bus_Station NVARCHAR(255),
    Departure_Time TIME NOT NULL,
    Departure_Date DATE NOT NULL,
    Departure_Station NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Bus_Id) REFERENCES BUS(Bus_ID),
    FOREIGN KEY (Departure_Station) REFERENCES BUS_STATION(Station_Name),
    FOREIGN KEY (Arrival_Bus_Station) REFERENCES BUS_STATION(Station_Name),
	FOREIGN KEY (Journey_Id) REFERENCES Journey(Journey_Id),
);
CREATE TABLE BUS_STOPS (
    Station_Name NVARCHAR(255) NOT NULL,
    Bus_Journey_Id INT NOT NULL,
    Arrival_Time TIME,
    Arrival_Date DATE,
    Departure_Time TIME,
    Departure_Date DATE,
    PRIMARY KEY (Station_Name, Bus_Journey_Id),
    FOREIGN KEY (Station_Name) REFERENCES BUS_STATION(Station_Name),
    FOREIGN KEY (Bus_Journey_Id) REFERENCES BUS_JOURNEY(Journey_Id)
);
CREATE TABLE VEHICLE (
    Vehicle_ID INT PRIMARY KEY NOT NULL,
    Model NVARCHAR(50) NOT NULL,
    Fuel_Type NVARCHAR(50) NOT NULL,
    Deposite_Fees DECIMAL(10, 2) NOT NULL,
    Car_Brand NVARCHAR(50) NOT NULL,
    Car_Class NVARCHAR(50) NOT NULL,
    Locations NVARCHAR(255) NOT NULL
);

CREATE TABLE VEHICLE_JOURNEY (
    Journey_Id INT PRIMARY KEY NOT NULL CHECK (Journey_Id >= 3000 AND Journey_Id < 4000),
    Vehicle_Id INT NOT NULL,
	FOREIGN KEY (Vehicle_Id) REFERENCES VEHICLE(Vehicle_Id),
	FOREIGN KEY (Journey_Id) REFERENCES Journey(Journey_Id),

);
CREATE TABLE FERRY (
    Ferry_Id INT PRIMARY KEY NOT NULL,
    Fuel_Type NVARCHAR(50) NOT NULL,
    Ferry_Type NVARCHAR(50) NOT NULL,
    Seat_Count INT NOT NULL
);
--Port Kelimesi Uygulaman�n Kendi i�inde tan�ml� oldu�u i�in HARBOR olarak tan�mlad�k.
CREATE TABLE HARBOR (
    Port_Name NVARCHAR(255) PRIMARY KEY NOT NULL
);

CREATE TABLE FERRY_JOURNEY (
    Journey_ID INT PRIMARY KEY NOT NULL CHECK (Journey_Id >= 4000 AND Journey_Id < 5000),
    Ferry_ID INT NOT NULL,
    Arrival_Time TIME NOT NULL,
    Arrival_Date DATE NOT NULL,
    Arrival_Port NVARCHAR(255) NOT NULL,
    Departure_Time TIME NOT NULL,
    Departure_Date DATE NOT NULL,
    Departure_Port NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Arrival_Port) REFERENCES HARBOR(Port_Name),
    FOREIGN KEY (Departure_Port) REFERENCES HARBOR(Port_Name),
	FOREIGN KEY (Ferry_ID) REFERENCES FERRY(Ferry_Id),
	FOREIGN KEY (Journey_Id) REFERENCES Journey(Journey_Id),
);

CREATE TABLE FERRY_STOPS (
    Ferry_Journey_ID INT NOT NULL,
    Port_Name NVARCHAR(255) NOT NULL,
    Arrival_Time TIME NOT NULL,
    Arrival_Date DATE NOT NULL,
    Departure_Time TIME NOT NULL,
    Departure_Date DATE NOT NULL,
    PRIMARY KEY (Ferry_Journey_ID, Port_Name),
    FOREIGN KEY (Ferry_Journey_ID) REFERENCES FERRY_JOURNEY(Journey_ID),
    FOREIGN KEY (Port_Name) REFERENCES HARBOR(Port_Name)
);

CREATE TABLE METRO_TRAIN (
    Train_Number INT PRIMARY KEY NOT NULL,
    Train_Type NVARCHAR(50) NOT NULL,
    Vagon_Type NVARCHAR(50) NOT NULL,
    Seat_Count INT NOT NULL
);

CREATE TABLE METRO_STATION (
    Station_Name NVARCHAR(255) PRIMARY KEY NOT NULL
);

CREATE TABLE METRO_JOURNEY (
    Journey_ID INT PRIMARY KEY NOT NULL CHECK (Journey_Id >= 5000 AND Journey_Id < 6000),
    Train_Number INT NOT NULL,
    Arrival_Time TIME NOT NULL,
	Arrival_Date TIME NOT NULL,
    Arrival_Station NVARCHAR(255) NOT NULL,
    Departure_Time TIME NOT NULL,
    Departure_Date DATE NOT NULL,
    Departure_Station NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Train_Number) REFERENCES METRO_TRAIN(Train_Number),
    FOREIGN KEY (Arrival_Station) REFERENCES METRO_STATION(Station_Name),
    FOREIGN KEY (Departure_Station) REFERENCES METRO_STATION(Station_Name),
	FOREIGN KEY (Journey_Id) REFERENCES Journey(Journey_Id)
);

CREATE TABLE METRO_STOPS (
    Metro_Journey_ID INT NOT NULL,
    Station_Name NVARCHAR(255) NOT NULL,
    Arrival_Time TIME,
    Arrival_Date DATE,
    Departure_Time TIME,
    Departure_Date DATE,
    PRIMARY KEY (Metro_Journey_ID, Station_Name),
    FOREIGN KEY (Metro_Journey_ID) REFERENCES METRO_JOURNEY(Journey_ID),
    FOREIGN KEY (Station_Name) REFERENCES METRO_STATION(Station_Name)
);

CREATE TABLE MARTI (
    Marti_ID INT PRIMARY KEY NOT NULL,
    Battery INT NOT NULL CHECK (Battery BETWEEN 0 AND 100),
    Price DECIMAL(10, 2) NOT NULL,
    Location_X DECIMAL(9,6) NOT NULL,
    Location_Y DECIMAL(9,6) NOT NULL,
    Type NVARCHAR(50) NOT NULL
);


CREATE TABLE MARTI_JOURNEY (
    Journey_ID INT PRIMARY KEY NOT NULL CHECK (Journey_Id >= 7000 AND Journey_Id < 8000),
    Marti_ID INT NOT NULL,
	FOREIGN KEY (Marti_ID) REFERENCES MARTI(Marti_ID),
	FOREIGN KEY (Journey_Id) REFERENCES Journey(Journey_Id)
);


CREATE TABLE HIGH_SPEED_TRAIN (
    Train_Number INT PRIMARY KEY NOT NULL,
    Train_Type NVARCHAR(50) NOT NULL,
    Vagon_Type NVARCHAR(50) NOT NULL,
    Seat_Count INT NOT NULL
);

CREATE TABLE HIGH_SPEED_TRAIN_STATION (
    Station_Name NVARCHAR(255) PRIMARY KEY NOT NULL
);

CREATE TABLE HIGH_SPEED_TRAIN_JOURNEY (
    Journey_ID INT PRIMARY KEY NOT NULL CHECK (Journey_Id >= 6000 AND Journey_Id < 7000),
    Train_Number INT NOT NULL,
    Arrival_Time TIME NOT NULL,
	Arrival_Date TIME NOT NULL,
    Arrival_Station NVARCHAR(255) NOT NULL,
    Departure_Time TIME NOT NULL,
    Departure_Date DATE NOT NULL,
    Departure_Station NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Train_Number) REFERENCES HIGH_SPEED_TRAIN(Train_Number),
    FOREIGN KEY (Arrival_Station) REFERENCES HIGH_SPEED_TRAIN_STATION(Station_Name),
    FOREIGN KEY (Departure_Station) REFERENCES HIGH_SPEED_TRAIN_STATION(Station_Name),
	FOREIGN KEY (Journey_Id) REFERENCES Journey(Journey_Id)
);

CREATE TABLE HIGH_SPEED_TRAIN_STOPS (
    HIGH_SPEED_TRAIN_Journey_ID INT NOT NULL,
    Station_Name NVARCHAR(255) NOT NULL,
    Arrival_Time TIME,
    Arrival_Date DATE,
    Departure_Time TIME,
    Departure_Date DATE,
    PRIMARY KEY (HIGH_SPEED_TRAIN_Journey_ID, Station_Name),
    FOREIGN KEY (HIGH_SPEED_TRAIN_Journey_ID) REFERENCES HIGH_SPEED_TRAIN_JOURNEY(Journey_ID),
    FOREIGN KEY (Station_Name) REFERENCES HIGH_SPEED_TRAIN_STATION(Station_Name)
);