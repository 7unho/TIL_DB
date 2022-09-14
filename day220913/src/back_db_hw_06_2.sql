-- Active: 1663060283928@@127.0.0.1@3306@ssafy_user
show tables;

-- 1. user 테이블에 전채 몇개의 행이 있는지 조회하시오.
SELECT count(*) '사용자 수'
FROM user;

-- 2. 전체 user의 age 평균을 조회하시오
SELECT avg(age) '평균'
FROM user;

-- 3. 전체 사용자의 age 합을 조회하시오
SELECT sum(age) '총 합'
FROM user;

-- 4. age가 35이상인 사용자의 평균 age를 구하시오 ( 둘 쨰 자리 )
SELECT round(avg(age), 2) '평균'
FROM user
WHERE age >= 35;

-- 5. writername 별 board의 개수
SELECT writername, count(*) '개수'
FROM board
GROUP BY writername;

-- 6. writername 별 토르 사용자의 최근 생성일자를 구하라. createtime
SELECT writername, max(createtime) '날짜'
FROM board
WHERE writername = '토르'
GROUP BY writername;

-- 7. 2017년 이후 writername별 사용자의 board 개수
SELECT writername, createtime, count(*) '개수'
FROM board
WHERE year(createtime) >= 2017
GROUP BY writername;
