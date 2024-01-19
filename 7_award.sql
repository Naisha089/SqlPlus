drop table Award;
CREATE TABLE Award (
  Award_Id NUMBER,
  Award_Name VARCHAR2(30),
  gender varchar(20),
  Project_name VARCHAR2(20),
  PRIMARY key (Award_Id),
  FOREIGN KEY (Project_name) REFERENCES Project1(Project_name)
);
  
INSERT INTO Award VALUES (4, 'Best Actor','Male', 'Nun');
INSERT INTO Award VALUES (5, 'Best Actor','Male', 'Vampire Diaries');
INSERT INTO Award VALUES (6, 'Best Supporting Actor','Male', 'Barbie');
commit;

select * from Award union  select * from Award@site_link ;

--select * from Award;

CREATE OR REPLACE TRIGGER t7  
AFTER INSERT 
ON Award
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('new value');
END;
/