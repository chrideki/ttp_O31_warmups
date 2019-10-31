-- 1) Go back to the dvdrental database, and get the average, standard deviation, and count
-- of each customer's lifetime spending. (This is a lot like yesterday's warmup).

WITH customer_lifetime_spending AS(
    SELECT customer_id, SUM(amount) AS lifetime_spending
    FROM payment
    GROUP BY customer_id
) SELECT 
    ROUND(AVG(lifetime_spending), 2) AS avg_lifetime_spending, 
    ROUND(stddev(lifetime_spending), 2) AS sd_lifetime_spending, 
    COUNT(lifetime_spending)
    FROM customer_lifetime_spending;

 avg_lifetime_spending | sd_lifetime_spending | count 
-----------------------+----------------------+-------
                102.36 |                25.23 |   599


-- 2) Your boss is absolutely certain (like 99%) that his new marketing strategy will increase
-- average customer spending by more than 10%, making the company an extra $100,000+ next year.
-- This is based on the fact that our company has about 10,000 customers, and his assumption
-- is that each customer is currently worth at least $100 in yearly spending. 
-- Your boss has already made this promise to the CEO.

-- Given our data (which is only a sample out of all of our customers), and that we want to be 99%
-- confident that our plan is going to work, we want compelling evidence that the TRUE customer 
-- average spending per year is more than $100. 
-- (USE at least 2 significant digits for your analysis)

-- Is the plan going to work? 
-- If not at 99% confidence, what about 95%?
-- If yes at 99%, what about 99.5%?
-- At which level of confidence can he tell the CEO that the plan is going to work?

With a level of confidence of 99% we fail to reject the null hypoteshis (p-value > alpha), so we have no sufficient evidence 
to support the claim that the customer average spending per year is more than 100$.

With a level of confidence of 95% we can reject the null hypoteshis (p-value < alpha), so that we have sufficient evidence
to support the claim that the customer average spending per year is more than 100$.

-- BONUS:
-- If you still have time, get the count, average, and standard deviation of customer spending
-- for each store. Can you set up a hypothesis test to say if there's a statistically meaningful
-- difference between the two stores? Check chapter 12.

WITH customer_lifetime_spending AS(
    SELECT customer_id, SUM(amount) AS lifetime_spending, store_id
    FROM payment
    JOIN customer USING(customer_id)
    GROUP BY store_id, customer_id
) SELECT 
    store_id,
    ROUND(AVG(lifetime_spending), 2) AS avg_lifetime_spending, 
    ROUND(stddev(lifetime_spending), 2) AS sd_lifetime_spending, 
    COUNT(lifetime_spending)
    FROM customer_lifetime_spending
    GROUP BY store_id;

 store_id | avg_lifetime_spending | sd_lifetime_spending | count 
----------+-----------------------+----------------------+-------
        2 |                101.43 |                26.23 |   273
        1 |                103.13 |                24.38 |   326

F-score 0.863914616 is greater than critical F-score 0.826521886.
So the variability in lifetime spending per customer is significally different in the two store.