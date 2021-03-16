---------------------------------------------------------------------
---> Randomizing functions
---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION randomdate (d1 TIMESTAMP, d2 TIMESTAMP) RETURN DATE
AS
BEGIN
  RETURN TO_TIMESTAMP(EXTRACT(EPOCH FROM d1) + RANDOMINT(FLOOR(EXTRACT(EPOCH FROM d2) - EXTRACT(EPOCH FROM d1))::INT));
END;

CREATE OR REPLACE FUNCTION randomdata (id INT, field VARCHAR, cp BOOLEAN, geo VARCHAR) RETURN VARCHAR
AS
BEGIN
   RETURN
        CASE
            WHEN geo = 'pushpin' THEN (1-(random()*2))::INT*40 || ';' || ((2-(random()*6))::INT*90) -- generating a random pushpin
            WHEN cp is TRUE THEN id::INT || '_' || field -- when field is cp it will gereate within a limit for a dim table, default is 100
            ELSE (random()*id)::INT || '_' || field -- for other attributes it's a variety of X values, default is 30
        END;
END;

CREATE OR REPLACE FUNCTION randomfact (minimum INT, maximum INT) RETURN INT
AS
BEGIN
   RETURN (random()*ABS(maximum-minimum))::INT +
        CASE WHEN maximum > minimum THEN minimum
        ELSE maximum END;
END;
