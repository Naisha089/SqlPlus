
SET SERVEROUTPUT ON;
set verify off;

CREATE OR REPLACE PROCEDURE GetTrailerDetailsByProjectName(
  p_project_name IN VARCHAR2,
  p_trailer_id OUT NUMBER,
  p_title OUT VARCHAR2,
  p_url OUT VARCHAR2,
  p_release_date OUT DATE,
  p_rating OUT NUMBER
)
IS
BEGIN
  FOR i IN (
    SELECT t.trailer_id, t.title, t.url, pr.release_date, pr.rating
    FROM Trailers t
    JOIN project1 pr ON t.project_name = pr.project_name
    WHERE pr.project_name = p_project_name
    UNION
    SELECT t.trailer_id, t.title, t.url, pr.release_date, pr.rating
    FROM Trailers@site_link t
    JOIN project1@site_link pr ON t.project_name = pr.project_name
    WHERE pr.project_name = p_project_name
  ) LOOP
    p_trailer_id := i.trailer_id;
    p_title := i.title;
    p_url := i.url;
    p_release_date := i.release_date;
    p_rating := i.rating;
  END LOOP;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      p_trailer_id := NULL;
      p_title := NULL;
      p_url := NULL;
      p_release_date := NULL;
      p_rating := NULL;
    WHEN OTHERS THEN
      p_trailer_id := NULL;
      p_title := NULL;
      p_url := NULL;
      p_release_date := NULL;
      p_rating := NULL;
END;
/


DECLARE
  v_trailer_id NUMBER;
  v_title VARCHAR2(30);
  v_url VARCHAR2(50);
  v_release_date DATE;
  v_rating NUMBER;
  v_project_name VARCHAR2(30);
BEGIN
  v_project_name := '&Enter_Project_Name';
  
  GetTrailerDetailsByProjectName(
    v_project_name,
    v_trailer_id,
    v_title,
    v_url,
    v_release_date,
    v_rating
  );

  IF v_trailer_id IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE('Trailer ID: ' || v_trailer_id);
    DBMS_OUTPUT.PUT_LINE('Title: ' || v_title);
    DBMS_OUTPUT.PUT_LINE('URL: ' || v_url);
    DBMS_OUTPUT.PUT_LINE('Release Date: ' || v_release_date);
    DBMS_OUTPUT.PUT_LINE('Rating: ' || v_rating);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Trailer details not found.');
  END IF;
END;
/
