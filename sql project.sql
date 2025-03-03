CREATE DATABASE zomato_db;
USE zomato_db;

# Find the most reviewed restaurants
select * from `zomato-data`;
SELECT name, rate, votes FROM `zomato-data` 
ORDER BY rate DESC, votes DESC 
LIMIT 10;

# Find restaurants that offer both online ordering and table booking
SELECT name FROM `zomato-data` 
WHERE online_order = 'Yes' AND book_table = 'Yes';

ALTER TABLE `zomato-data` 
CHANGE COLUMN `approx_cost(for two people)` approx_cost INT,
CHANGE COLUMN `listed_in(type)` listed_in_type VARCHAR(100);

SHOW COLUMNS FROM `zomato-data`;

# Get the average cost per category
SELECT listed_in_type, AVG(approx_cost) AS avg_cost 
FROM `zomato-data`
GROUP BY listed_in_type;

# Count the number of restaurants per category
SELECT listed_in_type, COUNT(*) AS restaurant_count 
FROM `zomato-data` 
GROUP BY listed_in_type;

# Find the most reviewed restaurants
SELECT name, votes FROM `zomato-data`
ORDER BY votes DESC 
LIMIT 10;

# Find restaurants with ratings above 4.0 and more than 500 votes
SELECT name, rate, votes FROM `zomato-data`
WHERE rate > 4.0 AND votes > 500;

# Find restaurants where online ordering is not available but table booking is available
SELECT name FROM `zomato-data` 
WHERE online_order = 'No' AND book_table = 'Yes';

# Get the minimum and maximum cost for two people per category
SELECT listed_in_type, MIN(approx_cost) AS min_cost, MAX(approx_cost) AS max_cost 
FROM `zomato-data`
GROUP BY listed_in_type;

# Get the total number of restaurants that allow online ordering
SELECT COUNT(*) AS total_online_order_restaurants FROM `zomato-data` 
WHERE online_order = 'Yes';

# Get the total number of restaurants that allow table booking
SELECT COUNT(*) AS total_table_booking_restaurants FROM `zomato-data`
WHERE book_table = 'Yes';

# Get the percentage of restaurants that allow online ordering
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `zomato-data`)) AS percentage_online_order
FROM `zomato-data` WHERE online_order = 'Yes';

# Get the top 5 most common restaurant categories
SELECT listed_in_type, COUNT(*) AS category_count 
FROM `zomato-data`
GROUP BY listed_in_type; 

# Find restaurants with the highest cost for two people
SELECT name, approx_cost FROM `zomato-data`
ORDER BY approx_cost DESC 
LIMIT 10;

# Find restaurants with the lowest cost for two people
SELECT name, approx_cost FROM `zomato-data`
ORDER BY approx_cost ASC 
LIMIT 10;

 # Get the average rating per category
SELECT listed_in_type, AVG(rate) AS avg_rating 
FROM `zomato-data` 
GROUP BY listed_in_type;

# Fix rate column: Convert '4.1/5' to 4.1
UPDATE `zomato-data` SET rate = CAST(SUBSTRING_INDEX(rate, '/', 1) AS DECIMAL(3,1));

# Find Restaurants with No Ratings
SELECT name FROM `zomato-data`
WHERE rate IS NULL OR rate = 0;

# Find Restaurants with Highest & Lowest Votes
SELECT name, votes FROM `zomato-data`
ORDER BY votes DESC 
LIMIT 5;

SELECT name, votes FROM `zomato-data` 
ORDER BY votes ASC 
LIMIT 5;

# Find Restaurants with Cost Between ₹500 and ₹1000
SELECT name, approx_cost FROM `zomato-data`
WHERE approx_cost BETWEEN 500 AND 1000;

# Find Restaurants with Above Average Ratings
SELECT name, rate FROM `zomato-data` 
WHERE rate > (SELECT AVG(rate) FROM `zomato-data`)
ORDER BY rate DESC;

# Get the Most Common Price Point
SELECT approx_cost, COUNT(*) AS frequency 
FROM `zomato-data` 
GROUP BY approx_cost 
ORDER BY frequency DESC 
LIMIT 1;

# Count Restaurants that Offer Online Order But Not Table Booking
SELECT COUNT(*) AS count_restaurants FROM `zomato-data` 
WHERE online_order = 'Yes' AND book_table = 'No';

# Count Restaurants with a Rating Above 4.5
SELECT COUNT(*) AS high_rated_restaurants FROM `zomato-data`
WHERE rate > 4.5;

# Find Restaurants with Maximum Votes in Each Category
SELECT listed_in_type, name, votes FROM `zomato-data` AS z1
WHERE votes = (SELECT MAX(votes) FROM `zomato-data` AS z2 WHERE z1.listed_in_type = z2.listed_in_type);

# Find Restaurants Offering Both Online and Table Booking with High Ratings
SELECT name, rate FROM `zomato-data`
WHERE online_order = 'Yes' AND book_table = 'Yes' AND rate > 4.0
ORDER BY rate DESC;

# Find Top 3 Most Expensive Restaurant Categories
SELECT listed_in_type, AVG(approx_cost) AS avg_cost 
FROM `zomato-data`
GROUP BY listed_in_type 
ORDER BY avg_cost DESC 
LIMIT 3;

# Find Restaurants Grouped by Rating Ranges (3-4, 4-4.5, etc.)
SELECT 
    CASE 
        WHEN rate >= 4.5 THEN 'Excellent (4.5-5.0)'
        WHEN rate >= 4.0 THEN 'Good (4.0-4.5)'
        WHEN rate >= 3.5 THEN 'Average (3.5-4.0)'
        ELSE 'Low (Below 3.5)'
    END AS rating_category,
    COUNT(*) AS restaurant_count
FROM `zomato-data`
GROUP BY rating_category;

# Get the Average Rating of Restaurants Per Cost Range
SELECT 
    CASE 
        WHEN approx_cost < 500 THEN 'Budget (<500)'
        WHEN approx_cost BETWEEN 500 AND 1000 THEN 'Mid-range (500-1000)'
        ELSE 'Premium (>1000)'
    END AS cost_category,
    AVG(rate) AS avg_rating
FROM `zomato-data`
GROUP BY cost_category;

# Find Restaurants That Charge More Than Average Price but Have Low Ratings (< 3.5)
SELECT name, approx_cost, rate FROM `zomato-data` 
WHERE approx_cost > (SELECT AVG(approx_cost) FROM `zomato-data`)
AND rate < 3.5;

# Identify the Least Popular Restaurant Categories
SELECT listed_in_type, COUNT(*) AS count 
FROM `zomato-data` 
GROUP BY listed_in_type 
ORDER BY count ASC 
LIMIT 5;

#Find the Most Expensive Restaurant in Each Category
SELECT listed_in_type, name, approx_cost FROM `zomato-data` AS z1
WHERE approx_cost = (SELECT MAX(approx_cost) FROM `zomato-data` AS z2 WHERE z1.listed_in_type = z2.listed_in_type);

#Count the Restaurants That Have Zero Votes
SELECT COUNT(*) AS no_vote_restaurants FROM `zomato-data`
WHERE votes = 0 OR votes IS NULL;

# Find Restaurant Categories with the Highest Ratings on Average
SELECT listed_in_type, AVG(rate) AS avg_rating 
FROM `zomato-data` 
GROUP BY listed_in_type 
ORDER BY avg_rating DESC 
LIMIT 5;

# Get Restaurants with Highest Revenue Potential (Assuming Avg. Orders = Votes * Approx Cost)
SELECT name, votes * approx_cost AS estimated_revenue 
FROM `zomato-data`
ORDER BY estimated_revenue DESC 
LIMIT 10;

# Finding Restaurants With Mid-Range Pricing
SELECT name, approx_cost 
FROM `zomato-data`
WHERE approx_cost BETWEEN 300 AND 800 
ORDER BY approx_cost ASC;

# Most Common Approximate Cost
SELECT approx_cost, COUNT(*) AS frequency 
FROM `zomato-data` 
GROUP BY approx_cost 
ORDER BY frequency DESC 
LIMIT 1;

# Finding The Least Popular Restaurant Category
SELECT listed_in_type, COUNT(*) AS total 
FROM `zomato-data` 
GROUP BY listed_in_type 
ORDER BY total ASC 
LIMIT 1;

# Most Expensive and Cheapest Restaurant Per Category
SELECT listed_in_type, 
       MAX(approx_cost) AS max_cost, 
       MIN(approx_cost) AS min_cost 
FROM `zomato-data` 
GROUP BY listed_in_type;

# Restaurants With Maximum Revenue Potential
SELECT name, votes * approx_cost AS estimated_revenue 
FROM `zomato-data` 
ORDER BY estimated_revenue DESC 
LIMIT 10;






















