SELECT
    S.name AS "Student Name",      -- Student name
    C.name AS "Course Name",       -- Course name
    CR.grade AS "Grade",           -- Grade
    CR.credits AS "Credits Earned" -- Credits
FROM
    Student S
INNER JOIN
    Credits CR ON S.id = CR.id_student
INNER JOIN
    Course C ON CR.id_course = C.id
ORDER BY
    S.name, C.name;