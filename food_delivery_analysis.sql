USE food_delivery_db;

SELECT COUNT(DISTINCT `Order ID`) AS total_orders
FROM food_delivery;

SELECT SUM(`Total`) AS total_revenue
FROM food_delivery
WHERE `Order Status` = 'Delivered';
SELECT AVG(`Total`) AS avg_order_value
FROM food_delivery
WHERE `Order Status` = 'Delivered';

SELECT `Restaurant name`,
       COUNT(*) AS total_orders
FROM food_delivery
GROUP BY `Restaurant name`
ORDER BY total_orders DESC;

SELECT `Restaurant name`,
       SUM(`Total`) AS revenue
FROM food_delivery
WHERE `Order Status` = 'Delivered'
GROUP BY `Restaurant name`
ORDER BY revenue DESC;

SELECT `Restaurant name`,
       SUM(`Total`) AS revenue
FROM food_delivery
WHERE `Order Status` = 'Delivered'
GROUP BY `Restaurant name`
ORDER BY revenue DESC
LIMIT 10;

SELECT City,
       COUNT(*) AS total_orders
FROM food_delivery
GROUP BY City
ORDER BY total_orders DESC;

SELECT HOUR(`Order Placed At`) AS order_hour,
       COUNT(*) AS total_orders
FROM food_delivery
GROUP BY order_hour
ORDER BY total_orders DESC;

SELECT DAYNAME(`Order Placed At`) AS day_name,
       COUNT(*) AS total_orders
FROM food_delivery
GROUP BY day_name
ORDER BY total_orders DESC;

SELECT DATE_FORMAT(`Order Placed At`, '%Y-%m') AS month,
       SUM(`Total`) AS revenue
FROM food_delivery
WHERE `Order Status` = 'Delivered'
GROUP BY month
ORDER BY month;

SELECT `Order Status`,
       COUNT(*) AS total_orders,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM food_delivery
GROUP BY `Order Status`;

SELECT `Cancellation / Rejection reason`,
       COUNT(*) AS occurrences
FROM food_delivery
WHERE `Cancellation / Rejection reason` IS NOT NULL
GROUP BY `Cancellation / Rejection reason`
ORDER BY occurrences DESC;

SELECT
ROUND(
    SUM(CASE WHEN `Order Status` IN ('Canceled','Rejected') THEN 1 ELSE 0 END)
    * 100.0 / COUNT(*), 2
) AS cancellation_rate
FROM food_delivery;

SELECT AVG(`KPT duration (minutes)`) AS avg_kpt
FROM food_delivery
WHERE `Order Status` = 'Delivered';

SELECT AVG(`Rider wait time (minutes)`) AS avg_rider_wait
FROM food_delivery
WHERE `Order Status` = 'Delivered';

SELECT
    `Restaurant name`,
    COUNT(*) AS orders,
    SUM(`Total`) AS revenue,
    ROUND(AVG(`Total`), 2) AS avg_order_value
FROM food_delivery
WHERE `Order Status` = 'Delivered'
GROUP BY `Restaurant name`
ORDER BY revenue DESC;

SELECT
    `Customer ID`,
    COUNT(*) AS order_count
FROM food_delivery
GROUP BY `Customer ID`
ORDER BY order_count DESC;

SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT `Customer ID`
    FROM food_delivery
    GROUP BY `Customer ID`
    HAVING COUNT(*) > 1
) AS customers;

SELECT
    `Restaurant name`,
    ROUND(AVG(Rating), 2) AS avg_rating
FROM food_delivery
WHERE Rating IS NOT NULL
GROUP BY `Restaurant name`
ORDER BY avg_rating DESC;

SELECT
    `Restaurant name`,
    COUNT(*) AS rated_orders,
    ROUND(AVG(Rating), 2) AS avg_rating
FROM food_delivery
WHERE Rating IS NOT NULL
GROUP BY `Restaurant name`
ORDER BY avg_rating DESC;

SELECT
    `Restaurant name`,
    SUM(`Restaurant discount (Promo)`) AS promo_discount,
    SUM(`Restaurant discount (Flat offs, Freebies & others)`) AS other_discount,
    SUM(`Gold discount`) AS gold_discount,
    SUM(`Brand pack discount`) AS brand_pack_discount
FROM food_delivery
GROUP BY `Restaurant name`
ORDER BY promo_discount DESC;

SELECT
    Delivery,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN `Order Status` = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders
FROM food_delivery
GROUP BY Delivery
ORDER BY total_orders DESC;

SELECT
    Distance,
    COUNT(*) AS total_orders,
    ROUND(AVG(`Total`), 2) AS avg_order_value
FROM food_delivery
GROUP BY Distance
ORDER BY total_orders DESC;

SELECT
    HOUR(`Order Placed At`) AS order_hour,
    COUNT(*) AS orders,
    SUM(`Total`) AS revenue
FROM food_delivery
WHERE `Order Status` = 'Delivered'
GROUP BY order_hour
ORDER BY revenue DESC;

SELECT
    `Restaurant name`,
    COUNT(*) AS orders,
    SUM(`Total`) AS revenue,
    ROUND(AVG(`Total`), 2) AS avg_order_value
FROM food_delivery
WHERE `Order Status` = 'Delivered'
GROUP BY `Restaurant name`
ORDER BY revenue DESC, orders DESC;
