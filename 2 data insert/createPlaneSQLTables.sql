CREATE TABLE Customer (
    customerID INT NOT NULL,
    c_kind CHAR(1) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    address VARCHAR(60) NOT NULL,
    name VARCHAR(20) NOT NULL,
    PRIMARY KEY (customerID)
);
CREATE TABLE Plane (
    planeID INT NOT NULL,
    p_size INT NOT NULL,
    model VARCHAR(100) NOT NULL,
    maxWeight FLOAT NOT NULL,
    currWeight FLOAT NOT NULL,
    type CHAR(1) NOT NULL,
    PRIMARY KEY (planeID)
);
CREATE TABLE CargoPlane (
    cargo_kind CHAR(1) NOT NULL,
    planeID INT NOT NULL,
    PRIMARY KEY (planeID),
    FOREIGN KEY (planeID) REFERENCES Plane(planeID)
);
CREATE TABLE PassengerPlane (
    classesAmount INT NOT NULL,
    trunkSize INT NOT NULL,
    seatsCount INT NOT NULL,
    planeID INT NOT NULL,
    PRIMARY KEY (planeID),
    FOREIGN KEY (planeID) REFERENCES Plane(planeID)
);
CREATE TABLE State (
    stateID INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (stateID)
);
CREATE TABLE Hitch (
    hitchID INT NOT NULL unique,
    h_kind CHAR(1) NOT NULL,
    status CHAR(1) NOT NULL,
    description VARCHAR(250) NOT NULL,
    h_date DATE NOT NULL,
    planeID INT NOT NULL,
    PRIMARY KEY (hitchID, planeID),
    FOREIGN KEY (planeID) REFERENCES Plane(planeID)
);
CREATE TABLE PlaneSeat (
    seatID INT NOT NULL unique,
    class CHAR(1) NOT NULL,
    the_row INT NOT NULL,
    col INT NOT NULL,
    isWithWindow INT NOT NULL,
    isInMiddleRow INT NOT NULL,
    planeID INT NOT NULL,
    PRIMARY KEY (seatID, planeID),
    FOREIGN KEY (planeID) REFERENCES Plane(planeID)
);
CREATE TABLE City (
    cityID INT NOT NULL unique,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    stateID INT NOT NULL,
    PRIMARY KEY (cityID, stateID),
    FOREIGN KEY (stateID) REFERENCES State(stateID)
);
CREATE TABLE Airport (
    airportID INT NOT NULL unique,
    fullName VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(8) NOT NULL,
    cityID INT NOT NULL,
    PRIMARY KEY (airportID, cityID),
    FOREIGN KEY (cityID) REFERENCES City(cityID)
);
CREATE TABLE Flight (
    flightID INT NOT NULL unique,
    flightTime DATE NOT NULL,
    takeoffDateTime DATE NOT NULL,
    planeID INT NOT NULL,
    srcAirportID INT NOT NULL,
    dstAirportID INT NOT NULL,
    PRIMARY KEY (flightID, planeID),
    FOREIGN KEY (planeID) REFERENCES Plane(planeID),
    FOREIGN KEY (srcAirportID) REFERENCES Airport(airportID),
    FOREIGN KEY (dstAirportID) REFERENCES Airport(airportID)
);
CREATE TABLE ShuttleBusLine (
    shuttleID INT NOT NULL,
    busCount INT NOT NULL,
    startTime DATE NOT NULL,
    endTime DATE NOT NULL,
    description VARCHAR(500) NOT NULL,
    srcAirportID INT NOT NULL,
    dstCityID INT NOT NULL,
    PRIMARY KEY (shuttleID),
    FOREIGN KEY (srcAirportID) REFERENCES Airport(airportID),
    FOREIGN KEY (dstCityID) REFERENCES City(cityID)
);
CREATE TABLE FilghtTicket (
    ticketID INT NOT NULL unique,
    status CHAR(1) NOT NULL,
    flightID INT NOT NULL,
    seatID INT NOT NULL,
	price INT NOT NULL,
    customerID INT,
    PRIMARY KEY (ticketID, flightID),
    FOREIGN KEY (flightID) REFERENCES Flight(flightID),
    FOREIGN KEY (seatID) REFERENCES PlaneSeat(seatID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);
CREATE TABLE Luggage (
    luggageID INT NOT NULL,
    weight FLOAT NOT NULL,
    ticketID INT NOT NULL,
    PRIMARY KEY (luggageID, ticketID),
    FOREIGN KEY (ticketID) REFERENCES FilghtTicket(ticketID)
);
CREATE TABLE Employee (
    employeeID INT NOT NULL unique,
    role VARCHAR(50) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL,
    email VARCHAR(60) NOT NULL,
    address VARCHAR(100) NOT NULL,
    startCareerDate DATE NOT NULL,
    airportID INT NOT NULL,
    PRIMARY KEY (employeeID, airportID),
    FOREIGN KEY (airportID) REFERENCES Airport(airportID)
);
CREATE TABLE CustomerService (
    service_date DATE NOT NULL,
    abbreviation VARCHAR(50) NOT NULL,
    status INT NOT NULL,
    description VARCHAR(500) NOT NULL,
    flightID INT NOT NULL,
    customerID INT NOT NULL,
    employeeID INT NOT NULL,
    PRIMARY KEY (flightID, customerID, employeeID),
    FOREIGN KEY (flightID) REFERENCES Flight(flightID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);
CREATE TABLE Maintenance (
    checkDateTime DATE NOT NULL,
    employeeID INT NOT NULL,
    hitchID INT NOT NULL,
    PRIMARY KEY (employeeID, hitchID),
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID),
    FOREIGN KEY (hitchID) REFERENCES Hitch(hitchID)
);