# Write your MySQL query statement below
-- 모든 고객의 첫 주문 중 즉시 주문이 차지하는 비율을 소수점 셋째 자리에서 반올림하여 소수점 둘째 자리까지 구하는 쿼리를 작성하세요.

Select
    ROUND(AVG(
        case 
            when order_date = customer_pref_delivery_date
            then 1
            else 0
        end
    ),4) * 100
    as immediate_percentage
FROM 
delivery
where (customer_id, order_date) in
(Select customer_id, MIN(order_date)
from delivery
group by customer_id)