<<<<<<< HEAD
-- ------------------------------------------------------------------
-- Title: Count the number of patients with a specific icd9 code above a certain age
-- MIMIC version: MIMIC-III v1.3
-- Notes: this query does not specify a schema. To run it on your local
-- MIMIC schema, run the following command:
-- SET SEARCH_PATH TO mimiciii;
-- Where "mimiciii" is the name of your schema, and may be different.
-- Reference: tompollard, alistairewj, erinhong for code taken
-- from sodium.sql on the MIMIC III github repository
-- ------------------------------------------------------------------

WITH agetbl AS 
	(
	SELECT ad.subject_id 
	FROM admissions ad 
	INNER JOIN patients p 
	ON ad.subject_id = p.subject_id 
	WHERE 
	-- filter to only adults above 30
	EXTRACT(EPOCH FROM (ad.admittime - p.dob))/60.0/60.0/24.0/365.242 > 30
	-- group by subject_id to ensure there is only 1 subject_id per row
	GROUP BY ad.subject_id
	) 
SELECT COUNT(DISTINCT dia.subject_id) 
AS "Hypertension Age 30+" 
FROM diagnoses_icd dia 
INNER JOIN agetbl 
ON dia.subject_id = agetbl.subject_id 
WHERE dia.icd9_code 
-- 401% relates to Hypertension
=======
-- ------------------------------------------------------------------
-- Title: Count the number of patients with a specific icd9 code above a certain age
-- MIMIC version: MIMIC-III v1.3
-- Notes: this query does not specify a schema. To run it on your local
-- MIMIC schema, run the following command:
-- SET SEARCH_PATH TO mimiciii;
-- Where "mimiciii" is the name of your schema, and may be different.
-- Reference: tompollard, alistairewj, erinhong for code taken
-- from sodium.sql on the MIMIC III github repository
-- ------------------------------------------------------------------

WITH agetbl AS 
	(
	SELECT ad.subject_id 
	FROM admissions ad 
	INNER JOIN patients p 
	ON ad.subject_id = p.subject_id 
	WHERE 
	-- filter to only adults above 30
	EXTRACT(EPOCH FROM (ad.admittime - p.dob))/60.0/60.0/24.0/365.242 > 30
	-- group by subject_id to ensure there is only 1 subject_id per row
	GROUP BY ad.subject_id
	) 
SELECT COUNT(DISTINCT dia.subject_id) 
AS "Hypertension Age 30+" 
FROM diagnoses_icd dia 
INNER JOIN agetbl 
ON dia.subject_id = agetbl.subject_id 
WHERE dia.icd9_code 
-- 401% relates to Hypertension
>>>>>>> 3df505bfdb19c2a24126a76ce404e9e5282c503b
LIKE '401%';