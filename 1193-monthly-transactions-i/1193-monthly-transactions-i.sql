-- # Write your MySQL query statement below
-- -- 각 월 및 국가별로 전체 거래 건수와 총액, 그리고 승인된 거래 건수와 총액을 구하는 SQL 쿼리를 작성하세요.

-- With trans AS (
--     select DATE_FORMAT(trans_date, '%Y-%m') as month, 
--     country, 
--     count(*) as trans_count, 
--     sum(amount) as trans_total_amount
--     from transactions
--     group by DATE_FORMAT(trans_date, '%Y-%m'), country
-- )
-- , approved as (
--     select DATE_FORMAT(trans_date, '%Y-%m') as month, 
--     country, 
--     count(*) as approved_count, 
--     sum(amount) as approved_total_amount
--     from transactions
--     where state = 'approved'
--     group by DATE_FORMAT(trans_date, '%Y-%m'), country
-- )


-- select 
-- trans.month, 
-- trans.country, 
-- trans_count, 
-- ifnull(approved_count,0) as approved_count, 
-- trans_total_amount, 
-- ifnull(approved_total_amount,0) as approved_total_amount
-- from trans
-- left join approved
-- on trans.month = approved.month 
-- and trans.country = approved.country


WITH trans AS (
    SELECT 
        DATE_FORMAT(trans_date, '%Y-%m') AS month, 
        country, 
        COUNT(*) AS trans_count, 
        SUM(amount) AS trans_total_amount
    FROM transactions
    GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country
),
approved AS (
    SELECT 
        DATE_FORMAT(trans_date, '%Y-%m') AS month, 
        country, 
        COUNT(*) AS approved_count, 
        SUM(amount) AS approved_total_amount
    FROM transactions
    WHERE state = 'approved'
    GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country
)

SELECT 
    trans.month, 
    trans.country, 
    trans_count, 
    IFNULL(approved_count, 0) AS approved_count, 
    trans_total_amount, 
    IFNULL(approved_total_amount, 0) AS approved_total_amount
FROM trans
LEFT JOIN approved
    ON trans.month = approved.month 
    -- 💡 핵심 수정: country가 NULL일 경우를 대비해 COALESCE로 빈 문자열 등으로 치환하여 비교
    AND COALESCE(trans.country, '') = COALESCE(approved.country, '')