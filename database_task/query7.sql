SELECT
    A.id AS "Assignment ID",       -- 作业 ID
    T.name AS "Task Name",         -- 任务名称
    C.time AS "Completion Time"    -- 完成时间
FROM
    Completion C
INNER JOIN
    Assignment A ON C.id_assignment = A.id
INNER JOIN
    Task T ON A.id_task = T.id
WHERE
    C.time > '2025-01-01'; -- 关键：时间过滤条件