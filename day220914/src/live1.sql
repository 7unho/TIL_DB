-- Active: 1663060283928@@127.0.0.1@3306@world

SHOW TABLES;

use SCOTT;

-- BONUS : 사원명(ename), 직무(job), 급여(sal), 커미션(comm)

-- DEPT : 부서번호(deptno), 부서명(dname), 지역(loc)

-- EMP : 사번(empno), 사원명(ename), 직무(job), 사수(mgr), 입사일(hiredate), 급여(sal), 커미션(comm), 부서번호(deptno)

-- SALGRADE : 등급(grade), 최소범위(losal) ~ 최대범위(hisal)

show tables;

SELECT * FROM emp;

SELECT * FROM salgrade;

SELECT dname, loc FROM dept;

SELECT @test:= '안녕, SQL ~!!';

SELECT empno '사원번호', ename '사원명' FROM emp;

SELECT empno '사원번호', ename '사원명', sal '급여', sal * 12 '연봉' FROM emp;

SELECT CONCAT(ename, '사원의 직책은 ', job, '입니다') FROM emp;

SELECT distinct job FROM emp;

SELECT 10 + 3, 10 * 3, 10 - 3, 10 / 3, 10 % 3, floor(10/3) FROM dual;

SELECT empno, ename, job, sal FROM emp WHERE deptno = 20;

SELECT empno, ename, job, hiredate FROM emp WHERE job = 'manager';

SELECT empno, ename, sal FROM emp WHERE sal >= 2000;

SELECT empno, ename, deptno FROM emp WHERE ename = 'FORD';

SELECT
    empno,
    ename,
    deptno,
    hiredate
FROM emp
WHERE hiredate >= '1981-06-01'
ORDER BY hiredate;

SELECT empno, ename, mgr FROM emp WHERE deptno = 10;

SELECT empno, ename, mgr FROM emp WHERE deptno in (20, 30);

SELECT deptno, dname, loc FROM dept WHERE deptno in (10, 20);

SELECT grade, losal, hisal FROM salgrade WHERE grade = 3;

SELECT empno, ename, sal FROM emp WHERE ename like 'A%';

SELECT empno, ename, sal FROM emp WHERE ename like '%S';

SELECT empno, ename, sal FROM emp WHERE ename like '%A%';

SELECT empno, ename, sal FROM emp WHERE ename like '__A%';

SELECT empno, ename, sal FROM emp WHERE sal BETWEEN 1600 and 3000;

SELECT
    empno,
    ename,
    deptno,
    comm
FROM emp
WHERE comm <= 0 or comm is null;

SELECT empno, ename, deptno, comm FROM emp WHERE comm is not NULL;

SELECT empno, ename, sal, sal * 12 + comm FROM emp;

SELECT empno, ename, IFNULL(comm, 0) FROM emp;

SELECT empno, ename, IFNULL(comm, '없음') FROM emp;

SELECT
    empno,
    ename,
    job,
    IFNULL(mgr, 'CEO')
FROM emp
WHERE deptno = 10;

SELECT empno, ename, sal
FROM emp
WHERE deptno = 30
ORDER BY empno desc;

SELECT
    empno,
    ename,
    sal,
    hiredate
FROM emp
WHERE deptno = 30
ORDER BY hiredate desc;

SELECT empno, ename, sal FROM emp ORDER BY sal desc, ename;

use SCOTT;

SELECT ename, sal
FROM emp
WHERE sal >= (
        SELECT
            max(sal)
        FROM emp
        WHERE
            ename = 'SCOTT'
    );

SELECT deptno, dname, loc
FROM dept
WHERE deptno in (
        SELECT
            deptno
        FROM emp
        WHERE
            job = 'CLERK'
    );

SELECT empno, ename
FROM emp
WHERE deptno in (
        SELECT
            deptno
        FROM emp
        WHERE
            ename like '%T%'
    );

SELECT emp.ename, dept.deptno
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    and loc = 'NEW YORK';

SELECT emp.ename, sal
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    and dname = 'SALES';

SELECT * from emp;

SELECT ename, sal
FROM emp
WHERE mgr = (
        SELECT empno
        FROM emp
        WHERE
            ename = 'KING'
    );

SELECT a.ename, a.sal, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno;

SELECT a.ename, a.sal
FROM emp a, emp b
WHERE a.mgr = b.empno
and b.ename = 'KING';

SELECT empno, ename, sal
FROM emp
WHERE deptno in (
        SELECT
            deptno
        FROM emp
        WHERE sal >= (
                SELECT
                    avg(sal)
                FROM
                    emp
            )
            and ename like '%S%'
    );


SELECT ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT emp.ename, emp.job, emp.deptno, dept.loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
and emp.deptno = 30;

SELECT ename, job, deptno, loc
FROM emp INNER JOIN dept USING(deptno)
WHERE deptno = 30;

SELECT ename, comm, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
and comm > 0;


SELECT ename, job, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
and loc = 'DALLAS';

SELECT ename, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
and ename like '%A%';

SELECT ename, job, sal, grade
FROM emp, salgrade
WHERE emp.sal BETWEEN losal AND hisal;

SELECT a.ename, b.ename, a.deptno
FROM emp a, emp b
WHERE a.deptno = b.deptno
and a.ename != b.ename;