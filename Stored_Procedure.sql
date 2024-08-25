DROP PROCEDURE IF EXISTS `AllocateSubjects3`;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AllocateSubjects3`()
BEGIN
    -- Declare local variables at the beginning of the BEGIN block
    DECLARE StudentIdVar INT;
    DECLARE GPAVar FLOAT;
    DECLARE AllocatedSubject VARCHAR(6);
    DECLARE PreferenceVar INT;
    DECLARE SeatsLeftVar INT;
    
    -- Drop the tables if they exist
    DROP TABLE IF EXISTS AvailableSeats;
    DROP TABLE IF EXISTS UnallottedStudents;
    DROP TABLE IF EXISTS ResultantTable;
    
    -- Create tables to keep track of the number of seats available for each subject, unallocated students, and resultant table
    CREATE TABLE AvailableSeats (
        SubjectId VARCHAR(6) PRIMARY KEY,
        SeatsLeft INT
    );
    
    CREATE TABLE UnallottedStudents (
        StudentId INT PRIMARY KEY,
        GPA FLOAT
    );
    
    CREATE TABLE ResultantTable (
        StudentId INT,
        SubjectId VARCHAR(6),
        Preference INT
    );
    
    -- Initialize the AvailableSeats table with the maximum number of seats for each subject
    INSERT INTO AvailableSeats (SubjectId, SeatsLeft)
    SELECT subjectid, remainingseats FROM subjectdetails;
    
    -- Allocate subjects to students based on their preferences and GPA
    WHILE EXISTS (
        SELECT 1 
        FROM studentpreference sp 
        WHERE NOT EXISTS 
              (SELECT 1 FROM ResultantTable rt WHERE rt.StudentId = sp.studentid)
          AND NOT EXISTS 
              (SELECT 1 FROM UnallottedStudents us WHERE us.StudentId = sp.studentid)
    ) DO
        BEGIN
            -- Select the top student and their preferences based on GPA
            SELECT sd.studentid, sd.GPA, sp.subjectid, sp.preference
            INTO StudentIdVar, GPAVar, AllocatedSubject, PreferenceVar
            FROM studentpreference sp
            INNER JOIN studentdetails sd ON sp.studentid = sd.studentid
            WHERE NOT EXISTS (SELECT 1 FROM ResultantTable rt WHERE rt.StudentId = sp.studentid)
            AND NOT EXISTS (SELECT 1 FROM UnallottedStudents us WHERE us.StudentId = sp.studentid)
            ORDER BY sd.GPA DESC, sp.preference
            LIMIT 1;
            
            IF StudentIdVar IS NOT NULL THEN
                -- Find the first available subject based on the student's preferences
                SELECT SeatsLeft INTO SeatsLeftVar 
                FROM AvailableSeats 
                WHERE SubjectId = AllocatedSubject;
                
                WHILE SeatsLeftVar = 0 AND PreferenceVar < 5 DO
                    -- Try the next preference
                    SET PreferenceVar := PreferenceVar + 1;
                    SELECT subjectid INTO AllocatedSubject
                    FROM studentpreference
                    WHERE studentid = StudentIdVar AND preference = PreferenceVar;
                    SELECT SeatsLeft INTO SeatsLeftVar FROM AvailableSeats WHERE SubjectId = AllocatedSubject;
                END WHILE;
                
                IF SeatsLeftVar > 0 THEN
                    -- Allocate the subject to the student
                    INSERT INTO ResultantTable (StudentId, SubjectId, Preference)
                    VALUES (StudentIdVar, AllocatedSubject, PreferenceVar);
                    
                    -- Update the available seats for the subject
                    UPDATE AvailableSeats SET SeatsLeft = SeatsLeft - 1 WHERE SubjectId = AllocatedSubject;
                ELSE
                    -- Mark student as unallocated if all preferences are full
                    IF NOT EXISTS (SELECT 1 FROM UnallottedStudents WHERE StudentId = StudentIdVar) THEN
                        INSERT INTO UnallottedStudents (StudentId, GPA)
                        VALUES (StudentIdVar, GPAVar);
                    END IF;
                END IF;
            END IF;
        END;
    END WHILE;
    
END $$

DELIMITER ;
