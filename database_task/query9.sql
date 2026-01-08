SELECT
    C.name AS "Course Name",                                -- 课程名称
    COUNT(DISTINCT CR.id_student) AS "Total Students",      -- 计算获得该课程学分的学生总数（DISTINCT 避免重复计数）
    AVG(CR.grade) AS "Average Grade",                       -- 计算平均成绩
    SUM(CR.credits) AS "Total Credits Earned"               -- 计算总学分
FROM
    Course C
INNER JOIN
    Credits CR ON C.id = CR.id_course -- 
INNER JOIN
    Student S ON CR.id_student = S.id
GROUP BY
    C.name
ORDER BY
    "Total Students" DESC;