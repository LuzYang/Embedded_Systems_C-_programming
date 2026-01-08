SELECT
    C.name AS "Course Name",
    COUNT(A.id) AS "Assignment Count"
FROM
    Course C
LEFT JOIN
    Assignment A ON C.id = A.id_course  -- *** 修正: C.id 是 Course 表的主键 ***
GROUP BY
    C.name
ORDER BY
    "Assignment Count" DESC, C.name;