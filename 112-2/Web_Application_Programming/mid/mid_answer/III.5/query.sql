/* a */
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
ORDER BY OrderCount DESC
LIMIT 1;


/* b */
WITH OrderCounts AS (
    SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS OrderCount
    FROM Customers
    JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    GROUP BY Customers.CustomerName
)
SELECT CustomerName, OrderCount
FROM OrderCounts
WHERE OrderCount = (SELECT MAX(OrderCount) FROM OrderCounts);


/* c */
WITH ConfirmedOrders AS (
    SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS OrderCount
    FROM Customers
    JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    WHERE Orders.Checked = 1
    GROUP BY Customers.CustomerName
)
SELECT CustomerName, OrderCount
FROM ConfirmedOrders
WHERE OrderCount = (SELECT MAX(OrderCount) FROM ConfirmedOrders);