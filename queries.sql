CONNECT TO SE3DB3;

/* Q1: Get the total number of records in the players table.*/
SELECT COUNT(*) FROM PLAYER_MAST;

/* Q2:  Display all records in the players table.*/
SELECT * FROM PLAYER_MAST;

/* Q3i: Get the number of countries that participated in Euro Cup 2016.*/
SELECT COUNT(DISTINCT COUNTRY_ID) FROM SOCCER_COUNTRY;

/* Q3ii: How many goals were scored during extra time (ET) in the entire tournament? */
SELECT COUNT(*) FROM GOAL_DETAILS WHERE GOAL_SCHEDULE = 'ET';

/* Q3iii: How many goals were scored during stopage time (ST) in the entire tournament?*/
SELECT COUNT(*) FROM GOAL_DETAILS WHERE GOAL_SCHEDULE = 'ST';

/* Q3iv: How many goals were scored during normal time (NT) in the entire tournament?*/
SELECT COUNT(*) FROM GOAL_DETAILS WHERE GOAL_SCHEDULE = 'NT';

/* Q3v: Get the number of bookings that happened during stoppage time.*/
SELECT COUNT(BOOKING_TIME) FROM PLAYER_BOOKED WHERE PLY_SCHEDULE = 'ST';

/* Q3vi: Get the number of bookings that happened during extra time. */
SELECT COUNT(*) FROM PLAYER_BOOKED WHERE PLAY_SCHEDULE = 'ET';

/* Q4i: Get the date when the first match was played in Euro Cup 2016.*/
SELECT MIN(PLAY_DATE) FROM MATCH_MAST;

/* Q4ii: Get the date when the last match was played in Euro Cup 2016. */
SELECT MAX(PLAY_DATE) FROM MATCH_MAST;

/* Q5i: Get names of countries whose teams played the first match in Euro cup 2016.*/
SELECT  DISTINCT CN.COUNTRY_NAME 
FROM SOCCER_COUNTRY CN, SOCCER_TEAM TN, MATCH_MAST MN, MATCH_DETAILS DN 
WHERE CN.COUNTRY_ID = TN.COUNTRY_ID AND TN.TEAM_ID = DN.TEAM_ID AND DN.MATCH_NO = MN.MATCH_NO AND MN.MATCH_NO = 1;

/* Q5ii:  Get name of the country whose team won the final match of Euro cup 2016.*/
SELECT  DISTINCT CN.COUNTRY_NAME 
FROM SOCCER_COUNTRY CN, SOCCER_TEAM TN, MATCH_MAST MN, MATCH_DETAILS DN
WHERE CN.COUNTRY_ID = TN.COUNTRY_ID AND TN.TEAM_ID = DN.TEAM_ID AND DN.MATCH_NO = MN.MATCH_NO AND DN.PLAY_STAGE = 'F' AND DN.WIN_LOSE = 'W';

/* Q6i: Get names of countries with the number of penalty shots by their teams.*/
SELECT DISTINCT CN.COUNTRY_NAME, COUNT(*) 
FROM SOCCER_COUNTRY CN, SOCCER_TEAM TN, PENALTY_SHOOTOUT PN 
WHERE CN.COUNTRY_ID = TN.COUNTRY_ID AND TN.TEAM_ID = PN.TEAM_ID 
GROUP BY CN.COUNTRY_NAME;

/* Q6ii: Get names of countries whose teams played the final match of Euro cup 2016.*/
SELECT DISTINCT CN.COUNTRY_NAME
FROM SOCCER_COUNTRY CN, SOCCER_TEAM TN, MATCH_MAST MN, MATCH_DETAILS DN 
WHERE CN.COUNTRY_ID = TN.COUNTRY_ID 
AND TN.TEAM_ID = DN.TEAM_ID 
AND DN.MATCH_NO = MN.MATCH_NO 
AND DN.PLAY_STAGE in (SELECT D.PLAY_STAGE FROM MATCH_DETAILS D WHERE D.PLAY_STAGE='F');

/* Q6iii: Use a subquery with IN operator to get the dates when matches with penalty shootouts were player.*/
SELECT PLAY_DATE FROM MATCH_MAST WHERE MATCH_NO IN (SELECT MATCH_NO FROM PENALTY_SHOOTOUT);

/* Q6iv: Get names of venues where penalty shootout matches were played.*/
SELECT V.VENUE_NAME 
FROM SOCCER_VENUE V, MATCH_MAST M
WHERE M.VENUE_ID = V.VENUE_ID AND M.MATCH_NO
IN (SELECT DISTINCT P.MATCH_NO FROM PENALTY_SHOOTOUT P);

/* Q6v: Get the total number of players of the French team that participated in the final match.*/
SELECT COUNT(*) + 11 
FROM SOCCER_COUNTRY CN, SOCCER_TEAM TN, PLAYER_IN_OUT PIO
WHERE CN.COUNTRY_NAME = 'France' 
AND CN.COUNTRY_ID = TN.COUNTRY_ID 
AND TN.TEAM_ID = PIO.TEAM_ID 
AND PIO.IN_OUT = 'I' 
AND PIO.MATCH_NO = (SELECT MAX(MATCH_NO) FROM MATCH_DETAILS);














