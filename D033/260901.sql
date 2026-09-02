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

  -- [C4]
CREATE OR REPLACE TABLE project_name.dataset_name.events (
  event_id INT64,
  customer_id STRING,
  event_type STRING,
  page STRING,
  event_at TIMESTAMP
);

INSERT INTO project_name.dataset_name.events VALUES
  (1, 'C001', 'visit', 'home', TIMESTAMP '2023-09-02 10:02:11'),
  (2, 'C001', 'view', 'product_detail', TIMESTAMP '2023-09-02 10:04:35'),
  (3, 'C001', 'view', 'product_detail', TIMESTAMP '2023-09-02 10:07:20'),
  (4, 'C001', 'add_to_cart', 'cart', TIMESTAMP '2023-09-02 10:11:02'),
  (5, 'C001', 'purchase', 'checkout', TIMESTAMP '2023-09-02 10:14:47'),
  (6, 'C001', 'visit', 'home', TIMESTAMP '2023-10-18 09:31:04'),
  (7, 'C001', 'view', 'product_detail', TIMESTAMP '2023-10-18 09:33:50'),
  (8, 'C001', 'visit', 'home', TIMESTAMP '2023-11-14 20:12:33'),
  (9, 'C002', 'visit', 'home', TIMESTAMP '2023-09-05 14:20:05'),
  (10, 'C002', 'view', 'product_detail', TIMESTAMP '2023-09-05 14:22:41'),
  (11, 'C002', 'add_to_cart', 'cart', TIMESTAMP '2023-09-05 14:27:19'),
  (12, 'C002', 'purchase', 'checkout', TIMESTAMP '2023-09-05 14:31:58'),
  (13, 'C002', 'visit', 'home', TIMESTAMP '2023-10-09 11:05:22'),
  (14, 'C002', 'view', 'product_detail', TIMESTAMP '2023-10-09 11:08:44'),
  (15, 'C003', 'visit', 'home', TIMESTAMP '2023-09-15 09:14:30'),
  (16, 'C003', 'view', 'product_detail', TIMESTAMP '2023-09-15 09:17:12'),
  (17, 'C003', 'add_to_cart', 'cart', TIMESTAMP '2023-09-15 09:21:40'),
  (18, 'C003', 'purchase', 'checkout', TIMESTAMP '2023-09-15 09:26:03'),
  (19, 'C003', 'visit', 'home', TIMESTAMP '2023-11-07 21:40:15'),
  (20, 'C003', 'view', 'product_detail', TIMESTAMP '2023-11-07 21:43:02'),
  (21, 'C004', 'visit', 'home', TIMESTAMP '2023-09-18 16:03:11'),
  (22, 'C004', 'view', 'product_detail', TIMESTAMP '2023-09-18 16:06:29'),
  (23, 'C004', 'visit', 'home', TIMESTAMP '2023-11-05 10:55:07'),
  (24, 'C004', 'view', 'product_detail', TIMESTAMP '2023-11-05 10:58:33'),
  (25, 'C005', 'visit', 'home', TIMESTAMP '2023-09-22 08:40:19'),
  (26, 'C006', 'visit', 'home', TIMESTAMP '2023-10-04 13:11:02'),
  (27, 'C006', 'view', 'product_detail', TIMESTAMP '2023-10-04 13:13:47'),
  (28, 'C006', 'add_to_cart', 'cart', TIMESTAMP '2023-10-04 13:18:20'),
  (29, 'C006', 'purchase', 'checkout', TIMESTAMP '2023-10-04 13:22:55'),
  (30, 'C006', 'visit', 'home', TIMESTAMP '2023-11-16 19:02:41'),
  (31, 'C006', 'visit', 'home', TIMESTAMP '2023-12-05 12:30:18'),
  (32, 'C006', 'view', 'product_detail', TIMESTAMP '2023-12-05 12:33:04'),
  (33, 'C007', 'visit', 'home', TIMESTAMP '2023-10-12 10:45:33'),
  (34, 'C007', 'view', 'product_detail', TIMESTAMP '2023-10-12 10:48:09'),
  (35, 'C007', 'view', 'product_detail', TIMESTAMP '2023-10-12 10:52:41'),
  (36, 'C007', 'add_to_cart', 'cart', TIMESTAMP '2023-10-12 10:57:12'),
  (37, 'C007', 'purchase', 'checkout', TIMESTAMP '2023-10-12 11:02:38'),
  (38, 'C007', 'visit', 'home', TIMESTAMP '2023-11-21 15:20:07'),
  (39, 'C007', 'view', 'product_detail', TIMESTAMP '2023-11-21 15:23:55'),
  (40, 'C008', 'visit', 'home', TIMESTAMP '2023-10-16 17:30:44'),
  (41, 'C008', 'view', 'product_detail', TIMESTAMP '2023-10-16 17:33:21'),
  (42, 'C008', 'visit', 'home', TIMESTAMP '2023-12-13 11:15:02'),
  (43, 'C008', 'view', 'product_detail', TIMESTAMP '2023-12-13 11:18:39'),
  (44, 'C009', 'visit', 'home', TIMESTAMP '2023-10-25 20:05:13'),
  (45, 'C009', 'view', 'product_detail', TIMESTAMP '2023-10-25 20:08:47'),
  (46, 'C009', 'add_to_cart', 'cart', TIMESTAMP '2023-10-25 20:14:22'),
  (47, 'C010', 'visit', 'home', TIMESTAMP '2023-11-24 09:50:11'),
  (48, 'C010', 'view', 'product_detail', TIMESTAMP '2023-11-24 09:52:48'),
  (49, 'C010', 'add_to_cart', 'cart', TIMESTAMP '2023-11-24 09:58:30'),
  (50, 'C010', 'visit', 'home', TIMESTAMP '2023-12-18 18:22:05'),
  (51, 'C011', 'visit', 'home', TIMESTAMP '2023-11-10 14:08:26'),
  (52, 'C011', 'view', 'product_detail', TIMESTAMP '2023-11-10 14:11:03'),
  (53, 'C012', 'visit', 'home', TIMESTAMP '2023-11-19 11:40:15'),
  (54, 'C012', 'view', 'product_detail', TIMESTAMP '2023-11-19 11:42:58'),
  (55, 'C012', 'add_to_cart', 'cart', TIMESTAMP '2023-11-19 11:47:33'),
  (56, 'C012', 'purchase', 'checkout', TIMESTAMP '2023-11-19 11:52:10'),
  (57, 'C012', 'visit', 'home', TIMESTAMP '2023-12-27 16:14:40'),
  (58, 'C012', 'view', 'product_detail', TIMESTAMP '2023-12-27 16:17:22'),
  (59, 'C012', 'visit', 'home', TIMESTAMP '2024-01-08 10:20:55'),
  (60, 'C013', 'visit', 'home', TIMESTAMP '2023-11-26 13:05:30'),
  (61, 'C013', 'view', 'product_detail', TIMESTAMP '2023-11-26 13:08:12'),
  (62, 'C013', 'visit', 'home', TIMESTAMP '2024-01-19 09:44:18'),
  (63, 'C013', 'view', 'product_detail', TIMESTAMP '2024-01-19 09:47:01'),
  (64, 'C014', 'visit', 'home', TIMESTAMP '2023-12-11 19:30:22'),
  (65, 'C014', 'visit', 'home', TIMESTAMP '2024-02-06 08:15:44'),
  (66, 'C015', 'visit', 'home', TIMESTAMP '2023-12-22 10:10:05'),
  (67, 'C015', 'view', 'product_detail', TIMESTAMP '2023-12-22 10:13:40'),
  (68, 'C015', 'visit', 'home', TIMESTAMP '2024-01-11 17:55:19') ;



-- ▶️ 코드 실행하기 · 코드 셀 5 [C5]
--— events에서 AARRR 단계별 고유 고객 수를 한 행으로 셉니다. 
-- 방문·상품조회·장바구니·구매까지 각각 몇 명이 닿았는지, 그리고 추천 단계는 셀 수 있는지 확인합니다.

  -- [C5]
SELECT
  COUNT(DISTINCT customer_id) AS Acquisition_방문,
  COUNT(DISTINCT CASE WHEN event_type = 'view' THEN customer_id END) AS Activation_상품조회,
  COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN customer_id END) AS Activation_장바구니,
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN customer_id END) AS Revenue_구매,
  0 AS Referral_추천 /* 추천인·유입 채널을 담은 열이 없어 셀 수 없습니다 */
FROM project_name.dataset_name.events ;


-- ▶️ 코드 실행하기 · 코드 셀 6 [C6]
-- — 상품 조회(view) 이벤트만 골라 PV(총 조회 횟수)와 UV(고유 방문자 수) 를 함께 셉니다.

-- [C6]
SELECT
  COUNT(*) AS PV_상품조회수, -- PV
  COUNT(DISTINCT customer_id) AS UV_고유방문자 -- UV
FROM project_name.dataset_name.events
WHERE
  event_type = 'view' ;


-- ▶️ 코드 실행하기 · 코드 셀 7 [C7]
-- — 취소·반품을 제외한 매출을 기준으로 총매출·활성 사용자·구매 사용자와 ARPU·ARPPU를 한 줄로 구합니다.

-- ARPU (Average Revenue Per User) = 	     총매출 ÷ 활성 사용자 수
-- ARPPU (Average Revenue Per Paying User) = 총매출 ÷ 구매 사용자 수
with total as (
    select
    sum(amount) as revenue
    from project_name.dataset_name.orders
    WHERE status NOT IN ('Cancelled', 'Returned') AND amount IS NOT NULL
), active as ( -- 활성 사용자는 event에
    SELECT
     COUNT(DISTINCT customer_id) as active_users 
    FROM project_name.dataset_name.events 
), paying as ( -- 구매 사용자는 orders에
    SELECT
     COUNT(DISTINCT customer_id) as paying_users
    FROM project_name.dataset_name.orders
    WHERE status NOT IN ('Cancelled', 'Returned') AND amount IS NOT NULL
)
SELECT
revenue AS 총매출,
active_users AS 활성사용자,
paying_users AS 구매사용자,
ROUND(revenue / NULLIF(active_users, 0), 0) AS ARPU,
ROUND(revenue / NULLIF(paying_users, 0), 0) AS ARPPU
FROM total
CROSS JOIN active
CROSS JOIN paying ;

-- 확성사용자가 크고 구매사용자가 작으니 분모로 들어가면 결과가 반대
--> ARPU <= ARPPU


-- [문제] events에서 전체 이벤트 수(PV 개념의 총 행동 수)와 
-- 고유 사용자 수(UV)를 구합니다. (event_type 구분 없이 전체)

-- [C8] ⌨️ 백문이 불여일타 (1) — 전체 이벤트 수(PV)와 고유 사용자 수(UV)

-- 여기에 SQL 쿼리를 작성하세요.
SELECT
COUNT(*) as 총이벤트,
COUNT(DISTINCT customer_id) as  고유사용자
FROM project_name.dataset_name.events ;


-- ▶️ 코드 실행하기 · 코드 셀 9 [C9]
-- — PV·UV를 페이지별로 쪼개어 어느 페이지가 가장 많이 보이는지 확인합니다.

-- [C9]
SELECT
  page,
  COUNT(*) AS PV, -- 전체 이벤트 수(PV)
  COUNT(DISTINCT customer_id) AS UV -- 고유 사용자 수(UV)
FROM project_name.dataset_name.events
GROUP BY
  page
ORDER BY
  PV DESC ; 



-- [문제] events에서 이벤트 종류(event_type)별 고유 사용자 수(UV)를 구해, 많은 순으로 보여주세요.
SELECT 
event_type,
COUNT(DISTINCT customer_id) AS UV -- 고유 사용자 수(UV)
FROM project_name.dataset_name.events
GROUP BY event_type
ORDER BY UV desc ;


-- [문제] 리포트의 마지막 장표로, 국가별 구매 고객 수와 ARPPU를 구합니다.
-- 1) orders와 customers를 JOIN 합니다.
-- 2) 국가별로 묶어 구매 고객 수(COUNT(DISTINCT customer_id))와 
   --ARPPU(SUM(amount)/COUNT(DISTINCT customer_id))를 구합니다.
-- 3) 국가 정보가 없는(NULL) 고객과 취소·반품 주문을 제외합니다.
-- 4) ARPPU가 높은 순으로 정렬합니다.


SELECT
 c.country,
 COUNT(DISTINCT o.customer_id) AS 구매고객수,
 ROUND(SUM(o.amount) * 1.0  /COUNT(DISTINCT o.customer_id), 0) AS ARPPU
FROM project_name.dataset_name.orders AS o
 JOIN project_name.dataset_name.customers AS c
 ON o.customer_id = c.customer_id
WHERE 
 o.status NOT IN ('Cancelled', 'Returned') 
 AND o.amount IS NOT NULL
 AND c.country IS NOT NULL
GROUP BY c.country
ORDER BY ARPPU desc ;


--▶️ 코드 실행하기 · 코드 셀 12 [C12]
--— 방문·조회·장바구니·구매 네 단계의 고유 사용자 수를 한 행에 가로로 펼칩니다(CASE 피벗).
-- [C12]
SELECT
  COUNT(DISTINCT CASE WHEN event_type = 'visit' THEN customer_id END) AS 방문,
  COUNT(DISTINCT CASE WHEN event_type = 'view' THEN customer_id END) AS 조회,
  COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN customer_id END) AS 장바구니,
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN customer_id END) AS 구매
FROM project_name.dataset_name.events ;

--▶️ 코드 실행하기 · 코드 셀 13 [C13]
-- — 같은 네 단계에 방문 대비 각 단계 도달률(%) 을 붙여 퍼널을 완성합니다.
-- [C13]
WITH funnel AS (
 SELECT
  COUNT(DISTINCT CASE WHEN event_type = 'visit' THEN customer_id END) AS 방문,
  COUNT(DISTINCT CASE WHEN event_type = 'view' THEN customer_id END) AS 조회,
  COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN customer_id END) AS 장바구니,
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN customer_id END) AS 구매
FROM project_name.dataset_name.events
)
SELECT
  방문,
  조회,
  장바구니,
  구매,
  ROUND(조회 * 100.0 / NULLIF(방문, 0), 1) AS 방문대비_조회도달률,
  ROUND(장바구니 * 100.0 / NULLIF(방문, 0), 1) AS 방문대비_장바구니도달률,
  ROUND(구매 * 100.0 / NULLIF(방문, 0), 1) AS 방문대비_구매도달률
FROM funnel ;


- [문제] 장바구니(add_to_cart)를 사용한 사람 중 구매(purchase)도 한 사람의 비율을 구합니다. 
- 이번 문제는 두 행동의 수행 여부만 확인하고 시간 순서는 확인하지 않습니다.

-- [C14] ⌨️ 백문이 불여일타 (4) — 장바구니 → 구매 전환율

-- 여기에 SQL 쿼리를 작성하세요.

WITH user_steps AS (
  SELECT
    customer_id,
    MAX(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS cart,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase
  FROM project_name.dataset_name.events
  GROUP BY
    customer_id
), f AS (
  SELECT
    SUM(cart) AS 장바구니사용자,
    SUM(CASE WHEN cart = 1 AND purchase = 1 THEN 1 ELSE 0 END) AS 장바구니후_구매사용자
  FROM user_steps
)
SELECT
  장바구니사용자,
  장바구니후_구매사용자,
  ROUND(장바구니후_구매사용자 * 100.0 / NULLIF(장바구니사용자, 0), 1) AS 장바구니_구매도달률
FROM f ;



-- ▶️ 코드 실행하기 · 코드 셀 15 [C15]
-- — 전환율 대신 단계 사이에서 몇 명이 빠졌는지 이탈자 수로 구합니다.

-- [C15]
WITH funnel AS (
  SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'visit' THEN customer_id END) AS visit,
    COUNT(DISTINCT CASE WHEN event_type = 'view' THEN customer_id END) AS view,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN customer_id END) AS cart,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN customer_id END) AS purchase
  FROM project_name.dataset_name.events
)
SELECT
  visit - view AS 방문후_이탈,
  view - cart AS 조회후_이탈,
  cart - purchase AS 장바구니후_이탈
FROM funnel ;



--▶️ 코드 실행하기 · 코드 셀 16 [C16]
-- — 각 고객이 처음 나타난 달을 코호트로 삼아, 코호트별 출발 인원을 구합니다.
-- [C16]
WITH first_seen AS ( -- 각 고객이 처음 나타난 달을 구해, 그 달을 코호트로 
  SELECT
    customer_id,
    date_trunc('month', DATE(MIN(event_at))) AS cohort_month -- MIN(event_at) 각 고객이 처음 나타난 달
  FROM project_name.dataset_name.events
  GROUP BY
    customer_id
)
SELECT
  cohort_month,
  COUNT(*) AS 코호트_고객수
FROM first_seen
GROUP BY
  cohort_month
ORDER BY
  cohort_month NULLS LAST ;


-- ▶️ 코드 실행하기 · 코드 셀 17 [C17]
-- — 코호트별로 경과 개월 수(0·1·2…)마다 몇 명이 다시 활동했는지 매트릭스로 펼칩니다.
-- [C17]
WITH first_seen AS (
  SELECT
    customer_id,
    date_trunc('month', DATE(MIN(event_at))) /* BigQuery: DATE_TRUNC(DATE(MIN(event_at)), MONTH) */ AS cohort_month
  FROM project_name.dataset_name.events
  GROUP BY
    customer_id
), activity AS (
  SELECT DISTINCT
    customer_id,
    date_trunc('month', DATE(event_at)) /* BigQuery: DATE_TRUNC(DATE(event_at), MONTH) */ AS active_month
  FROM project_name.dataset_name.events
), joined AS (
  SELECT
    f.cohort_month,
    date_diff('month', f.cohort_month, a.active_month) /* BigQuery: DATE_DIFF(a.active_month, f.cohort_month, MONTH) */ AS month_offset,
    a.customer_id
  FROM first_seen AS f
  JOIN activity AS a
    ON f.customer_id = a.customer_id
)
SELECT
  cohort_month,
  COUNT(DISTINCT CASE WHEN month_offset = 0 THEN customer_id END) AS 경과0개월,
  COUNT(DISTINCT CASE WHEN month_offset = 1 THEN customer_id END) AS 경과1개월,
  COUNT(DISTINCT CASE WHEN month_offset = 2 THEN customer_id END) AS 경과2개월
FROM joined
GROUP BY
  cohort_month
ORDER BY
  cohort_month NULLS LAST ;




-- [문제] 위 리텐션 매트릭스를 비율(%)로 바꿉니다. 
-- 경과 0개월(코호트 크기) 대비 경과 1개월의 리텐션율을 구하면 됩니다.

-- [C18] ⌨️ 백문이 불여일타 (5) — 코호트 1개월 리텐션율(%)

-- 여기에 SQL 쿼리를 작성하세요.
WITH first_seen AS (
  SELECT
    customer_id,
    date_trunc('month', DATE(MIN(event_at))) /* BigQuery: DATE_TRUNC(DATE(MIN(event_at)), MONTH) */ AS cohort_month
  FROM project_name.dataset_name.events
  GROUP BY
    customer_id
), activity AS (
  SELECT DISTINCT
    customer_id,
    date_trunc('month', DATE(event_at)) /* BigQuery: DATE_TRUNC(DATE(event_at), MONTH) */ AS active_month
  FROM project_name.dataset_name.events
), joined AS (
  SELECT
    f.cohort_month,
    date_diff('month', f.cohort_month, a.active_month) /* BigQuery: DATE_DIFF(a.active_month, f.cohort_month, MONTH) */ AS month_offset,
    a.customer_id
  FROM first_seen AS f
  JOIN activity AS a
    ON f.customer_id = a.customer_id
), m AS (
    SELECT
    cohort_month,
    COUNT(DISTINCT CASE WHEN month_offset = 0 THEN customer_id END) AS m0,
    COUNT(DISTINCT CASE WHEN month_offset = 1 THEN customer_id END) AS m1
  FROM joined
  GROUP BY
    cohort_month
)
SELECT
  cohort_month,
  m0,
  m1,
  ROUND(m1 * 100.0 / NULLIF(m0, 0), 1) AS 리텐션율_1개월
FROM m
ORDER BY
  cohort_month NULLS LAST ;


-- ▶️ 코드 실행하기 · 코드 셀 19 [C19]
-- — 취소·반품을 제외한 주문으로 고객별 최근성(R)·빈도(F)·금액(M) 세 값을 구합니다(분석 기준일 2024-03-01).

-- [C19]
SELECT
  customer_id,
  date_diff('day', MAX(order_date), DATE '2024-03-01') AS recency_일, -- 분석기준일 − 마지막 주문일 
  COUNT(*) AS frequency_횟수,
  SUM(amount) AS monetary_총액
FROM project_name.dataset_name.orders
WHERE
  status NOT IN ('Cancelled', 'Returned')
  AND amount IS NOT NULL
GROUP BY
  customer_id
ORDER BY
  monetary_총액 DESC ;


-- ▶️ 코드 실행하기 · 코드 셀 20 [C20]
-- — 같은 RFM 값에 CASE로 '핵심 고객'·'이탈 위험'·'일반 고객' 등급을 붙입니다.

-- [C20]
WITH rfm AS (
  SELECT
    customer_id,
    date_diff('day', MAX(order_date), DATE '2024-03-01') AS recency, /* BigQuery: DATE_DIFF(DATE '2024-03-01', MAX(order_date), DAY) */
    COUNT(*) AS frequency,
    SUM(amount) AS monetary
  FROM project_name.dataset_name.orders
  WHERE
    status NOT IN ('Cancelled', 'Returned')
    AND amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  customer_id,
  recency,
  frequency,
  monetary,
  CASE
    WHEN monetary >= 300000 AND recency <= 90 THEN '핵심 고객'
    WHEN recency > 120 THEN '이탈 위험'
    ELSE '일반 고객' END AS 고객등급
FROM rfm
ORDER BY
  monetary DESC ;


-- [문제] RFM에서 총 구매액(Monetary)이 큰 고객 3행을 뽑고, 
-- RANK() 윈도우 함수로 순위를 함께 보여주세요. (CTE + 윈도우)

WITH rfm AS (
  SELECT
    customer_id,
    date_diff('day', MAX(order_date), DATE '2024-03-01') AS recency, /* BigQuery: DATE_DIFF(DATE '2024-03-01', MAX(order_date), DAY) */
    COUNT(*) AS frequency,
    SUM(amount) AS monetary
  FROM project_name.dataset_name.orders
  WHERE
    status NOT IN ('Cancelled', 'Returned')
    AND amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  customer_id,
  monetary,
  RANK() OVER (ORDER BY monetary DESC) AS 순위
FROM rfm
ORDER BY
  순위 NULLS LAST,
  customer_id
LIMIT 3 ;


-- ▶️ 코드 실행하기 · 코드 셀 22 [C22]
-- — 등급 대신 R·F·M 각 축을 NTILE(4)로 4등분해 점수화합니다 — 4점이 좋은 점수가 되도록 정렬 방향을 통일합니다.

-- [C22]
WITH rfm AS (
  SELECT
    customer_id,
    date_diff('day', MAX(order_date), DATE '2024-03-01') /* BigQuery: DATE_DIFF(DATE '2024-03-01', MAX(order_date), DAY) */ AS recency,
    COUNT(*) AS frequency,
    SUM(amount) AS monetary
  FROM project_name.dataset_name.orders
  WHERE
    status NOT IN ('Cancelled', 'Returned')
    AND amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  customer_id,
  recency,
  frequency,
  monetary,
  NTILE(4) OVER (ORDER BY recency DESC NULLS FIRST) AS R점수, -- 최근일수록 좋음. 
  NTILE(4) OVER (ORDER BY frequency ASC) AS F점수, -- 주문 빈도가 높아야 좋음
  NTILE(4) OVER (ORDER BY monetary ASC) AS M점수 - 구매액이 높아야 좋음
FROM rfm
ORDER BY
  monetary DESC ;

-- NTILE은 사분위수. 작은 값부터 큰 값으로 1~4분위수로 정렬.




-- ▶️ 코드 실행하기 · 코드 셀 23 [C23]
-- — 전체 주문에서 취소·반품 건수와 그 비율(%) 을 구합니다.
-- [C23]
SELECT
  COUNT(*) AS 전체주문,
  SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS 취소,
  SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) AS 반품,
  ROUND(
    SUM(CASE WHEN status IN ('Cancelled', 'Returned') THEN 1 ELSE 0 END) * 100.0
      / NULLIF(COUNT(*), 0),
    1
  ) AS 취소반품율_pct
FROM project_name.dataset_name.orders ;


-- ▶️ 코드 실행하기 · 코드 셀 24 [C24]
-- — 상태별 건수와 금액에 각각의 전체 대비 비중(%) 을 붙여, 건수 기준과 금액 기준이 어떻게 다른지 비교합니다.

-- [C24]
SELECT
  status,
  COUNT(*) AS 건수,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS 건수비중_pct,
  SUM(amount) AS 금액,
  ROUND(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER (), 1) AS 금액비중_pct
FROM project_name.dataset_name.orders
GROUP BY
  status
ORDER BY
  건수 DESC ;

-- SUM(COUNT(*)) OVER ()  = 각 그룹의 COUNT(*)를 전체 합계로 다시 집계


-- ▶️ 코드 실행하기 · 코드 셀 25 [C25]
-- — 고객별 구매 횟수와 경과일을 구한 뒤, 두 축을 조합해 '이탈 위험(단골이었음)'·'휴면'·'우량'·'신규' 로 분류합니다.
-- [C25]
WITH cust AS (
  SELECT
    customer_id,
    COUNT(*) AS 구매횟수,
    SUM(amount) AS 총구매액,
    MAX(order_date) AS 최근구매일,
    date_diff('day', MAX(order_date), DATE '2024-03-01') /* BigQuery: DATE_DIFF(DATE '2024-03-01', MAX(order_date), DAY) */ AS 경과일
  FROM project_name.dataset_name.orders
  WHERE
    status NOT IN ('Cancelled', 'Returned')
    AND amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  customer_id,
  구매횟수,
  총구매액,
  최근구매일,
  경과일,
  CASE
    WHEN 경과일 > 90 AND 구매횟수 >= 2 THEN '⚠️ 이탈 위험 (단골이었음)'
    WHEN 경과일 > 90 THEN '😐 휴면'
    WHEN 구매횟수 >= 2 THEN '✅ 우량'
    ELSE '🙂 신규·1회'
  END AS 상태
FROM cust
ORDER BY
  경과일 DESC ;




-- [C26] 📒 연습 문제 — 고객 행동 지표 (1/5)

-- 문제: 전체 이벤트 수(PV)와 고유 사용자 수(UV)를 한 번에 구합니다.

-- 아래에 SQL 쿼리를 작성하세요.
SELECT
  COUNT(*) AS PV_상품조회수, -- PV
  COUNT(DISTINCT customer_id) AS UV_고유방문자 -- UV
FROM project_name.dataset_name.events ;


-- [C27] 📒 연습 문제 — 고객 행동 지표 (2/5)

-- 문제: event_type별 사용자 수를 구하고 많은 순으로 정렬합니다.

-- 아래에 SQL 쿼리를 작성하세요.

SELECT
event_type,
COUNT(DISTINCT customer_id) AS 사용자수
FROM project_name.dataset_name.events
GROUP BY event_type
ORDER BY 사용자수 DESC ;


-- [C28] 📒 연습 문제 — 고객 행동 지표 (3/5)

-- 문제: 정상 주문(취소·반품 제외)만으로 ARPPU(구매 사용자 1인당 평균 매출)를 구합니다.

-- 아래에 SQL 쿼리를 작성하세요.

SELECT
  COUNT(DISTINCT customer_id) AS 구매고객수,
  SUM(amount) AS 총매출,
  ROUND(SUM(amount) / NULLIF(COUNT(DISTINCT customer_id), 0), 0) AS ARPPU
FROM project_name.dataset_name.orders
WHERE
  amount IS NOT NULL
  AND status NOT IN ('Cancelled', 'Returned');


  -- [C29] 📒 연습 문제 — 고객 행동 지표 (4/5)

-- 문제: 고객별 마지막 구매일과 그날로부터 2024-03-01까지 경과일을 구합니다.
-- 아래에 SQL 쿼리를 작성하세요.

SELECT
 customer_id,
 MAX(order_date) AS 최근구매일,
 date_diff('day', MAX(order_date), DATE '2024-03-01') AS 경과일
FROM project_name.dataset_name.orders
WHERE status NOT IN ('Cancelled', 'Returned')
  AND amount IS NOT NULL
GROUP BY customer_id
ORDER BY 경과일 DESC ;


-- [C30] 📒 연습 문제 — 고객 행동 지표 (5/5)
-- 문제: 정상 주문의 고객별 총구매액을 NTILE(3)으로 나누세요. 1은 하, 3은 상으로 해석합니다.
-- 아래에 SQL 쿼리를 작성하세요.

with cust as (
SELECT
 customer_id,
 sum(amount) as 총구매액
FROM project_name.dataset_name.orders
WHERE status NOT IN ('Cancelled', 'Returned')
  AND amount IS NOT NULL
GROUP BY customer_id
)
SELECT
customer_id,
총구매액,
NTILE(3) OVER (ORDER BY 총구매액 ASC) AS 등급, -- 총구매액이 높아야 상, 아니면 하
FROM cust
ORDER BY 총구매액 DESC ;






