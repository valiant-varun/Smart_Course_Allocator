use database_name;
drop table if exists studentdetails;
drop table if exists studentpreference;
drop table if exists subjectdetails;
CREATE TABLE studentpreference (
    studentid INT,
    subjectid VARCHAR(10),
    preference INT
);

CREATE TABLE subjectdetails (
    subjectid VARCHAR(6) PRIMARY KEY,
    subjectname VARCHAR(1000),
    maxseats INT,
    remainingseats INT
);

CREATE TABLE studentdetails (
    studentid INT,
    studentname VARCHAR(100),
    GPA FLOAT(5)
);



-- Insert 6 random subjects
INSERT INTO subjectdetails (subjectid, subjectname, maxseats, remainingseats)
VALUES
    ('PO1491', 'Basics of political science', 60, 1),
    ('PO1492', 'Basics of accounting', 120, 1),
    ('PO1493', 'Basics of financial markets', 90, 1),
    ('PO1494', 'Eco philosophy', 60,1),
    ('PO1495', 'Automotive trends', 60, 1),
    ('PO1496', 'Automotive trends 2', 60, 1);

-- Insert 100 students with different CGPA and student ID
INSERT INTO studentdetails (studentid, studentname, GPA)
VALUES
    (159103001, 'John Doe', 8.3),
    (159103002, 'Jane Smith', 7.5),
    (159103003, 'Alice Johnson', 6.1),
    (159103004, 'Bear grills', 8.5),
    (159103005, 'Steve Smith', 7.3),
    (159103006, 'Tony Stark', 6.0);

-- Insert preferences of students for subjects
INSERT INTO studentpreference (studentid, subjectid, preference)
VALUES
    -- Student 1 preferences
    (159103001, 'PO1491', 1),
    (159103001, 'PO1492', 2),
    (159103001, 'PO1493', 3),
    (159103001, 'PO1494', 4),
    (159103001, 'PO1495', 5),

	(159103002, 'PO1491', 1),
    (159103002, 'PO1492', 2),
    (159103002, 'PO1493', 3),
    (159103002, 'PO1494', 4),
    (159103002, 'PO1495', 5),
    
    (159103003, 'PO1491', 1),
    (159103003, 'PO1492', 2),
    (159103003, 'PO1493', 3),
    (159103003, 'PO1494', 4),
    (159103003, 'PO1495', 5),
 
    (159103004, 'PO1491', 1),
    (159103004, 'PO1492', 2),
    (159103004, 'PO1493', 3),
    (159103004, 'PO1494', 4),
    (159103004, 'PO1495', 5),
    
    (159103005, 'PO1491', 1),
    (159103005, 'PO1492', 2),
    (159103005, 'PO1493', 3),
    (159103005, 'PO1494', 4),
    (159103005, 'PO1495', 5),
    
    (159103006, 'PO1491', 1),
    (159103006, 'PO1492', 2),
    (159103006, 'PO1493', 3),
    (159103006, 'PO1494', 4),
    (159103006, 'PO1495', 5);
    -- Insert more student preferences here

-- show tables;
call AllocateSubjects3();

select * from unallottedstudents;
select * from ResultantTable;
SELECT * from availableseats; 
