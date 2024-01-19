DROP TABLE Trailers;

CREATE TABLE Trailers (
    trailer_id NUMBER,
    project_name VARCHAR2(20),
    title VARCHAR2(20),
    url VARCHAR2(50),
    PRIMARY KEY(trailer_id),
    FOREIGN KEY (project_name) REFERENCES project1(project_name)
);

INSERT INTO Trailers VALUES(4, 'Nun','Official Trailer 1', 'https://www.example.com/trailer1');
INSERT INTO Trailers VALUES(5, 'Vampire Diaries','Official Trailer 1', 'https://www.example.com/trailer1'); 
INSERT INTO Trailers VALUES(6, 'Barbie','Official Trailer 1', 'https://www.example.com/trailer1'); 

COMMIT;

--SELECT * FROM Trailers;
SELECT * FROM Trailers union SELECT * FROM Trailers@site_link;

CREATE OR REPLACE TRIGGER t9  
AFTER INSERT 
ON Trailers
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/