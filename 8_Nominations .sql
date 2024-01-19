DROP TABLE Nominations;

CREATE TABLE Nominations (
    nomination_id INT,
    n_type VARCHAR2(20), 
    project_name VARCHAR2(20),
	project_type varchar2(20),
    result VARCHAR(20),
    PRIMARY KEY(nomination_id),
    FOREIGN KEY (project_name) REFERENCES project1(project_name)
);

INSERT INTO Nominations VALUES (104,'Best screenplay' ,'Nun','Web Series','Nominee');
INSERT INTO Nominations VALUES (105,'Best story','Vampire Diaries','Web Series','Nominee');
INSERT INTO Nominations VALUES (106,'Best cinematography', 'Stranger Things','Web Series','Nominee');
COMMIT;

--SELECT * FROM Nominations;
SELECT * FROM Nominations union SELECT * FROM Nominations@site_link;

CREATE OR REPLACE TRIGGER t8  
AFTER INSERT 
ON Nominations
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/