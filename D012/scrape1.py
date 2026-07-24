from playwright.sync_api import sync_playwright
from bs4 import BeautifulSoup
import pandas as pd
import time

url = "https://cine21.com/movie/info/?movie_id=62480"

all_reviews = []

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto(url, wait_until="networkidle")
    page.wait_for_timeout(2000)

    max_pages = 20  # 우선 20페이지까지 시도 

    for page_num in range(1, max_pages + 1):
        # nzreview 함수를 직접 호출해서 해당 페이지 리뷰 로딩
        page.evaluate(f"$('#netizen_review_area').nzreview('list', {page_num});")
        page.wait_for_timeout(1500)  # 로딩 대기

        html = page.content()
        soup = BeautifulSoup(html, "html.parser")

        li_list = soup.select("#netizen_review_area li")
        page_reviews = []

        for li in li_list:
            id_tag = li.select_one(".id")
            date_tag = li.select_one(".date")
            star_tag = li.select_one(".star_wrap .num")
            comment_tag = li.select_one(".comment")

            if not comment_tag or not star_tag:
                continue

            page_reviews.append({
                "id": id_tag.get_text(strip=True) if id_tag else None,
                "date": date_tag.get_text(strip=True) if date_tag else None,
                "rating": star_tag.get_text(strip=True) if star_tag else None,
                "comment": comment_tag.get_text(strip=True) if comment_tag else None,
            })

        # 더 이상 새로운 리뷰가 없으면(마지막 페이지 도달) 중단
        if not page_reviews:
            print(f"{page_num}페이지에서 리뷰 없음 → 수집 종료")
            break

        # 이미 수집한 리뷰와 중복이면(마지막 페이지에서 같은 내용 반복) 중단
        if page_reviews == all_reviews[-len(page_reviews):] if len(all_reviews) >= len(page_reviews) else False:
            print(f"{page_num}페이지가 이전 페이지와 동일 → 수집 종료")
            break

        all_reviews.extend(page_reviews)
        print(f"{page_num}페이지 수집 완료 (누적 {len(all_reviews)}개)")

    browser.close()

df = pd.DataFrame(all_reviews)
df.drop_duplicates(inplace=True)  # 혹시 모를 중복 제거
df.to_csv("cine21_reviews.csv", index=False, encoding="utf-8-sig")
print(f"최종 {len(df)}개 리뷰 수집 완료")
print(df.head())