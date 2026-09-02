-- Active: 1788113119502@@127.0.0.1@3306
-- Active: 1788113119502@@127.0.0.1@3306-- Active: 1788113119502@@127.0.0.1@3306-- Active: 1788113119502@@127.0.0.1@3306

ATTACH IF NOT EXISTS ':memory:' AS project_name;
CREATE SCHEMA IF NOT EXISTS project_name.dataset_name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id VARCHAR(20), /* 고객번호 (예: C001) */
  name VARCHAR(50), /* 이름 */
  country VARCHAR(50), /* 국가 */
  signup_date DATE, /* 가입일 */
  grade VARCHAR(20) /* 등급 (Gold/Silver/Bronze) */
);

