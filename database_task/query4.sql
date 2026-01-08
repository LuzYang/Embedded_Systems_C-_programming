SELECT
    S.name AS "Student Name",      -- Student name
    T.name AS "Task Name",         -- Task name
    C.time AS "Completion Time"    -- Completion time
FROM
    Completion C
INNER JOIN
    Student S ON C.id_student = S.id     -- 连接学生信息
INNER JOIN
    Assignment A ON C.id_assignment = A.id -- 连接作业信息
INNER JOIN
    Task T ON A.id_task = T.id           -- 连接任务信息
ORDER BY
    S.name, C.time;