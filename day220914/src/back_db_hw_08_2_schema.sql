-- Active: 1663060283928@@127.0.0.1@3306@ssafy_user
user ssafy_user;
-- 1. user와 board를 full outer join하면 몇 개의 행이 조회되는지 출력
SELECT count(*)
FROM user JOIN board;

-- 2. 모든 board가 누가 작성했는지 알 수 있도록 작성자의 id와 title을 출력
SELECT user.id, board.title
FROM user, board
WHERE user.name = board.writername;

-- 3. board의 title에 '헐크'가 포함된 게시글의 id, title
SELECT user.id, board.title
FROM user, board
WHERE user.name = board.writername
and board.title like '%헐크%';

-- 4. 2018년 이전에 작성된 board를 email, createtime 출력
SELECT user.email, board.createtime
FROM user, board
WHERE user.name = board.writername
and year(board.createtime) < 2018;

-- 5. 각 년도에 몇명의 사용자들이 board를 작성했는지. 한명이 2개 이상 했다면 1번만 체크
SELECT year(createtime), count(*)
FROM board
GROUP BY year(createtime);

SELECT count(*) '사용자 수', a.year '년도'
FROM
        (
            SELECT year(createtime) 'year', writername, count(*) 
            FROM board 
            GROUP BY year(createtime), writername
        ) a
GROUP BY a.year;

-- 6. 2016년 이후 각 사용자들이 몇개의 board를 작성했는지 알 수 있도록 id와 작성한 board의 개수를 출력
SELECT user.id, count(*) '개수'
FROM user, board
WHERE user.name = board.writername
and year(board.createtime) >= 2016
GROUP BY user.id;

-- 7. id가 'BlackWidow'인 사용자보다 나이가 많은 user의 id와 age를 출력하시오
SELECT id, age
FROM user
WHERE age > (
                SELECT age
                FROM user
                WHERE id = 'BlackWidow'
);

-- 8. 2019년에 board를 작성한 적이 있는 사용자의 id를 출력하시오
SELECT id
FROM user
WHERE name in (
                SELECT DISTINCT writername 
                FROM board 
                WHERE year(createtime) = 2019
);