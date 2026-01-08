-- -----------------------------------------------------
-- 1. 创建 Task 表 (任务)
-- -----------------------------------------------------
CREATE TABLE Task (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- -----------------------------------------------------
-- 2. 创建 Student 表 (学生)
-- -----------------------------------------------------
CREATE TABLE Student (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthday DATE,
    major VARCHAR(255)
);

-- -----------------------------------------------------
-- 3. 创建 Course 表 (课程)
-- -----------------------------------------------------
CREATE TABLE Course (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- -----------------------------------------------------
-- 4. 创建 Assignment 表 (作业)
-- 依赖 Task 和 Course
-- -----------------------------------------------------
CREATE TABLE Assignment (
    id INT PRIMARY KEY,
    id_task INT NOT NULL,
    id_course INT NOT NULL,
    FOREIGN KEY (id_task) REFERENCES Task(id),
    FOREIGN KEY (id_course) REFERENCES Course(id)
);

-- -----------------------------------------------------
-- 5. 创建 Completion 表 (完成记录)
-- 依赖 Assignment 和 Student
-- -----------------------------------------------------
CREATE TABLE Completion (
    id INT PRIMARY KEY,
    id_assignment INT NOT NULL,
    id_student INT NOT NULL,
    time TIMESTAMP, -- 使用 TIMESTAMP 或 DATETIME 记录完成时间
    description TEXT, -- 根据PDF第2页，Completion表中包含description字段
    FOREIGN KEY (id_assignment) REFERENCES Assignment(id),
    FOREIGN KEY (id_student) REFERENCES Student(id)
);

-- -----------------------------------------------------
-- 6. 创建 Credits 表 (学分)
-- 依赖 Course 和 Student
-- -----------------------------------------------------
CREATE TABLE Credits (
    id INT PRIMARY KEY,
    id_course INT NOT NULL,
    id_student INT NOT NULL,
    date DATE,
    description TEXT,
    grade INT, -- 假设成绩为整数
    credits DECIMAL(4, 2), -- 学分可能包含小数
    FOREIGN KEY (id_course) REFERENCES Course(id),
    FOREIGN KEY (id_student) REFERENCES Student(id)
);