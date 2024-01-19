CREATE OR REPLACE PROCEDURE Get_Management_Leads AS
BEGIN
  FOR rec IN (
    SELECT m.Lead AS Management_Lead,
           pm.Lead AS Post_Management_Lead,
           m.M_Type,
           pm.Post_Type,
		   m.Project_name

    FROM Management m
    JOIN Post_Management pm ON m.Project_name = pm.Project_name
	UNION
	SELECT m.Lead AS Management_Lead,
           pm.Lead AS Post_Management_Lead,
           m.M_Type,
           pm.Post_Type,
		   m.Project_name

    FROM Management@site_link m
    JOIN Post_Management pm ON m.Project_name = pm.Project_name
	
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Project Name: ' || rec.Project_name);
    DBMS_OUTPUT.PUT_LINE('Management Lead: ' || rec.Management_Lead);
	DBMS_OUTPUT.PUT_LINE('M_Type: ' || rec.M_Type);
    DBMS_OUTPUT.PUT_LINE('Post Management Lead: ' || rec.Post_Management_Lead);
    DBMS_OUTPUT.PUT_LINE('Post_Type: ' || rec.Post_Type);
	
	
    DBMS_OUTPUT.PUT_LINE('-------------------------');
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
SET SERVEROUTPUT ON;
BEGIN
  Get_Management_Leads;
END;
/