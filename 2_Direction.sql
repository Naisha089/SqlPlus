
drop table Directions;
CREATE TABLE Directions (
  Direction_id NUMBER,
  Producer VARCHAR2(20),
  Co_producer VARCHAR2(20),
  Director VARCHAR2(20),
  Editor VARCHAR2(20),
  Screen_writer VARCHAR2(20),
  Cinematographer VARCHAR2(20),
  Project_name VARCHAR2(20),
  Project_Status VARCHAR2(20),
  PRIMARY KEY (Direction_id),
  FOREIGN KEY (Project_name) REFERENCES Project1(Project_name)
);


INSERT INTO Directions VALUES (4, 'Alice Johnson', 'Bob Smith', 'David White', 'Mary Turner', 'Emily Black', 'Steven Davis', 'Friends', 'finished');
INSERT INTO Directions VALUES (5, 'Alice Johnson', 'Bob Smith', 'David White', 'Mary Turner', 'Emily Black', 'Steven Davis', 'Nun', 'finished');
INSERT INTO Directions VALUES (6, 'Bell Johnson', 'Alan clover', 'Red White', 'Mary jane', 'apple Black', 'Jack Davis', 'Vampire Diaries', 'finished');

COMMIT;



CREATE OR REPLACE TRIGGER t2 
AFTER INSERT or UPDATE 
ON Directions
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/

select * from Directions union select * from Directions@site_link;
