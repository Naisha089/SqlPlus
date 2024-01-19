CREATE OR REPLACE PROCEDURE Cast_sale(p_project_name VARCHAR2) IS
BEGIN
  FOR i IN (
    SELECT c.Cast_Name, d.Director, s.Budget
    FROM Cast c
    JOIN Directions d ON c.Project_name = d.Project_name
    JOIN Sales s ON c.Project_name = s.Project_name
    WHERE c.Project_name = p_project_name
    UNION
    SELECT c.Cast_Name, d.Director, s.Budget
    FROM Cast@site_link c
    JOIN Directions@site_link d ON c.Project_name = d.Project_name
    JOIN Sales@site_link s ON c.Project_name = s.Project_name
    WHERE c.Project_name = p_project_name
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Project Name: ' || p_project_name);
    DBMS_OUTPUT.PUT_LINE('Cast Name: ' || i.Cast_Name);
    DBMS_OUTPUT.PUT_LINE('Director: ' || i.Director);
    DBMS_OUTPUT.PUT_LINE('Budget: ' || i.Budget);
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Project not found');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred');
END Cast_sale;
/


SET SERVEROUTPUT ON;

BEGIN
  Cast_sale('&Enter_Project_Name');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/



