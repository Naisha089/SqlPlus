DROP TABLE Campaigns;


CREATE TABLE Campaigns (
    campaign_id INT,
    --start_date DATE,
    --end_date DATE,
    c_budget INT,
    description VARCHAR2(50),
	project_name VARCHAR2(20),
	PRIMARY key (campaign_id),
    FOREIGN KEY (project_name) REFERENCES project1(project_name)
);

INSERT INTO Campaigns values (1,15000, 'Online and TV campaign','Dark');
INSERT INTO Campaigns values (2,10000, 'Social media and influencer marketing','Friends');
INSERT INTO Campaigns values (3, 20000, 'Marketing in reality shows','Stranger Things');
COMMIT;

SELECT c1.campaign_id, c1.c_budget, c1.description, c1.project_name,
       c2.campaign_id AS c2_campaign_id, c2.project_name AS c2_project_name,
       c2.start_date, c2.end_date
FROM Campaigns c1
JOIN Campaigns@site_link c2 ON c1.campaign_id =c2.campaign_id;



CREATE OR REPLACE TRIGGER t10 
AFTER INSERT 
ON Campaigns
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/
