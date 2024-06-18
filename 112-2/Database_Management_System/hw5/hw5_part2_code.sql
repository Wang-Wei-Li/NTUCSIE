/***** use database *****/
USE DB_class;

/***** info *****/
CREATE TABLE self (
    StuID varchar(10) NOT NULL,
    Department varchar(10) NOT NULL,
    SchoolYear int DEFAULT 1,
    Name varchar(10) NOT NULL,
    PRIMARY KEY (StuID)
);

INSERT INTO self
VALUES ('r12922116', '資工所', 1, '王偉力');

SELECT DATABASE();
SELECT * FROM self;

/* Prepared statement */
PREPARE stmt FROM 'SELECT * FROM student WHERE 系所 = ?;';

SET @department := '資工所';
EXECUTE stmt USING @department;
SET @department := '電信所';
EXECUTE stmt USING @department;

DEALLOCATE PREPARE stmt;

/* Stored-function */
delimiter //

CREATE FUNCTION fetch_chinese_name (mixed_name varchar(255))
RETURNS varchar(255) DETERMINISTIC
BEGIN
    DECLARE pointer int;
    SET pointer = LOCATE(' (', mixed_name);
    IF pointer = 0 THEN
        RETURN mixed_name;
    ELSE
        RETURN LEFT(mixed_name, pointer - 1); 
    END IF;
END//

CREATE FUNCTION fetch_english_name (mixed_name varchar(255))
RETURNS varchar(255) DETERMINISTIC
BEGIN
    DECLARE pointer1 int;
    DECLARE pointer2 int;
    SET pointer1 = LOCATE('(', mixed_name);
    SET pointer2 = LOCATE(')', mixed_name);
    IF pointer1 = 0 OR pointer2 = 0 THEN
        RETURN NULL;
    ELSE
        RETURN SUBSTRING(mixed_name, pointer1 + 1, pointer2 - pointer1 - 1);
    END IF;
END//

delimiter ;

SELECT fetch_chinese_name(姓名) AS 中文名, fetch_english_name(姓名) AS 英文名 FROM student;

/* Stored procedure */
delimiter //

CREATE PROCEDURE student_count(IN dept_name VARCHAR(255), OUT counts int)
BEGIN
    SELECT COUNT(*) INTO counts FROM student WHERE 系所 = dept_name;
END//

delimiter ;

SET @STCOUNT = 0;

CALL student_count('資工所', @STCOUNT);
SELECT @STCOUNT;

CALL student_count('電信所', @STCOUNT);
SELECT @STCOUNT;

/* View  */
delimiter //

CREATE VIEW new_student AS
SELECT 
    身份,
    系所,
    年級,
    學號,
    fetch_chinese_name(姓名) AS 中文名,
    fetch_english_name(姓名) AS 英文名,
    信箱,
    班別,
    `group`,
    captain
FROM student;//

delimiter ;

SELECT
    系所,
    年級,
    學號,
    中文名,
    英文名
FROM new_student
WHERE 系所 = '資工所';

/* Trigger */
CREATE TABLE record_table (
    record_id int AUTO_INCREMENT,
    op_type VARCHAR(10),
    user_name VARCHAR(255),
    timestamp DATETIME,
    PRIMARY KEY(record_id)
);

SET @NUMDEL = 0;
SET @NUMINS = 0;

delimiter //

CREATE TRIGGER record_delete
BEFORE DELETE ON student
FOR EACH ROW
BEGIN
    INSERT INTO record_table (op_type, user_name, timestamp)
    VALUES ('DELETE', USER(), NOW());
    SET @NUMDEL = @NUMDEL + 1;
END;//

CREATE TRIGGER record_insert
AFTER INSERT ON student
FOR EACH ROW
BEGIN
    INSERT INTO record_table (op_type, user_name, timestamp)
    VALUES ('INSERT', USER(), NOW());
    SET @NUMINS = @NUMINS + 1;
END;//

delimiter ;

SELECT * FROM record_table;
SELECT @NUMDEL, @NUMINS;

INSERT INTO student (身份, 系所, 年級, 學號, 姓名, 信箱, 班別, `group`, captain)
VALUES ('預研生', '資工所', 1, 'R13922001', '趙喜娜 (John Cena)', 'r13922001@ntu.edu.tw', '資料庫系統-從SQL到NoSQL (EE5178)', 0, 0);

INSERT INTO student (身份, 系所, 年級, 學號, 姓名, 信箱, 班別, `group`, captain)
VALUES ('預研生', '資工所', 1, 'R13922002', '周杰倫 (Jay Chou)', 'r13922002@ntu.edu.tw', '資料庫系統-從SQL到NoSQL (EE5178)', 0, 0);

INSERT INTO student (身份, 系所, 年級, 學號, 姓名, 信箱, 班別, `group`, captain)
VALUES ('預研生', '資工所', 1, 'R13922003', '快樂寶拉 (Happy Polla)', 'r13922003@ntu.edu.tw', '資料庫系統-從SQL到NoSQL (EE5178)', 0, 0);

DELETE FROM student WHERE 學號 = 'R13922002';
DELETE FROM student WHERE 學號 = 'R13922003';

SELECT * FROM record_table;
SELECT @NUMDEL, @NUMINS;

/* drop database */
DROP DATABASE DB_class;