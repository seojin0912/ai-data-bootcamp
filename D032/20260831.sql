-- [C1] LMS(DuckDB) 준비 — BigQuery로 학습한다면 이 셀은 건너뛰세요.
-- BigQuery와 똑같은 `project_name.dataset_name.표` 이름을 쓸 수 있도록 이름 공간을 만듭니다.
ATTACH IF NOT EXISTS ':memory:' AS project_name;
CREATE SCHEMA IF NOT EXISTS project_name.dataset_name;

-- [C2]
CREATE OR REPLACE TABLE project_name.dataset_name.customers (
  customer_id STRING,
  name STRING,
  country STRING,
  signup_date DATE,
  grade STRING
);

INSERT INTO project_name.dataset_name.customers VALUES
  ('C001', '김민준', 'Korea', '2023-01-05', 'Gold'),
  ('C002', '이서연', 'Korea', '2023-02-11', 'Silver'),
  ('C003', '박도윤', 'Japan', '2023-02-20', 'Bronze'),
  ('C004', '최지우', 'USA', '2023-03-03', 'Gold'),
  ('C005', '정하준', 'Korea', '2023-03-15', 'Silver'),
  ('C006', '강서윤', 'Korea', '2023-04-01', 'Bronze'),
  ('C007', '조은우', 'Japan', '2023-04-18', 'Silver'),
  ('C008', '윤지호', 'USA', '2023-05-09', 'Gold'),
  ('C009', '임하은', 'Korea', '2023-05-22', 'Bronze'),
  ('C010', '한예준', 'Korea', '2023-06-02', 'Silver'),
  ('C011', '오시우', NULL, '2023-06-19', 'Bronze'),
  ('C012', '신아린', 'Japan', '2023-07-07', 'Silver'),
  ('C013', '권준서', 'Korea', '2023-07-25', 'Gold'),
  ('C014', '황지안', 'USA', '2023-08-10', NULL),
  ('C015', '안수아', 'Korea', '2023-08-28', 'Bronze') ;

  -- [C3]
CREATE OR REPLACE TABLE project_name.dataset_name.products (
  product_id STRING,
  product_name STRING,
  category STRING,
  price DECIMAL(12,2)
);

INSERT INTO project_name.dataset_name.products VALUES
  ('P01', '에어러너', 'Running', 89000),
  ('P02', '클래식 스니커즈', 'Sneakers', 65000),
  ('P03', '첼시 부츠', 'Boots', 145000),
  ('P04', '여름 샌들', 'Sandals', 38000),
  ('P05', '트레일 러너', 'Running', 119000),
  ('P06', '캔버스 스니커즈', 'Sneakers', 49000),
  ('P07', '워커 부츠', 'Boots', 175000),
  ('P08', '슬리퍼 샌들', 'Sandals', 25000),
  ('P09', '양말 세트', 'Accessory', 12000),
  ('P10', '운동화 끈', 'Accessory', 5000) ;

  -- [C4]
CREATE OR REPLACE TABLE project_name.dataset_name.orders (
  order_id STRING,
  customer_id STRING,
  order_date DATE,
  status STRING,
  amount DECIMAL(12,2)
);

INSERT INTO project_name.dataset_name.orders VALUES
  ('O0001', 'C001', '2023-09-02', 'Paid', 125000),
  ('O0002', 'C002', '2023-09-05', 'Shipped', 89000),
  ('O0003', 'C001', '2023-09-11', 'Returned', 45000),
  ('O0004', 'C003', '2023-09-15', 'Paid', 230000),
  ('O0005', 'C004', '2023-09-20', 'Cancelled', NULL),
  ('O0006', 'C005', '2023-09-25', 'Shipped', 67000),
  ('O0007', 'C002', '2023-10-01', 'Paid', 158000),
  ('O0008', 'C006', '2023-10-04', 'Placed', 32000),
  ('O0009', 'C007', '2023-10-12', 'Shipped', 410000),
  ('O0010', 'C008', '2023-10-19', 'Paid', 99000),
  ('O0011', 'C001', '2023-10-23', 'Paid', 76000),
  ('O0012', 'C009', '2023-10-28', 'Cancelled', NULL),
  ('O0013', 'C010', '2023-11-02', 'Shipped', 142000),
  ('O0014', 'C004', '2023-11-08', 'Paid', 88000),
  ('O0015', 'C011', '2023-11-13', 'Placed', 53000),
  ('O0016', 'C012', '2023-11-19', 'Shipped', 175000),
  ('O0017', 'C002', '2023-11-24', 'Returned', 61000),
  ('O0018', 'C013', '2023-11-29', 'Paid', 320000),
  ('O0019', 'C005', '2023-12-03', 'Paid', 47000),
  ('O0020', 'C008', '2023-12-09', 'Shipped', 215000),
  ('O0021', 'C014', '2023-12-14', 'Placed', 38000),
  ('O0022', 'C001', '2023-12-20', 'Paid', 134000),
  ('O0023', 'C015', '2023-12-25', 'Shipped', 92000),
  ('O0024', 'C007', '2024-01-03', 'Paid', 268000),
  ('O0025', 'C010', '2024-01-09', 'Cancelled', NULL),
  ('O0026', 'C003', '2024-01-15', 'Paid', 119000),
  ('O0027', 'C013', '2024-01-22', 'Shipped', 405000),
  ('O0028', 'C006', '2024-01-28', 'Paid', 58000),
  ('O0029', 'C004', '2024-02-04', 'Returned', 73000),
  ('O0030', 'C012', '2024-02-11', 'Paid', 187000) ;

  -- [C5]
CREATE OR REPLACE TABLE project_name.dataset_name.order_items (
  order_id STRING,
  product_id STRING,
  quantity INT64,
  unit_price DECIMAL(12,2)
);

INSERT INTO project_name.dataset_name.order_items VALUES
  ('O0001', 'P01', 1, 125000),
  ('O0002', 'P02', 2, 44500),
  ('O0003', 'P03', 1, 45000),
  ('O0004', 'P04', 2, 115000),
  ('O0006', 'P05', 1, 67000),
  ('O0007', 'P06', 2, 79000),
  ('O0008', 'P07', 1, 32000),
  ('O0009', 'P08', 2, 205000),
  ('O0010', 'P09', 1, 99000),
  ('O0011', 'P01', 2, 38000),
  ('O0013', 'P02', 1, 142000),
  ('O0014', 'P03', 2, 44000),
  ('O0015', 'P04', 1, 53000),
  ('O0016', 'P05', 2, 87500),
  ('O0017', 'P06', 1, 61000),
  ('O0018', 'P07', 2, 160000),
  ('O0019', 'P08', 1, 47000),
  ('O0020', 'P09', 2, 107500),
  ('O0021', 'P01', 1, 38000),
  ('O0022', 'P02', 2, 67000),
  ('O0023', 'P03', 1, 92000),
  ('O0024', 'P04', 2, 134000),
  ('O0026', 'P05', 1, 119000),
  ('O0027', 'P06', 2, 202500),
  ('O0028', 'P07', 1, 58000),
  ('O0029', 'P08', 2, 36500),
  ('O0030', 'P09', 1, 187000) ;

-- [C6]
WITH customer_total AS (
  SELECT
    customer_id,
    SUM(amount) AS total_amount
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  *
FROM customer_total
WHERE
  total_amount >= 200000
ORDER BY
  total_amount DESC ;

-- [C7] 총 구매액 상위 5건을 이름·등급과 함께 조회합니다.
-- [C7]
WITH customer_total AS (
  SELECT
    customer_id,
    SUM(amount) AS total_amount
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    customer_id
), named AS (
  SELECT
    c.name,
    c.grade,
    t.total_amount
  FROM customer_total AS t
  JOIN project_name.dataset_name.customers AS c
    ON t.customer_id = c.customer_id
)
SELECT
  *
FROM named
ORDER BY
  total_amount DESC
LIMIT 5 ;

-- [문제] 
--1) CTE를 사용해, 상태별 매출 합을 구하는 단계(status_revenue)를 만듭니다. (금액이 있는 주문만)
--2) 그중 매출이 50만원 이상인 상태만 조회합니다.

-- [C8] ⌨️ 백문이 불여일타 (1) — 상태별 매출 CTE + 50만원 이상 필터

-- 여기에 SQL 쿼리를 작성하세요.

WITH status_revenue AS (  -- 상태 별 매출 합
  SELECT
  status,
    SUM(amount) AS total_amount
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    status    -- 상태 별
)
SELECT
  *
FROM status_revenue
WHERE 
total_amount >= 500000
ORDER BY total_amount desc ;


-- [문제]
-- 1) order_items와 products를 JOIN해 카테고리별 매출을 구하는 CTE(cat_rev)를 만듭니다.
-- 2) 그 결과에서 매출이 전체 카테고리 평균보다 높은 카테고리만 조회합니다.

-- [C9] ⌨️ 백문이 불여일타 (2) — 2단계 CTE로 평균 이상 카테고리 찾기

-- 여기에 SQL 쿼리를 작성하세요.

WITH cat_rev AS (  -- 카테고리 별 매출 합
  SELECT
  p.category,
  SUM(oi.quantity * oi.unit_price) as revenue
  FROM project_name.dataset_name.order_items as oi
  JOIN project_name.dataset_name.products as p
  ON oi.product_id = p.product_id
  GROUP BY
    p.category    -- 카테고리 별
)
SELECT
  *
FROM cat_rev
WHERE 
revenue >= (
    SELECT
    AVG(revenue) 
    FROM cat_rev
)
ORDER BY revenue desc ;

-- [C10]
SELECT
  order_id,
  status,
  amount,
  SUM(amount) OVER (PARTITION BY status) AS 상태별_총매출,
  SUM(amount) OVER () AS 전체_총매출
FROM project_name.dataset_name.orders
WHERE
  amount IS NOT NULL
ORDER BY
  status NULLS LAST,
  amount DESC ;


 -- ▶️ 코드 실행하기 · 코드 셀 11 [C11]
-- 금액이 큰 순으로 ROW_NUMBER·RANK·DENSE_RANK 세 순위를 나란히 매겨 상위 8건에서 차이를 비교합니다.
-- [C11]
SELECT
  order_id,
  amount,
  ROW_NUMBER() OVER (ORDER BY amount DESC, order_id) AS row_number,
  RANK() OVER (ORDER BY amount DESC) AS rank,
  DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank
FROM project_name.dataset_name.orders
WHERE
  amount IS NOT NULL
ORDER BY
  amount DESC
LIMIT 8 ;

-- [C12]
WITH product_sales AS (
  SELECT
    p.category,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
  FROM project_name.dataset_name.order_items AS oi
  JOIN project_name.dataset_name.products AS p
    ON oi.product_id = p.product_id
  GROUP BY
    p.category,
    p.product_name
)
SELECT
  category,
  product_name,
  revenue,
  RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS 카테고리내_순위
FROM product_sales
ORDER BY
  category NULLS LAST,
  카테고리내_순위 NULLS LAST ;

-- [문제] 고객별 총구매액(금액 있는 것만)을 구해, 
-- RANK()로 구매액 순위를 매기고 구매액이 큰 고객 5행을 보여주세요. (CTE + 윈도우)
-- [C13] ⌨️ 백문이 불여일타 (3) — 고객별 총구매액 RANK 상위 5명

-- 여기에 SQL 쿼리를 작성하세요.
WITH customer_revenue AS (
  SELECT
  customer_id,
  SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
 customer_id,
 revenue,
 RANK() OVER (ORDER BY revenue DESC) AS 순위
FROM customer_revenue
 ORDER BY 
 순위 NULLS LAST,
 customer_id
LIMIT 5 ;


-- ▶️ 코드 실행하기 · 코드 셀 14 [C14]
-- — 카테고리별 순위를 매긴 결과를 CTE로 감싸, 각 카테고리의 1등 상품만 남깁니다.

-- [C14]
WITH ranked AS (
  SELECT
    p.category,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.unit_price) DESC, p.product_name) AS rn
  FROM project_name.dataset_name.order_items AS oi
  JOIN project_name.dataset_name.products AS p
    ON oi.product_id = p.product_id
  GROUP BY
    p.category,
    p.product_name
)
SELECT
  category,
  product_name,
  revenue
FROM ranked
WHERE
  rn = 1
ORDER BY
  revenue DESC ;


-- [문제]
--1) 고객별 총구매액을 구해 DENSE_RANK로 순위를 매깁니다.
--2) 각 고객의 총구매액이 전체 평균 구매액보다 높은지 함께 보여주세요. (CTE + 순위 윈도우 + AVG() OVER ())

-- [C15] ⌨️ 백문이 불여일타 (4) — DENSE_RANK 순위 + 전체 평균 비교

-- 여기에 SQL 쿼리를 작성하세요.
--1 고객별 총구매액
WITH total AS (
    SELECT
    customer_id,
    sum(amount) as reveune
    FROM project_name.dataset_name.orders
    WHERE amount IS NOT NULL
    GROUP BY customer_id
)
SELECT
 customer_id,
 reveune,
 DENSE_RANK () OVER (ORDER BY reveune DESC) AS 순위,
 AVG(reveune) OVER () AS 전체평균,
 CASE WHEN reveune > AVG(reveune) OVER () THEN '평균이상' ELSE '평균이하' END AS 평가
FROM total
ORDER BY 순위 NULLS LAST ;

-- ▶️ 코드 실행하기 · 코드 셀 16 [C16]
-- — 월별 매출에 처음부터 그 달까지의 누적매출을 함께 붙입니다(프레임 UNBOUNDED PRECEDING).

-- [C16]
WITH monthly AS (
  SELECT
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */ AS month,
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  SUM(revenue) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 누적매출
FROM monthly
ORDER BY
  month NULLS LAST ;


-- [문제] 월별 매출에 '전체 평균 매출'을 나란히 붙여, 
-- 각 달이 평균보다 높은지 낮은지 비교할 수 있게 합니다. (AVG(revenue) OVER ())

-- [C17] ⌨️ 백문이 불여일타 (5) — 월별 매출에 전체 평균 나란히 붙이기

-- 여기에 SQL 쿼리를 작성하세요.

WITH monthly AS (
  SELECT
    date_trunc('month', order_date) AS month, -- 월별 
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  ROUND(AVG(revenue) OVER (), 0) AS 평균월매출
FROM monthly
ORDER BY
  month NULLS LAST ;

-- ▶️ 코드 실행하기 · 코드 셀 18 [C18]
-- — 같은 월별 매출에 최근 3개월 이동평균을 붙여, 들쭉날쭉한 값을 다듬어 추세를 봅니다.
-- [C18]
WITH monthly AS (
  SELECT
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */ AS month,
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  ROUND(AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 0) AS 이동평균_3개월
FROM monthly 
 ORDER BY month NULLS LAST ;

-- ▶️ 코드 실행하기 · 코드 셀 19 [C19]
-- — 월별 매출에 전월 매출·증감액·증감률(%) 을 붙입니다 — LAG로 이전 행을 가져오고, 분모 0은 NULLIF로 방어합니다.
-- [C19]
WITH monthly AS (
  SELECT
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */ AS month,
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  LAG(revenue) OVER (ORDER BY month NULLS LAST) AS 전월매출,
  revenue - LAG(revenue) OVER (ORDER BY month NULLS LAST) AS 증감액,
  ROUND(
    (
      revenue - LAG(revenue) OVER (ORDER BY month NULLS LAST)
    ) * 100.0 / NULLIF(NULLIF(LAG(revenue) OVER (ORDER BY month NULLS LAST), 0), 0),
    1
  ) AS 증감률_pct
FROM monthly
ORDER BY
  month NULLS LAST ;


-- [문제] 위 월별 매출에서 LAG 대신 LEAD를 사용해, 
-- 각 달에 '다음 달 매출'을 나란히 붙입니다. (마지막 달은 NULL이 됩니다.)
-- [C20] ⌨️ 백문이 불여일타 (6) — LEAD로 다음 달 매출 붙이기

-- 여기에 SQL 쿼리를 작성하세요.
WITH monthly AS (
  SELECT
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */ AS month,
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  LAG(revenue) OVER (ORDER BY month NULLS LAST) AS 전월매출,
  LEAD(revenue) OVER (ORDER BY month NULLS LAST) AS 다음달매출,
  revenue - LAG(revenue) OVER (ORDER BY month NULLS LAST) AS 증감액,
FROM monthly
ORDER BY
  month NULLS LAST ;


-- ▶️ 코드 실행하기 · 코드 셀 21 [C21]
-- — 카테고리별 매출에 1위 카테고리의 매출과 그 대비 비율(%) 을 붙입니다(FIRST_VALUE).
-- [C21]
WITH cat AS (
  SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
  FROM project_name.dataset_name.order_items AS oi
  JOIN project_name.dataset_name.products AS p
    ON oi.product_id = p.product_id
  GROUP BY
    p.category
)
SELECT
  category,
  revenue,
  FIRST_VALUE(revenue) OVER (ORDER BY revenue DESC) AS 최고매출,
  ROUND(
    revenue * 100.0 / FIRST_VALUE(revenue) OVER (ORDER BY revenue DESC),
    1
  ) AS 최고대비_pct
FROM cat
ORDER BY
  revenue DESC ;


-- ▶️ 코드 실행하기 · 코드 셀 22 [C22]
-- — 고객별 총 구매액을 구매력 4분위(NTILE(4))와 순위로 함께 나눕니다.

-- [C22]
WITH cust AS (
  SELECT
    customer_id,
    SUM(amount) AS total_spent
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    customer_id
) -- 고객 별 총 구매액
SELECT
  customer_id,
  total_spent,
  NTILE(4) OVER (ORDER BY total_spent DESC) AS 구매력_4분위,
  RANK() OVER (ORDER BY total_spent DESC) AS 순위
FROM cust
ORDER BY
  total_spent DESC ;


-- ▶️ 코드 실행하기 · 코드 셀 23 [C23]
-- — 카테고리 × 상태 매출을 ROLLUP으로 묶어, 조합별 매출과 카테고리 소계·전체 총계까지 한 번에 구합니다.

-- [C23]
SELECT
  p.category,
  o.status,
  SUM(oi.quantity * oi.unit_price) AS 매출
FROM project_name.dataset_name.order_items AS oi
JOIN project_name.dataset_name.products AS p
  ON oi.product_id = p.product_id
JOIN project_name.dataset_name.orders AS o
  ON oi.order_id = o.order_id
GROUP BY
  ROLLUP(p.category, o.status)
ORDER BY
  p.category NULLS LAST,
  o.status NULLS LAST ;


-- ▶️ 코드 실행하기 · 코드 셀 24 [C24]
-- — 소계 행의 NULL과 원래 값이 비어 있던 NULL을 GROUPING으로 구분해 표시합니다.
-- [C24]
SELECT
  CASE
    WHEN GROUPING(p.category) = 1 THEN '── 전체 합계'
    WHEN p.category IS NULL THEN '(카테고리 미입력)'
    ELSE p.category
  END AS 구분,
  SUM(oi.quantity * oi.unit_price) AS 매출,
  COUNT(*) AS 항목수
FROM project_name.dataset_name.order_items AS oi
JOIN project_name.dataset_name.products AS p
  ON oi.product_id = p.product_id
GROUP BY
  ROLLUP(p.category)
ORDER BY
  GROUPING(p.category),
  p.category NULLS LAST ;


-- 📒 연습 문제 — CTE와 윈도우 함수 (5문항)
-- [C25] 📒 연습 문제 — CTE와 윈도우 함수 (1/5)

-- 문제: CTE로 고객별 총구매액을 구한 뒤, 30만원 이상인 고객만 조회합니다.

-- 아래에 SQL 쿼리를 작성하세요.
--1. 고객별 총구매액 -> 30만원 이상 조회 
WITH t AS (
    SELECT customer_id, sum(amount) as total
    FROM project_name.dataset_name.orders
    WHERE amount IS NOT NULL
    GROUP BY customer_id
)
SELECT
*
FROM t
 WHERE total >= 300000
ORDER BY
total desc ;

-- [C26] 📒 연습 문제 — CTE와 윈도우 함수 (2/5)

-- 문제: 각 카테고리 안에서 매출 1위 상품만 뽑으세요. (PARTITION BY + ROW_NUMBER)

-- 아래에 SQL 쿼리를 작성하세요.

WITH ranked AS (
  SELECT
    p.category,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.unit_price) DESC, p.product_name) AS rn
  FROM project_name.dataset_name.order_items AS oi
  JOIN project_name.dataset_name.products AS p
    ON oi.product_id = p.product_id
  GROUP BY
    p.category,
    p.product_name
),
SELECT
  category,
  product_name,
  revenue
FROM ranked
WHERE
  rn = 1
ORDER BY
  revenue DESC ;


-- [C27] 📒 연습 문제 — CTE와 윈도우 함수 (3/5)

-- 문제: 월별 매출과 누적 매출을 함께 조회합니다.

-- 아래에 SQL 쿼리를 작성하세요.

WITH monthly AS (  --월별 매출
  SELECT
    date_trunc('month', order_date)  AS month,
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date)
)
SELECT 
 month,
 revenue,
 SUM(revenue) OVER (ORDER BY month) as 전체누적매출
 FROM monthly
ORDER BY
  month NULLS LAST ;


-- [C28] 📒 연습 문제 — CTE와 윈도우 함수 (4/5)

-- 문제: 월별 매출에 전월 매출과 증감률(%)을 붙이세요. (LAG)

-- 아래에 SQL 쿼리를 작성하세요.
-- [4] 전월 대비
WITH monthly AS (
  SELECT date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */ AS month,
         SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE amount IS NOT NULL
  GROUP BY 1
)
SELECT month, revenue,
       LAG(revenue) OVER (ORDER BY month) AS 전월매출,
       ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) * 100.0
             / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 1) AS 증감률_pct
FROM monthly
ORDER BY month;


-- [C29] 📒 연습 문제 — CTE와 윈도우 함수 (5/5)

-- 문제: 고객별 총구매액을 NTILE(3)으로 상·중·하 등급으로 나누세요.

-- 아래에 SQL 쿼리를 작성하세요.
WITH cust AS ( -- 총구매액
  SELECT
    customer_id,
    SUM(amount) AS total_spent
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  customer_id,
  total_spent,
  NTILE(3) OVER (ORDER BY total_spent DESC) AS 등급,
FROM cust
ORDER BY
  total_spent DESC ;



-- 질문 1. 월별 매출, 누적매출, 전월 대비 증감률을 한 표에 담으세요.
WITH monthly AS (
  SELECT
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */ AS month,
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  SUM(revenue) OVER (ORDER BY month) AS 누적매출,
  LAG(revenue) OVER (ORDER BY month NULLS LAST) AS 전월매출,
  revenue - LAG(revenue) OVER (ORDER BY month NULLS LAST) AS 증감액,
  ROUND(
    (
      revenue - LAG(revenue) OVER (ORDER BY month NULLS LAST)
    ) * 100.0 / NULLIF(NULLIF(LAG(revenue) OVER (ORDER BY month NULLS LAST), 0), 0),
    1
  ) AS 증감률_pct
FROM monthly
ORDER BY
  month NULLS LAST ;


WITH monthly AS (
  SELECT
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */ AS month,
    SUM(amount) AS revenue
  FROM project_name.dataset_name.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    date_trunc('month', order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  SUM(revenue) OVER (ORDER BY month) AS cum_revenue
FROM monthly
ORDER BY
  month NULLS LAST ;



-- 코드 퀴즈
-- 문제: order_items+products로 카테고리별 매출을 구한 뒤, 
-- RANK()로 매출 순위를 매겨 보여주세요. (CTE + 윈도우)

WITH cat_rev as (
    select 
    p.category,
    sum(oi.quantity * oi.unit_price) as revenue
    FROM project_name.dataset_name.order_items as oi
    JOIN project_name.dataset_name.products AS p
    ON oi.product_id = p.product_id
    GROUP BY p.category
)
SELECT
 category,
 revenue,
 RANK() OVER (ORDER BY revenue DESC) AS 순위
FROM cat_rev 
ORDER BY 순위 NULLS LAST ;
