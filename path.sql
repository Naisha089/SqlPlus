drop TABLE Members;
CREATE TABLE Members (
  Member_Id NUMBER,
  Work_Type VARCHAR2(20),
  Studio_Id NUMBER,
  PRIMARY KEY (Member_Id),
  FOREIGN KEY (Studio_Id) REFERENCES Studio(Studio_Id)
);

INSERT INTO Members VALUES (201, 'Post Management', 1);

INSERT INTO Members VALUES (202,'Management', 2);

INSERT INTO Members VALUES (203,'Post Management',3);

commit;
SELECT m1.Member_Id, m1.Work_Type, m1.Studio_Id,
       m2.Member_Id AS m2_Member_Id,
	   m2.Member_Name,
       m2.Member_Number,
	   m2.Member_Address,
	   m2.Member_Email
FROM Members m1
JOIN Members@site_link m2 ON m1.Member_Id = m2.Member_Id;

CREATE OR REPLACE FUNCTION GetMemberInfo(
    p_member_id IN NUMBER
) RETURN VARCHAR2 AS
    v_member_name Members.Member_Name%TYPE;
    v_member_number Members.Member_Number%TYPE;
    v_studio_id Members.Studio_Id%TYPE;
BEGIN
    FOR i IN (
      SELECT Member_Name, Member_Number, Studio_Id
      FROM Members
      WHERE Member_Id = p_member_id
      Join
      SELECT Member_Name, Member_Number, Studio_Id
      FROM Members@site_link
      WHERE Member_Id = p_member_id
    ) LOOP
      v_member_name := i.Member_Name;
      v_member_number := i.Member_Number;
      v_studio_id := i.Studio_Id;
      
      RETURN 'Member Name: ' || v_member_name ||
             ', Member Number: ' || v_member_number ||
             ', Studio ID: ' || v_studio_id;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Member not found';
    WHEN OTHERS THEN
        RETURN 'Error occurred';
END GetMemberInfo;
/





