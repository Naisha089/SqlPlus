
CREATE OR REPLACE PROCEDURE Calculate_Total_Workers AS
  m_total_management_workers NUMBER;
  m_total_management_workers1 NUMBER;
  m_total_management_workers2 NUMBER;
  
BEGIN
  SELECT SUM(Workers) INTO m_total_management_workers1 FROM Management;
  SELECT SUM(Workers) INTO m_total_management_workers2 FROM Management@site_link;
  
  m_total_management_workers := m_total_management_workers1 + m_total_management_workers2;
  
  
  
  DBMS_OUTPUT.PUT_LINE('Total Workers in Management table: ' || m_total_management_workers);

END;
/


SET SERVEROUTPUT ON;


BEGIN
  Calculate_Total_Workers;
END;
/

