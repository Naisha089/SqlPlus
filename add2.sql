DECLARE
  p_post_management_1 NUMBER;
  p_post_management_2 NUMBER;
  p_post_management_3 NUMBER;
BEGIN
  SELECT SUM(Workers) INTO p_post_management_1 FROM Post_Management;
  SELECT SUM(Workers) INTO p_post_management_2 FROM Post_Management@site_link;
  
  p_post_management_3 := p_post_management_1 + p_post_management_2;
  
  DBMS_OUTPUT.PUT_LINE('Total Workers in Post_Management table: ' || p_post_management_3);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/