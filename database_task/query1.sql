SELECT
    A.id AS "Assignment ID",  -- Assignment ID
    T.name AS "Task Name",    -- Task name
    C.name AS "Course Name"   -- Course name
FROM
    Assignment A
INNER JOIN
    Task T ON A.id_task = T.id
INNER JOIN
    Course C ON A.id_course = C.id;