
CREATE OR REPLACE PROCEDURE project1(
    p_project_id INT,
    p_project_type VARCHAR2(20),
    p_project_name VARCHAR2(20),
    p_release_date DATE,
    p_genre VARCHAR2(20),
    p_rating INT,
    p_language VARCHAR2(20),
    PRIMARY KEY (project_name)
)
AS
BEGIN
    INSERT INTO project1(project_id, project_type, project_name, release_date,genre,rating,language)
    VALUES (p_project_id, p_project_type, p_project_name, p_release_date,p_genre,p_rating,p_language);
	
    INSERT INTO project1@site_link(project_id, project_type, project_name, release_date,genre,rating,language)
    VALUES (p_project_id, p_project_type, p_project_name, p_release_date,p_genre,p_rating,p_language);
    
    
    
   
	
    DBMS_OUTPUT.PUT_LINE('project  added successfully!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding project: ' || SQLERRM);

END project1;
/

INSERT INTO project1 VALUES(5, 'Movies', 'Barbie', TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'Thriller', 9, 'English');
INSERT INTO project1 VALUES(6, 'Movies', 'Nun', TO_DATE('2022-07-18', 'YYYY-MM-DD'), 'Horror', 8.5, 'English');
 commit;

SELECT * from project1 union SELECT * from project1@site_link;


CREATE OR REPLACE TRIGGER trig1 
AFTER INSERT or UPDATE 
ON project1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/
