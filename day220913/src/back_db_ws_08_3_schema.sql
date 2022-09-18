-- Active: 1663060283928@@127.0.0.1@3306@world

show tables;
-- 1. 도시명 kabul이 속한 국가의 이름은?
SELECT country.code, country.name
FROM country, city
WHERE country.Code = city.CountryCode
and city.name = 'kabul';

-- 2. 국가의 공식 언어 사용률이 100%인 국가의 정보를 출력하시오. 국가 이름으로 정렬( 오름차순 )

SELECT a.Name, b.Language, b.Percentage
FROM 
    country a,
    (
        SELECT CountryCode, Language, Percentage
        FROM countrylanguage
        WHERE Percentage = 100
        AND IsOfficial = 'T'
    ) b
WHERE a.Code = b.CountryCode
ORDER BY a.Name;

-- 3. 도시명 amsterdam에서 사용되는 주요 언어와 amsterdam이 속한 국가는?
SELECT a.Name, b.Language, c.name
FROM 
    country a,
    (
        SELECT CountryCode, Language, max(Percentage)
        FROM countrylanguage
        GROUP BY CountryCode
    ) b,
    city c
WHERE a.Code = b.CountryCode
AND a.Code = c.CountryCode
and c.Name = 'amsterdam';

-- 4. 국가명이 united로 시작하는 국가의 정보와 수도의 이름, 인구를 함께 출력하시오 ( 단, 수도 정보가 없다면 출력하지 않는다 )
SELECT a.Name, a.Capital, b.Name '수도', b.Population '수도인구'
FROM country a, city b
WHERE a.Capital = b.ID
and a.Name like 'united%';

-- 5. 국가명이 united로 시작하는 국가의 정보와 수도의 이름, 인구를 함께 출력하시오 ( 단, 수도 정보가 없다면 수도없음으로 출력한다. )
SELECT a.Name, a.Capital, b.Name '수도', b.Population '수도인구'
FROM country a, city b
WHERE a.Capital = b.ID
and a.Name like 'united%'
UNION
SELECT Name, Capital, '수도없음', '수도없음'
FROM country
WHERE 
Name like 'united%'
and Capital is null;

-- 6. 국가 코드 che의 공식 언어 중 가장 사용률이 높은 언어보다 사용율이 높은 공식언어를 사용하는 국가는 몇 곳인가?
SELECT count(*) '국가수'
FROM (
        SELECT CountryCode, max(Percentage)
        FROM countrylanguage
        WHERE IsOfficial = 'T'
        GROUP BY CountryCode
        HAVING max(Percentage) > (
                                    select max(Percentage) 
                                    from countrylanguage 
                                    where IsOfficial = 'T' 
                                    and CountryCode = 'che' 
                                    GROUP BY CountryCode 
                                )
    ) temp;

-- 7. 국가명이 south korea의 공식 언어는?
SELECT l.language
FROM country a, countrylanguage l
WHERE a.Code = l.CountryCode
and a.Name = 'south korea'
and l.isOfficial = 'T';

-- 8. 국가 이름이 bo로 시작하는 국가에 속한 도시의 개수를 출력하시오
SELECT a.Name, a.Code, count(*)
FROM country a, city b
WHERE a.Code = b.CountryCode
and a.Name like 'bo%'
GROUP BY a.Name;

-- 9. 국가 이름이 bo로 시작하는 국가에 속한 도시의 개수를 출력하시오. 도시가 없다면 단독 출력.
SELECT 
        a.Name,
        a.Code, 
        CASE
            WHEN b.ID is NULL
            THEN '단독'
            ELSE count(*)
        END '도시개수'
FROM 
    (
        SELECT Name, Code
        FROM country
        WHERE Name like 'bo%'
    ) a
    LEFT OUTER JOIN 
    city b
ON a.Code = b.CountryCode
GROUP BY a.Name;

-- 10. 인구가 가장 많은 도시는 어디인가?
SELECT CountryCode, Name, max(Population)
FROM city
ORDER BY 3 desc
limit 1;

-- 11. 가장 인구가 적은 도시의 이름, 인구수, 국가를 출력하시오
SELECT country.Name, city.CountryCode, city.Name, city.Population
FROM country, city
WHERE country.Code = city.CountryCode
ORDER BY 4
limit 1;

-- 12. KOR의 seoul보다 인구가 많은 도시들을 출력하시오.
SELECT CountryCode, Name, Population
FROM city
WHERE Population > (
                        SELECT Population
                        FROM city 
                        WHERE CountryCode = 'KOR'
                        and Name = 'Seoul'
                    );

-- 13. San Miguel 이라는 도시에 사는 사람들이 사용하는 공식 언어는?
SELECT CountryCode, Language
FROM countrylanguage
WHERE CountryCode in (
                        SELECT CountryCode 
                        FROM city
                        WHERE Name = 'San miguel'
                    )
and IsOfficial = 'T';

-- 14. 국가 코드와 해당 국가의 최대 인구수를 출력하시오 ( 국가 코드로 정렬 )
SELECT CountryCode, max(Population)
FROM city
GROUP BY CountryCode
ORDER BY CountryCode;

-- 15. 국가별로 가장 인구가 많은 도시의 정보를 출력하시오 ( 국가 코드로 정렬 )
SELECT CountryCode, Name, max(Population)
FROM city
GROUP BY CountryCode
ORDER BY CountryCode;

-- 16. 국가 이름과 함께 국가별로 가장 인구가 많은 도시의 정보를 출력하시오
SELECT city.CountryCode, country.Name, city.Name, max(city.Population)
FROM city, country
WHERE city.CountryCode = country.Code
GROUP BY CountryCode
ORDER BY CountryCode;

-- 17. 위 쿼리의 내용이 자주 사용된다. summary라는 이름의 view로 생성하시오.
CREATE VIEW summary AS
SELECT city.CountryCode '국가코드', country.Name '국가명', city.Name '도시명', max(city.Population) '최저 인구'
FROM city, country
WHERE city.CountryCode = country.Code
GROUP BY CountryCode
ORDER BY CountryCode;

select * from summary;

-- 18. summary에서 국가코드가 kor인 국가의 대표 도시를 조회하시오
SELECT * FROM summary WHERE 국가코드 = 'KOR';
