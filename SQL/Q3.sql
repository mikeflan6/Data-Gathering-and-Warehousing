SELECT 
    i.County_ID,
    SUM(CASE WHEN i.Species_ID = 'SP01' THEN 1 ELSE 0 END) AS SP01,
    SUM(CASE WHEN i.Species_ID = 'SP02' THEN 1 ELSE 0 END) AS SP02,
    SUM(CASE WHEN i.Species_ID = 'SP03' THEN 1 ELSE 0 END) AS SP03,
    SUM(CASE WHEN i.Species_ID = 'SP04' THEN 1 ELSE 0 END) AS SP04,
    SUM(CASE WHEN i.Species_ID = 'SP05' THEN 1 ELSE 0 END) AS SP05,
    SUM(CASE WHEN i.Species_ID = 'SP06' THEN 1 ELSE 0 END) AS SP06,
    SUM(CASE WHEN i.Species_ID = 'SP07' THEN 1 ELSE 0 END) AS SP07,
    SUM(CASE WHEN i.Species_ID = 'SP08' THEN 1 ELSE 0 END) AS SP08,
    COUNT(i.Tree_ID) AS Total
FROM 
    inventory i
LEFT JOIN 
    logs l ON i.Tree_ID = l.Tree_ID
WHERE 
    l.Tree_ID IS NULL
GROUP BY 
    i.County_ID
ORDER BY 
    i.County_ID;
