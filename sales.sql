
CREATE TABLE Sales (
  Serial NUMBER,
  Project_name VARCHAR2(200),
  Budget NUMBER,
  Domestic_Box_Office NUMBER,
  Worldwide_Box_Office NUMBER,
  PRIMARY key (Serial),
  FOREIGN KEY (Project_name) REFERENCES Project1(Project_name)
);

INSERT INTO Sales VALUES (1, 'Dark', 12000000, 50000000, 120000000);

INSERT INTO Sales VALUES (2, 'Friends', 150000000, 80000005, 180000000);

INSERT INTO Sales VALUES (3, 'Nun', 120000000, 70000000, 15000000);

commit;
SELECT * from sales union  SELECT * from sales@site_link ;



CREATE OR REPLACE TRIGGER trig6 
AFTER INSERT or UPDATE 
ON project1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/

CREATE OR REPLACE PACKAGE Sales_Package AS
  FUNCTION Calculate_Profit(p_project_name VARCHAR2) RETURN NUMBER;
END Sales_Package;
/

CREATE OR REPLACE PACKAGE BODY Sales_Package AS
  FUNCTION Calculate_Profit(p_project_name VARCHAR2) RETURN NUMBER IS
    m_profit NUMBER;
  BEGIN
    
    SELECT SUM(amount) INTO m_profit FROM (
      SELECT Budget - Domestic_Box_Office AS amount
      FROM Sales
      WHERE Project_name = p_project_name
      UNION
      SELECT Budget - Domestic_Box_Office AS amount
      FROM Sales@site_link
      WHERE Project_name = p_project_name
    );

    IF m_profit IS NOT NULL THEN
      RETURN m_profit;
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Error calculating profit.');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20002, 'Project not found in the Sales table.');
    WHEN OTHERS THEN
      RETURN NULL;
  END Calculate_Profit;
END Sales_Package;
/


SET SERVEROUTPUT ON;

DECLARE
  m_project_name VARCHAR2(200);
  m_profit NUMBER;
BEGIN
 
  m_project_name := '&Enter_Project_Name';


  m_profit := Sales_Package.Calculate_Profit(m_project_name);

  IF m_profit IS NOT NULL THEN
    IF m_profit >= 0 THEN
      DBMS_OUTPUT.PUT_LINE('Profit for ' || m_project_name || ': ' || m_profit);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Loss for ' || m_project_name || ': ' || ABS(m_profit));
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error occurred while calculating profit.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/




COMMIT;

