
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