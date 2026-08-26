-- 자유롭게 쿼리를 작성하고 실행하세요 (위에서 만든 테이블 사용 가능)

SELECT USER, host FROM mysql.user ;


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

SELECT
  *
FROM customers
LIMIT 5 ;