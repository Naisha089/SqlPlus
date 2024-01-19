SET SERVEROUTPUT ON;
SET VERIFY OFF;

DECLARE
  m_project_name VARCHAR2(20) := '&Enter_Project_Name';
  m_cast_name Cast.Cast_Name%TYPE;
  m_award_name Award.Award_Name%TYPE;
BEGIN
  FOR cast_award IN (
    SELECT c.Cast_Name, a.Award_Name
    FROM Cast c
     JOIN Award a ON c.Project_name = a.Project_name
    WHERE c.Project_name = m_project_name 
    UNION
    SELECT c.Cast_Name, a.Award_Name
    FROM Cast@site_link c
     JOIN Award@site_link a ON c.Project_name = a.Project_name
    WHERE c.Project_name = m_project_name 
	
  ) LOOP
    m_cast_name := cast_award.Cast_Name;
    m_award_name := cast_award.Award_Name;

    DBMS_OUTPUT.PUT_LINE('Lead Actor Name: ' || m_cast_name);
    DBMS_OUTPUT.PUT_LINE('Award Name: ' || m_award_name);
    
  END LOOP;
END;
/
