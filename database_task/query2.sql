SELECT
    C.id AS "Completion ID",       -- Completion ID
    C.time AS "Completion Time",   -- Completion time
    A.id AS "Assignment ID",       -- Assignment ID
    T.name AS "Task Name"          -- Task name
FROM
    Completion C
INNER JOIN
    Assignment A ON C.id_assignment = A.id
INNER JOIN
    Task T ON A.id_task = T.id
ORDER BY
    C.time;