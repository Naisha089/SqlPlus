
DROP TABLE Cast;

CREATE TABLE Cast (
  Cast_Id NUMBER,
  Cast_Name VARCHAR2(20),
  Age NUMBER,
  Gender VARCHAR2(20),
  Role VARCHAR2(20),
  Salary NUMBER,
  project_name VARCHAR2(20),
  Project_Status VARCHAR2(20),
  Director VARCHAR2(20),
  PRIMARY KEY (Cast_Id),
  FOREIGN KEY (project_name) REFERENCES project1(project_name)
);


INSERT INTO Cast VALUES (1, 'John Smith', 30, 'Male', 'Lead Actor', 10000, 'Dark', 'ongoing', 'Michael Johnson');
--INSERT INTO Cast VALUES (2, 'Jane Doe', 28, 'Female', 'Supporting Actress', 8000, 'Friends', 'finished', 'David White');
INSERT INTO Cast VALUES (2, 'Tom Clave', 28, 'Male', 'Supporting Actress', 8000, 'Friends', 'finished', 'David White');
INSERT INTO Cast VALUES (3, 'Bob Johnson', 35, 'Male', 'Supporting Actor', 9000, 'Nun', 'ongoing', 'Jessica Lee');
 commit;

select * from cast union select * from Cast@site_link;


CREATE OR REPLACE TRIGGER Trig5  
AFTER INSERT 
ON Cast
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/

CREATE OR REPLACE PACKAGE Cast_Info_Pkg AS
  FUNCTION Get_Cast_And_Status(p_project_name IN VARCHAR2) RETURN VARCHAR2;
END Cast_Info_Pkg;
/


CREATE OR REPLACE PACKAGE BODY Cast_Info_Pkg AS
  FUNCTION Get_Cast_And_Status(p_project_name IN VARCHAR2) RETURN VARCHAR2 IS
    m_cast_status VARCHAR2(100);  
    m_cast_name Cast.Cast_Name%TYPE;
    m_project_status Cast.Project_Status%TYPE;
  BEGIN
    
    FOR i IN (
      (SELECT Cast_Name, Project_Status
       FROM Cast
       WHERE Project_name = p_project_name)
      UNION
      (SELECT Cast_Name, Project_Status
       FROM Cast@site_link
       WHERE Project_name = p_project_name)
    )
    LOOP
      m_cast_name := i.Cast_Name;
      m_project_status := i.Project_Status;
     
     
	   IF m_cast_name IS NOT NULL THEN
        m_cast_status := m_cast_status || m_cast_name || ', ';
      END IF;
      
      IF m_project_status IS NOT NULL THEN
        m_cast_status := m_cast_status || m_project_status || '; ';
      END IF;
    END LOOP;

   
    IF m_cast_status IS NULL OR m_cast_status = '' THEN
      RETURN 'Project not found';
    ELSE
      RETURN m_cast_status;
    END IF;
    
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'Error occurred';
  END Get_Cast_And_Status;
END Cast_Info_Pkg;
/


SET SERVEROUTPUT ON;




DECLARE
  m_project_name VARCHAR2(25) := '&Enter_Project_Name'; 
  m_result VARCHAR2(100);
BEGIN
  m_result := Cast_Info_Pkg.Get_Cast_And_Status(m_project_name);
  DBMS_OUTPUT.PUT_LINE('Result: ' || m_result);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/


COMMIT;
