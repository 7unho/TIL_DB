-- Active: 1663060283928@@127.0.0.1@3306@world
use world;
show tables;

-- 1번 문제. 현재 날짜와, 올해가 며칠이 지났는지, 100일 후 날짜
SELECT 
		date_format(sysdate(), '%Y-%m-%d') '오늘',
        datediff(date_format(sysdate(), '%Y-%m-%d'), '2022-01-01') '올해 지난 날',
        date_format(date_add(sysdate(), interval 100 day), '%Y-%m-%d') '100일 후'
from dual;

SELECT 
		curdate() '오늘',
        datediff(curdate(), '2022-01-01') '올해 지난 날',
        date_add(curdate(), interval 100 day) '100일 후'
from dual;


-- 2번 문제. country에서 asia에 있는 나라 중 희망 수명이 있는 경우,
-- 			기대 수명이 80 초과면 장수국가, 60 초과면 일반국가, 그렇지 않다면 단명국가 ( 기대 수명으로 정렬 )
SELECT 
		Name,
        Continent,
        LifeExpectancy,
		CASE
			WHEN LifeExpectancy > 80
            THEN '장수국가'
            WHEN LifeExpectancy > 60
            THEN '일반국가'
            ELSE '단명국가'
		END
FROM country
WHERE continent = 'asia'
and LifeExpectancy is not null
ORDER BY LifeExpectancy;

-- 3번 문제. country에서 (gnp - gnpold)를 gnp향상이라고 출력, gnpold가 없다면 신규, name 정렬
SELECT
		Name,
        Gnp,
        GnpOld,
        ifnull((Gnp-GnpOld), '신규') 'gnp 향상'
FROM Country
ORDER BY Name;

-- 4번 문제. 2020년 어린이 날이 평일이면 행복, 주말이면 불행이라고 출력
SELECT
		weekday('2020-05-05'),
		CASE
			WHEN weekday('2020-05-05') < 5
            THEN '불행'
            ELSE '행복'
		END '행복여부'
FROM dual;

-- 5번 문제. country에서 전체 자료의 수와 독립 연도(IndepYear)가 있는 자료의 수를 출력하시오.
SELECT 
		count(*) '전체',
        (
			SELECT count(*)
			FROM country
            WHERE IndepYear is not null
		) '독립 연도 보유'
FROM country;


-- 6번 문제. country에서 기대 수명의 합계, 평균, 최대, 최소를 출력하시오. 평균은 2자리 반올림	
SELECT 
		sum(LifeExpectancy) '합계',
        round(avg(LifeExpectancy), 2) '평균',
        max(LifeExpectancy) '최대',
        min(LifeExpectancy) '최소'
FROM country;

-- 7번 문제. country에서 continent 별 국가의 개수와 인구의 합을 국가 수로 정렬한다.
SELECT
		Continent,
        count(*) '국가 수',
        sum(Population)
FROM country
GROUP BY Continent
ORDER BY 2 desc;

-- 8번 문제. country에서 대륙별 국가 표면적(SurfaceArea)의 합을 구하시오. 면적의 합으로 desc, limit 3
SELECT
		Continent,
        sum(SurfaceArea) '표면적 합'
FROM country
GROUP BY Continent
ORDER BY 2 desc
limit 3;

-- 9번 문제. country에서 대륙별로 인구기 50,000,000이상인 나라의 gnp 총합을 구하시오, 합으로 오름차순
SELECT
		Continent,
        sum(gnp) 'gnp 합',
        sum(Population)
FROM country
GROUP BY Continent
HAVING sum(Population) >= 50000000
ORDER BY 2;

-- 10번 문제. country에서 대륙별로 인구가 50,000,000이상인 나라의 gnp총 합을 구하시오( 합이 5,000,000 이상인것만)
SELECT
		Continent,
        sum(gnp) 'gnp 합'
FROM country
GROUP BY Continent
HAVING sum(Population) >= 50000000
and sum(gnp) >= 5000000;

-- 11번 문제. country에서 연도별로 10개 이상의 나라가 독립한 해는 언제인가?
SELECT
		IndepYear 'indepyear',
        count(*) '독립 국가 수'
FROM country
WHERE IndepYear >= 0
GROUP BY IndepYear
HAVING count(*) >= 10;

-- 12번 문제. country에서 국가별로 gnp와 함께 전세계 평균 gnp, 대륙 평균 gnp출력
SELECT
		a.Continent,
        Name,
        gnp,
        (
			SELECT avg(gnp)
            FROM country
		) '전세계 평균',
        b.test '대륙 평균'
FROM 
		country a,
        (
			SELECT Continent, avg(gnp) test
            from country 
            group by Continent
        ) b
WHERE a.Continent = b.Continent
GROUP BY a.Continent, Name, gnp
ORDER BY a.Continent;

use ssafydb;
