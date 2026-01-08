SELECT
    S.name AS "Student Name",
    S.major AS "Major"
FROM
    Student S
LEFT JOIN
    Credits CR ON S.id = CR.id_student
WHERE
    CR.id IS NULL; -- 关键：只有未获得学分的学生，其 CR.id 才会是 NULL