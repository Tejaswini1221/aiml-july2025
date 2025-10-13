SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
INNER JOIN t2
ON t1.CustomerID = t2.CustomerID;



SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
LEFT OUTER JOIN t2
ON t1.CustomerID = t2.CustomerID;


SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
LEFT JOIN t2
ON t1.CustomerID = t2.CustomerID;


SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
RIGHT OUTER JOIN t2
ON t1.CustomerID = t2.CustomerID;


SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
RIGHT JOIN t2
ON t1.CustomerID = t2.CustomerID;


SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
FULL OUTER JOIN t2
ON t1.CustomerID = t2.CustomerID;


SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
LEFT JOIN t2
ON t1.CustomerID = t2.CustomerID
WHERE t2.CustomerID IS NULL

UNION

SELECT 
    t1.ProductID, t1.ProductName, t1.Category, t1.Price,
    t2.CustomerID, t2.CustomerName, t2.City, t2.Country
FROM t1
RIGHT JOIN t2
ON t1.CustomerID = t2.CustomerID
WHERE t1.CustomerID IS NULL;
