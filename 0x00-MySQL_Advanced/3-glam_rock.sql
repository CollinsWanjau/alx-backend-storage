-- This query uses the IFNULL function to check if the split column is NULL. 
-- If it is NULL, the function returns the value '2022', which represents the 
-- current year. Otherwise, it returns the value of the split column.
SELECT band_name, (IFNULL(split, '2022') - formed) AS lifespan
FROM metal_bands
WHERE style LIKE '%Glam rock%'
ORDER BY lifespan DESC;
