ATTACH IF NOT EXISTS ':memory:' AS project_name;
CREATE SCHEMA IF NOT EXISTS project_name.dataset_name;


CREATE OR REPLACE TABLE project_name.dataset_name.amazon AS
SELECT * FROM read_csv('C:\Users\tjwls\OneDrive\문서\ai-data-bootcamp\D034\amazon.csv', header = true);

-- 0단계 전처리
CREATE OR REPLACE TABLE project_name.dataset_name.amazon_clean AS
SELECT
  product_id,
  product_name,
  category,
  TRY_CAST(REPLACE(REPLACE(discounted_price, '₹',''), ',', '') AS DECIMAL(12,2)) AS discounted_price,
  TRY_CAST(REPLACE(REPLACE(actual_price, '₹',''), ',', '') AS DECIMAL(12,2)) AS actual_price,
  TRY_CAST(REPLACE(discount_percentage, '%','') AS DECIMAL(5,2)) AS discount_percentage,
  TRY_CAST(rating AS DECIMAL(3,2)) AS rating,
  TRY_CAST(REPLACE(rating_count, ',', '') AS BIGINT) AS rating_count,
  user_id
FROM project_name.dataset_name.amazon;


-- null 개수 확인 = 1
SELECT
  COUNT(*) AS 전체행수,
  COUNT(rating) AS rating있는행수,
  COUNT(*) - COUNT(rating) AS rating_NULL개수
FROM project_name.dataset_name.amazon_clean;


-- 시스템 1 — "이 카테고리 첫 구매는 이걸로 시작하세요"
WITH ranked AS (
  SELECT
    product_id, product_name, category, rating, rating_count,
    ROW_NUMBER() OVER (
      PARTITION BY category 
      ORDER BY rating_count DESC, rating DESC, product_id
    ) AS rnk
  FROM project_name.dataset_name.amazon_clean
  WHERE rating >= 4.0
)
SELECT category, product_name, rating, rating_count
FROM ranked
WHERE rnk = 1
ORDER BY rating_count DESC;


-- 시스템 3 — "아직 아무도 모르는 꿀템이에요"
WITH tiered AS (
  SELECT
    product_id, product_name, category, rating, rating_count,
    NTILE(4) OVER (ORDER BY rating_count ASC) AS review_tier
  FROM project_name.dataset_name.amazon_clean
)
SELECT product_name, category, rating, rating_count
FROM tiered
WHERE review_tier = 1 AND rating >= 4.0
ORDER BY rating DESC;


-- 시스템 5 — "이 카테고리에선 이게 평균 이상이에요"
WITH scored AS (
  SELECT
    product_name,
    category,
    rating,
    rating_count,
    ROUND(AVG(rating) OVER (PARTITION BY category), 2) AS 카테고리평균평점,
    ROUND(AVG(rating_count) OVER (PARTITION BY category), 0) AS 카테고리평균리뷰수
  FROM project_name.dataset_name.amazon_clean
)
SELECT *
FROM scored
WHERE rating > 카테고리평균평점 AND rating_count > 카테고리평균리뷰수
ORDER BY category, rating_count DESC;


-- 시스템 8 — "지금 놓치면 아까운 특가"
WITH tiered AS (
  SELECT
    product_id, product_name, discount_percentage, rating,
    CASE
      WHEN discount_percentage >= 70 THEN '70%_이상'
      WHEN discount_percentage >= 50 THEN '50~70%'
      ELSE '30~50%'
    END AS discount_tier
  FROM project_name.dataset_name.amazon_clean
  WHERE discount_percentage >= 30
),
ranked AS (
  SELECT
    discount_tier, product_name, discount_percentage, rating,
    DENSE_RANK() OVER (PARTITION BY discount_tier ORDER BY rating DESC) AS tier_rank
  FROM tiered
)
SELECT *
FROM ranked
WHERE tier_rank <= 3
ORDER BY discount_tier desc, tier_rank;


-- 시스템 10 — "요즘 진짜 잘 나가는 상품 총정리"
SELECT
  product_id, product_name, rating, rating_count,
  ROUND(rating * LN(rating_count + 1), 2) AS popularity_index,
  RANK() OVER (ORDER BY rating * LN(rating_count + 1) DESC) AS overall_rank
FROM project_name.dataset_name.amazon_clean
ORDER BY overall_rank
LIMIT 100;