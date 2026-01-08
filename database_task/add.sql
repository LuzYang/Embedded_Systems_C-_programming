-- -----------------------------------------------------
-- 1. 插入 Task 表数据 (任务)
-- -----------------------------------------------------
INSERT INTO Task (id, name, description) VALUES
(1, 'Database Schema Design', 'Design the ERD for the university system.'),
(2, 'SQL DDL Implementation', 'Write SQL DDL to create all tables.'),
(3, 'SQL DML Data Insertion', 'Populate the tables with sample data.'),
(4, 'Basic JOIN Queries', 'Practice simple INNER and LEFT JOINs.'),
(5, 'Advanced Aggregation', 'Use GROUP BY and aggregate functions.'),
(6, 'Reporting Query', 'Generate a performance summary report.');

-- -----------------------------------------------------
-- 2. 插入 Student 表数据 (学生)
-- -----------------------------------------------------
INSERT INTO Student (id, name, birthday, major) VALUES
(101, 'Alice Smith', '2002-05-15', 'Computer Science'),
(102, 'Bob Johnson', '2001-11-20', 'Business IT'),
(103, 'Charlie Brown', '2003-03-01', 'Computer Science'),
(104, 'Diana Prince', '2000-08-10', 'Data Science');

-- -----------------------------------------------------
-- 3. 插入 Course 表数据 (课程)
-- -----------------------------------------------------
INSERT INTO Course (id, name, description) VALUES
(201, 'Introduction to Databases', 'Fundamentals of relational databases and SQL.'),
(202, 'Advanced Data Modeling', 'Complex data structures and NoSQL concepts.'),
(203, 'Software Engineering 101', 'Introduction to the software development lifecycle.'),
(204, 'Data Structures', 'Algorithms and data organization.'); -- 这个课程暂时没有作业，用于测试 WHERE IS NULL 任务

-- -----------------------------------------------------
-- 4. 插入 Assignment 表数据 (作业)
-- 连接 Task (任务) 和 Course (课程)
-- -----------------------------------------------------
INSERT INTO Assignment (id, id_task, id_course) VALUES
(301, 1, 201), -- DB Schema Design for Intro DB
(302, 2, 201), -- SQL DDL for Intro DB
(303, 3, 201), -- SQL DML for Intro DB
(304, 4, 202), -- Basic JOIN Queries for Advanced Modeling
(305, 5, 202), -- Advanced Aggregation for Advanced Modeling
(306, 6, 203); -- Reporting Query for Software Eng

-- -----------------------------------------------------
-- 5. 插入 Completion 表数据 (完成记录)
-- 连接 Assignment (作业) 和 Student (学生)
-- -----------------------------------------------------
INSERT INTO Completion (id, id_assignment, id_student, time, description) VALUES
(401, 301, 101, '2024-10-10 10:00:00', 'Completed schema design.'),
(402, 302, 101, '2024-10-15 15:30:00', 'Completed DDL.'),
(403, 301, 102, '2024-10-11 09:00:00', 'Completed schema design.'),
(404, 304, 102, '2024-11-05 11:00:00', 'Completed basic joins.'),
(405, 303, 103, '2024-10-20 08:45:00', 'Completed DML.'),
(406, 301, 103, '2025-01-02 14:00:00', 'Late completion for assignment 301.'), -- 用于测试延迟完成 (晚于 2025-01-01)
(407, 305, 104, '2024-11-10 16:00:00', 'Completed aggregation.');

-- -----------------------------------------------------
-- 6. 插入 Credits 表数据 (学分)
-- 连接 Course (课程) 和 Student (学生)
-- -----------------------------------------------------
INSERT INTO Credits (id, id_course, id_student, date, description, grade, credits) VALUES
(501, 201, 101, '2024-12-01', 'Intro DB pass', 4, 5.0),
(502, 201, 102, '2024-12-01', 'Intro DB pass', 3, 5.0),
(503, 202, 102, '2024-12-15', 'Advanced Model pass', 4, 5.0),
(504, 202, 104, '2024-12-15', 'Advanced Model pass', 5, 5.0),
(505, 203, 101, '2025-01-05', 'SE 101 pass', 3, 3.0);
-- Charlie Brown (ID 103) 没有 Credits 记录，用于测试 "缺少学分的学生" 任务