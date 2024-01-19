
CREATE OR REPLACE PACKAGE AwardNominations_Package AS
  FUNCTION Get_Common_Projects RETURN VARCHAR2;
END AwardNominations_Package;
/


CREATE OR REPLACE PACKAGE BODY AwardNominations_Package AS
  FUNCTION Get_Common_Projects RETURN VARCHAR2 IS
    m_project_names VARCHAR2(100) := '';

  BEGIN
    FOR rec IN (
      SELECT DISTINCT a.Project_name
      FROM Award a
      JOIN Nominations n ON a.Project_name = n.Project_name
	  UNION
	  SELECT DISTINCT a.Project_name
      FROM Award@site_link a
      JOIN Nominations@site_link n ON a.Project_name = n.Project_name
    ) LOOP
      m_project_names := m_project_names || 'Project: ' || rec.Project_name || ' ';
    END LOOP;
    
    

    RETURN m_project_names;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error occurred';
  END Get_Common_Projects;
END AwardNominations_Package;
/


SET SERVEROUTPUT ON;

DECLARE
  v_common_projects VARCHAR2(100);
BEGIN
  v_common_projects := AwardNominations_Package.Get_Common_Projects;
  DBMS_OUTPUT.PUT_LINE('Common Projects: ' || v_common_projects);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
