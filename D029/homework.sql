-- 자유롭게 쿼리를 작성하고 실행하세요 (위에서 만든 테이블 사용 가능)


CREATE DATABASE IF NOT EXISTS dataset_name;
USE dataset_name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id VARCHAR(20), /* 고객번호 (예: C001) */
  name VARCHAR(50), /* 이름 */
  country VARCHAR(50), /* 국가 */
  signup_date DATE, /* 가입일 */
  grade VARCHAR(20) /* 등급 (Gold/Silver/Bronze) */
);

INSERT INTO customers VALUES
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
  ('C015', '안수아', 'Korea', '2023-08-28', 'Bronze');


CREATE DATABASE IF NOT EXISTS dataset_name;
USE dataset_name;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  order_id VARCHAR(20),  /* 주문번호 */
  customer_id VARCHAR(20), /* 고객번호 (customers와 연결) */
  order_date DATE, /* 주문일 */
  status VARCHAR(20),
  amount DECIMAL
);

INSERT INTO orders VALUES
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
  ('O0030', 'C012', '2024-02-11', 'Paid', 187000)

SELECT
  *
FROM customers
LIMIT 5 ;

-- 과제 제출용 (5문항)

-- Q1. Gold 등급이면서 한국 국적인 고객은?

SELECT
  *
FROM customers
WHERE grade = 'Gold' AND country = 'Korea'

-- Q2. Gold 또는 Silver 등급이면서, 국가 정보가 결측되지 않은 고객은?
SELECT
  *
FROM customers
WHERE grade IN ('Gold', 'Silver') 
 AND country IS NOT NULL

-- Q3. 2023년 4분기(10~12월)에 발생한 주문 중 결제금액이 10만~30만원 사이인 주문은?

DESCRIBE orders

SELECT
  *
FROM orders
WHERE order_date BETWEEN DATE '2023-10-01' AND DATE '2023-12-31'
 AND amount BETWEEN 100000 AND 300000 ;

-- Q4. 취소(Cancelled)되었거나 결제금액이 비어있는(NULL) 주문은?
SELECT
  *
FROM orders
WHERE amount IS NULL 
 OR status = 'Cancelled' ;

-- Q5. 등급 정보가 없거나(Unknown) Bronze가 아니면서, 국적이 한국이 아닌 고객은?
SELECT
  *
FROM customers
WHERE grade IS NULL
 OR grade <> 'Bronze' AND Country <> 'Korea' ;

DESCRIBE customers