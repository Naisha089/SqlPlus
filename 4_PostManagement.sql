DROP TABLE Post_Management;

CREATE TABLE Post_Management (
  Post_Serial NUMBER,
  Lead VARCHAR2(20),
  Post_Type VARCHAR2(50),
  Workers NUMBER,
  Salary NUMBER,
  Project_name VARCHAR2(20),
  Director VARCHAR2(20),
  PRIMARY KEY (Post_Serial),
  FOREIGN KEY (Project_name) REFERENCES Project1(Project_name)
);

INSERT INTO Post_Management VALUES (4, 'John Henry', 'VFX', 10, 15000, 'Nun', 'Michael Johnson');
INSERT INTO Post_Management VALUES (5, 'Daniel David', 'lighting Effect', 30, 17500, 'Friends', 'David White');
INSERT INTO Post_Management VALUES (6, 'Michael Oliver', 'Dubbing', 56, 18000, 'Stranger Things', 'Jessica Lee');

COMMIT;
select * from Post_Management union select  * from Post_Management@site_link;


CREATE OR REPLACE TRIGGER t4 
AFTER INSERT or UPDATE 
ON Post_Management
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/

CREATE OR REPLACE PACKAGE BODY income2 AS
  PROCEDURE avg_salary2 IS
    total NUMBER;
    avg_income NUMBER;
    avg_income1 NUMBER;
    avg_income2 NUMBER;
    total1 NUMBER;
    total2 NUMBER;
  BEGIN
    SELECT COUNT(*) INTO total1 FROM Post_Management;
    SELECT COUNT(*) INTO total2 FROM Post_Management@site_link;

    total := total1 + total2;

    IF total > 0 THEN
      SELECT SUM(Salary) INTO avg_income1 FROM Post_Management; -- Fixed column name
      SELECT SUM(Salary) INTO avg_income2 FROM Post_Management@site_link; -- Fixed column name
      
      avg_income := avg_income1 + avg_income2;
      avg_income := avg_income / total;

      DBMS_OUTPUT.PUT_LINE('Average income: ' || avg_income);
    ELSE
      RAISE PROJECT_NOT_FOUND;
    END IF;
  EXCEPTION
    WHEN PROJECT_NOT_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No records in the post Management table.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
  END avg_salary2;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  income2.avg_salary2; 
END;
/