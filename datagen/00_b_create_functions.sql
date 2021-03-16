---------------------------------------------------------------------
---> Randomizing functions
---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION randomcustomdata(values VARCHAR) RETURN VARCHAR
AS
BEGIN
   RETURN
   	CASE
		WHEN values LIKE '%,%' THEN TRIM(SPLIT_PART(values,',', (FLOOR(RANDOM() * (REGEXP_COUNT(values,',') + 1) + 1 ))::INT))
		WHEN values LIKE '%-%' THEN randomfact(SPLIT_PART(values,'-',1)::INT, SPLIT_PART(values,'-',2)::INT)::VARCHAR
	END;
END;
