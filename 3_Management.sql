DROP TABLE Management;

CREATE TABLE Management (
  M_Serial NUMBER,
  M_Type VARCHAR2(20),
  Lead VARCHAR2(20),
  Workers NUMBER,
  Average_Salary NUMBER,
  Project_name VARCHAR2(20),
  Director VARCHAR2(20),
  PRIMARY KEY (M_Serial),
  FOREIGN KEY (Project_name) REFERENCES Project1(Project_name)
);

INSERT INTO Management VALUES (1, 'HR', 'John Smith', 20, 26000, 'Nun', 'Michael Johnson');
INSERT INTO Management VALUES (2, 'Finance', 'Jane Doe', 18, 23500, 'Barbie', 'David White');
INSERT INTO Management VALUES (3, 'Marketing', 'Bob Johnson', 16, 25000, 'Vampire Diaries', 'Jessica Lee');

COMMIT;

select * from Management union select  * from Management@site_link;

CREATE OR REPLACE TRIGGER t3 
AFTER INSERT or UPDATE 
ON Management
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/



CREATE OR REPLACE PACKAGE income1 AS
  PROJECT_NOT_FOUND EXCEPTION;
  PROCEDURE avg_salary;
END income1;
/

CREATE OR REPLACE PACKAGE BODY income1 AS
  PROCEDURE avg_salary IS
    total NUMBER;
    avg_income NUMBER;
    avg_income1 NUMBER;
    avg_income2 NUMBER;
    total1 NUMBER;
    total2 NUMBER;
  BEGIN
    SELECT COUNT(*) INTO total1 FROM Management;
    SELECT COUNT(*) INTO total2 FROM Management@site_link;

    total := total1 + total2;
    
    IF total > 0 THEN
      SELECT SUM(Average_Salary) INTO avg_income1 FROM Management;
      SELECT SUM(Average_Salary) INTO avg_income2 FROM Management@site_link;
	  
      avg_income := avg_income1 + avg_income2;
      avg_income := avg_income / total;
      
      DBMS_OUTPUT.PUT_LINE('Average income: ' || avg_income);
    ELSE
      RAISE PROJECT_NOT_FOUND;
    END IF;
  EXCEPTION
    WHEN PROJECT_NOT_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No records in the Management table.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
  END avg_salary;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  income1.avg_salary;
END;
/



