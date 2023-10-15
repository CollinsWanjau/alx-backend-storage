-- we rank the country origins of bands by number of fans using the SELECT 
-- statement. We group the results by the origin column and count the 
-- number of bands for each origin using the SUM(*).
-- We then order the results by the number of fans in descending 
-- order using the ORDER BY clause.
SELECT origin, SUM(fans) as nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;
