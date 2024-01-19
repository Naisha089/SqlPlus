DROP TABLE Studio;

CREATE TABLE Studio (
  Studio_Id NUMBER,
  Studio_worker NUMBER,
  Location VARCHAR2(20),
  PRIMARY KEY (Studio_Id)
);

INSERT INTO Studio VALUES (1, 300, 'Dhaka');
INSERT INTO Studio VALUES (2, 500, 'Chittagong');
INSERT INTO Studio VALUES (3, 350, 'Khulna');

COMMIT;


SELECT
    s1.Studio_Id,
	s1.Studio_worker,
	s1.Location,
    s2.Studio_Id AS s2_Studio_Id,
	s2.Studio_Name,
    s2.Studio_manager
FROM
    Studio s1
JOIN
    Studio@site_link s2 ON s1.Studio_Id = s2.Studio_Id;

COMMIT;

CREATE OR REPLACE TRIGGER t11  
AFTER INSERT 
ON Studio
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/
