SELECT
    C.name AS "Course Name",        -- 课程名称
    C.description AS "Description"  -- 课程描述
FROM
    Course C
LEFT JOIN
    Assignment A ON C.id = A.id_course
WHERE
    A.id IS NULL; -- 关键：只保留在 Assignment 表中找不到匹配项的行