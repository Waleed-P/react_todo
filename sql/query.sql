CREATE TABLE Users (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Registration_Date DATE NOT NULL
);
CREATE TABLE Products (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);
CREATE TABLE Transactions (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Date DATE NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE
);
CREATE TABLE Transaction_Details (
    Transaction_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (Transaction_ID, Product_ID),
    FOREIGN KEY (Transaction_ID) REFERENCES Transactions(Transaction_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE
);


INSERT INTO Users (Name, Email, Registration_Date) VALUES
('Alice Johnson', 'alice@example.com', '2025-01-01'),
('Bob Smith', 'bob@example.com', '2025-01-02'),
('Charlie Brown', 'charlie@example.com', '2025-01-03'),
('Diana Prince', 'diana@example.com', '2025-01-04'),
('Ethan Hunt', 'ethan@example.com', '2025-01-05');
INSERT INTO Products (Name, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 800.00, 10),
('Headphones', 'Electronics', 50.00, 20),
('Keyboard', 'Electronics', 30.00, 15),
('Chair', 'Furniture', 100.00, 5),
('Desk', 'Furniture', 200.00, 8),
('Mouse', 'Electronics', 25.00, 25),
('Monitor', 'Electronics', 150.00, 7),
('Couch', 'Furniture', 500.00, 3),
('Phone', 'Electronics', 600.00, 12),
('Lamp', 'Furniture', 45.00, 10);

INSERT INTO Transactions (User_ID, Date) VALUES
(1, '2025-01-10'),
(2, '2025-01-12'),
(3, '2025-01-15');

INSERT INTO Transaction_Details (Transaction_ID, Product_ID, Quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(2, 5, 1),
(3, 6, 4),
(3, 7, 1);

-- Retrieve users with purchases in the last 30 days
SELECT DISTINCT U.User_ID, U.Name, U.Email
FROM Users U
JOIN Transactions T ON U.User_ID = T.User_ID
WHERE T.Date >= CURDATE() - INTERVAL 30 DAY;

-- Identify top 3 products by purchase frequency
SELECT P.Product_ID, P.Name, SUM(TD.Quantity) AS Purchase_Frequency
FROM Products P
JOIN Transaction_Details TD ON P.Product_ID = TD.Product_ID
GROUP BY P.Product_ID, P.Name
ORDER BY Purchase_Frequency DESC
LIMIT 3;

-- Calculate revenue per product category
SELECT P.Category, SUM(TD.Quantity * P.Price) AS Total_Revenue
FROM Products P
JOIN Transaction_Details TD ON P.Product_ID = TD.Product_ID
GROUP BY P.Category;

-- Generate transaction summaries with item counts
SELECT T.Transaction_ID, T.Date, COUNT(TD.Product_ID) AS Total_Items
FROM Transactions T
JOIN Transaction_Details TD ON T.Transaction_ID = TD.Transaction_ID
GROUP BY T.Transaction_ID, T.Date;

--  Find users exceeding $500 in total purchases:
SELECT U.User_ID, U.Name, SUM(TD.Quantity * P.Price) AS Total_Spent
FROM Users U
JOIN Transactions T ON U.User_ID = T.User_ID
JOIN Transaction_Details TD ON T.Transaction_ID = TD.Transaction_ID
JOIN Products P ON TD.Product_ID = P.Product_ID
GROUP BY U.User_ID, U.Name
HAVING Total_Spent > 500;


