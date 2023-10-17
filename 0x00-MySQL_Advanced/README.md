# 0x00. MySQL advanced

### Learning Objectives

At the end of this project, you are expected to be able to explain to anyone, without the help of Google:

#### General

-   How to create tables with constraints
-   How to optimize queries by adding indexes
-   What is and how to implement stored procedures and functions in MySQL
-   What is and how to implement views in MySQL
-   What is and how to implement triggers in MySQL

## Requirements

### General

- All your files will be executed on Ubuntu 18.04 LTS using MySQL 5.7 (version 5.7.30)
- All your files should end with a new line
- All your SQL queries should have a comment just before (i.e. syntax above)
- All your files should start by a comment describing the task
- All SQL keywords should be in uppercase (`SELECT`, `WHERE`…)
- A `README.md` file, at the root of the folder of the project, is mandatory
- The length of your files will be tested using `wc`

## More Info

#### Comment for your SQL file:

```sql
$ cat my_script.sql
-- 3 first students in the Batch ID=3
-- because Batch 3 is the best!
SELECT id, name FROM students WHERE batch_id = 3 ORDER BY created_at DESC LIMIT 3;
$
```

#### Use “container-on-demand” to run MySQL
- Ask for container Ubuntu 18.04 - Python 3.7
- Connect via SSH
- Or via the WebTerminal
- In the container, you should start MySQL before playing with it:

```sql
$ service mysql start
 * MySQL Community Server 5.7.30 is started
$
$ cat 0-list_databases.sql | mysql -uroot -p my_database
Enter password: 
Database
information_schema
mysql
performance_schema
sys
$
```
In the container, credentials are `root/root`

#### How to import a SQL dump

```sql
$ echo "CREATE DATABASE hbtn_0d_tvshows;" | mysql -uroot -p
Enter password: 
$ curl "https://s3.amazonaws.com/intranet-projects-files/holbertonschool-higher-level_programming+/274/hbtn_0d_tvshows.sql" -s | mysql -uroot -p hbtn_0d_tvshows
Enter password: 
$ echo "SELECT * FROM tv_genres" | mysql -uroot -p hbtn_0d_tvshows
Enter password: 
id  name
1   Drama
2   Mystery
3   Adventure
4   Fantasy
5   Comedy
6   Crime
7   Suspense
8   Thriller
$
```

## Tasks

#### 0. We are all unique!

Write a SQL script that creates a table `users` following these requirements:

-   `id`, integer, never null, auto increment and primary key
-   `email`, string (255 characters), never null and unique
-   `name`, string (255 characters)
- If the table already exists, your script should not fail
- Your script can be executed on any database

Context: ` Make an attribute unique directly in the table schema will enforced your business rules and avoid bugs in your application`

File: **[0-uniq_users.sql](0-uniq_users.sql)**

#### 1. In and not out

Write a SQL script that creates a table `users` following these requirements:

-   `id`, integer, never null, auto increment and primary key
-   `email`, string (255 characters), never null and unique
-   `name`, string (255 characters)
-   `country`, enumeration of countries: `US`, `CO` and `TN`, never null (= default will be the first element of the enumeration, here `US`)

- If the table already exists, your script should not fail
- Your script can be executed on any database

Context: `An enumeration is a data type that consists of a set of valid values called elements. The use of enumeration restricts the range of possible values for a column.`

File: **[1-uniq_users.sql](1-uniq_users.sql)**

#### 2. Best band ever!

Write a SQL script that ranks country origins of bands, ordered by the number of (non-unique) fans

- Column names must be: origin and nb_fans
- Your script can be executed on any database

Context: Calculate/compute something is always power intensive… better to distribute the load!

File: **[2-fans.sql](2-fans.sql)**

#### 3. Old school band

Write a SQL script that lists all bands with Glam rock as their main style, ranked by their longevity

- Column names must be: band_name and lifespan  (in years until 2022 - please use 2022 instead of YEAR(CURDATE()))
- You should use attributes formed and split for computing the lifespan
- Your script can be executed on any database


Context: `Split and form attributes are very useful to store data that can be computed from other data. It avoids redundant data, which is a source of bugs and performance issues.`

File: **[3-glam_rock.sql](3-glam_rock.sql)**

#### 4. Buy buy buy

Write a SQL script that creates a trigger that decreases the quantity of an item after adding a new order.

Quantity in the table items can be negative.




# Stored Procedures

#### Why Stored Procedures?

-   Stored procedures are used to encapsulate a set of operations or queries to execute on a database server. This is a way to reduce network traffic between clients and servers, because clients can execute a stored procedure to execute multiple SQL statements at once.

- Stored procedures are fast. MySQL server takes some advantage of caching, just as prepared statements do. The main speed gain comes from reduction of network traffic. If you have a repetitive task that requires checking, looping, multiple statements, and no user interaction, do it with a single call to a procedure that's stored on the server.

- Stored procedures are portable. When you write your stored procedure in SQL, you know that it will run on every platform that MySQL runs on, without obliging you to install an additional runtime-environment package, or set permissions for program execution in the operating system, or deploy different packages if you have different computer types. 

### Create Procedure

```sql
CREATE [DEFINER = { user | CURRENT_USER }]          
PROCEDURE sp_name ([proc_parameter[,...]])          
[characteristic ...] routine_body    
proc_parameter: [ IN | OUT | INOUT ] param_name type    
type:          
Any valid MySQL data type    
characteristic:          
COMMENT 'string'     
| LANGUAGE SQL      
| [NOT] DETERMINISTIC      
| { CONTAINS SQL | NO SQL | READS SQL DATA 
| MODIFIES SQL DATA }      
| SQL SECURITY { DEFINER | INVOKER }    
routine_body:      
Valid SQL routine statement
```

Before create a procedure we need some information which are described in this section :

-   **DEFINER** : The user who creates the procedure becomes the definer. The definer determines the permissions available to the procedure. If you do not specify a definer, the default definer is the user who executes the CREATE PROCEDURE statement. The definer must have the CREATE ROUTINE privilege, otherwise the procedure creation fails. The definer cannot be changed after the procedure is created.

-   **proc_parameter** : The parameters passed to the procedure. The parameters can be IN, OUT, or INOUT parameters. The parameters are optional; that is, a procedure may have no parameters.

-   **characteristic** : The characteristics of the procedure. The characteristics can be COMMENT, LANGUAGE, DETERMINISTIC, CONTAINS SQL, NO SQL, READS SQL DATA, MODIFIES SQL DATA, or SQL SECURITY. The characteristics are optional; that is, a procedure may have no characteristics.

-  **Pick a delimiter** : The delimiter is the character or string of characters which is used to complete an SQL statement. By default we use semicolon (;) as a delimiter. But this causes problem in stored procedure because a procedure can have many statements, and everyone must end with a semicolon. So for your delimiter, pick a string which is rarely occur within statement or within procedure.

- **SQL SECURITY { DEFINER | INVOKER }** : an be defined as either SQL SECURITY DEFINER or SQL SECURITY INVOKER to specify the security context; that is, whether the routine executes using the privileges of the account named in the routine DEFINER clause or the user who invokes it. This account must have permission to access the database with which the routine is associated. The default value is DEFINER. The user who invokes the routine must have the EXECUTE privilege for it, as must the DEFINER account if the routine executes in definer security context.

### Call a Procedure

```sql
CALL procedure_name([parameter[,...]])
```

### SHOW CREATE PROCEDURE

This statement is a MySQL extension. It returns the exact string that can be used to re-create the named stored procedure. Both statement require that you be the owner of the routine. Here is the syntax :

```sql
SHOW CREATE PROCEDURE procedure_name
```

## MySQL : Compound-Statement Syntax

A compound statement is a block that can contain other blocks; it is used to group statements for procedural statements, such as stored procedures and functions, and triggers. The following sections describe the syntax for each type of compound statement.

### BEGIN ... END Compound-Statement Syntax

```sql
[begin_label:] BEGIN
    statement_list
END [end_label]
```

#### Label Statement Syntax

```sql
[begin_label:] 
BEGIN    
[statement_list]  
END [end_label]    
[begin_label:] 
LOOP      
statement_list  
END LOOP 
[end_label]    
[begin_label:] 
REPEAT            
statement_list  
UNTIL search_condition  
END 
REPEAT [end_label]    
[begin_label:] 
WHILE search_condition 
DO           
statement_list  
END WHILE 
[end_label]
```

Labels are permitted for BEGIN ... END blocks and for the LOOP, REPEAT, and WHILE statements. A label is an identifier followed by a colon. To each label corresponds a statement list that can be used with LEAVE to exit the labeled statement. The statement list can be empty.

### DECLARE Statement Syntax

```sql
DECLARE var_name[, var_name] ... type [DEFAULT value]
```

The DECLARE statement is used to define various items local to a routine:

Declarations follow the following order :

- Cursor declarations must appear before handler declarations.
- Variable and condition declarations must appear before cursor or handler declarations.

### Local Variables

Local variables are declared within stored procedures and are only valid within the BEGIN…END block where they are declared. Local variables can have any SQL data type. 

### DECLARE ... HANDLER Syntax

```sql
DELIMITER $$
CREATE PROCEDURE my_procedure_Local_Variables()
BEGIN   /* declare local variables */   
DECLARE a INT DEFAULT 10;   
DECLARE b, c INT;    /* using the local variables */   
SET a = a + 100;   
SET b = 2;   
SET c = a + b;    
BEGIN      /* local variable in nested block */      
DECLARE c INT;             
SET c = 5;       
/* local variable c takes precedence over the one of the          
same name declared in the enclosing block. */       
SELECT a, b, c;   
END;    
SELECT a, b, c;
END$$
```

### User Variables

In MySQL stored procedures, user variables are referenced with an ampersand (@) prefixed to the user variable name (for example, @x and @y).

## MySQL: Procedure Parameters

### IN Parameter
- an IN parameter passes a value into a procedure. The procedure might modify the value, but the modification is not visible to the caller when the procedure returns. To declare an IN parameter, use the IN keyword.

```sql
CREATE PROCEDURE procedure_name(IN param_name datatype)
```

```sql
mysql> CREATE PROCEDURE my_proc_IN (IN var1 INT)
-> BEGIN
-> SELECT * FROM jobs LIMIT var1;
-> END$$
Query OK, 0 rows affected (0.00 sec)
To execute the first 2 rows from the 'jobs' table execute the following command :

mysql> CALL my_proc_in(2)$$
+---------+-------------------------------+------------+------------+
| JOB_ID  | JOB_TITLE                     | MIN_SALARY | MAX_SALARY |
+---------+-------------------------------+------------+------------+
| AD_PRES | President                     |      20000 |      40000 |
| AD_VP   | Administration Vice President |      15000 |      30000 |
+---------+-------------------------------+------------+------------+
2 rows in set (0.00 sec)Query OK, 0 rows affected
```

### OUT Parameter
- an OUT parameter passes a value from the procedure back to the caller. Its initial value is NULL within the procedure, and its value is visible to the caller when the procedure returns. To declare an OUT parameter, use the OUT keyword.

```sql
CREATE PROCEDURE procedure_name(OUT param_name datatype)
```

MySQL Procedure : Parameter OUT example

The following example shows a simple stored procedure that uses an OUT parameter. Within the procedure MySQL MAX() function retrieves maximum salary from MAX_SALARY of jobs table.

```sql
mysql> DELIMITER $$
mysql> CREATE PROCEDURE my_proc_OUT (OUT highest_salary INT)
-> BEGIN
-> SELECT MAX(MAX_SALARY) INTO highest_salary FROM JOBS;
-> END$$
Query OK, 0 rows affected (0.00 sec)
```

- In the body of the procedure, the parameter will get the highest salary from MAX_SALARY column. After calling the procedure the word OUT tells the DBMS that the value goes out from the procedure. Here highest_salary is the name of the output parameter and we have passed its value to a session variable named @M, in the CALL statement.

```sql
mysql> CALL my_proc_OUT(@M)$$
Query OK, 1 row affected (0.03 sec)

mysql< SELECT @M$$+-------+
| @M    |
+-------+
| 40000 |
+-------+
1 row in set (0.00 sec)
```


### INOUT Parameter
- an INOUT parameter is initialized by the caller, can be modified by the procedure, and any change made by the procedure is visible to the caller when the procedure returns. To declare an INOUT parameter, use the INOUT keyword.

```sql
CREATE PROCEDURE procedure_name(INOUT param_name datatype)
```

#### MySQL Procedure : Parameter INOUT example

- The following example shows a simple stored procedure that uses an INOUT parameter and an IN parameter. The user will supply 'M' or 'F' through IN parameter (emp_gender) to count a number of male or female from user_details table. The INOUT parameter (mfgender) will return the result to a user. Here is the code and output of the procedure :

```sql
sql> CALL my_proc_OUT(@M)$$Query OK, 1 row affected (0.03 sec)mysql> CREATE PROCEDURE my_proc_INOUT (INOUT mfgender INT, IN emp_gender CHAR(1))
-> BEGIN
-> SELECT COUNT(gender) INTO mfgender FROM user_details WHERE gender = emp_gender;
-> END$$
Query OK, 0 rows affected (0.00 sec)
```

- Now check the number of male and female users of the said tables :

```sql
mysql> CALL my_proc_INOUT(@C,'M')$$
Query OK, 1 row affected (0.02 sec)

mysql> SELECT @C$$
+------+
| @C   |
+------+
|    3 |
+------+
1 row in set (0.00 sec)

mysql> CALL my_proc_INOUT(@C,'F')$$
Query OK, 1 row affected (0.00 sec)

mysql> SELECT @C$$
+------+
| @C   |
+------+
|    1 |
+------+
1 row in set (0.00 sec)
```

### MySQL: Flow Control Statements

- MySQL supports the IF, CASE, ITERATE, LEAVE LOOP, WHILE, and REPEAT constructs for flow control within stored programs. These constructs are described in the following sections.

#### IF Statement Syntax

```sql
IF search_condition THEN statement_list
    [ELSEIF search_condition THEN statement_list] ...
    [ELSE statement_list]
END IF
```

#### Example

```sql
DELIMITER $$
CREATE DEFINER=`root`@`127.0.0.1` 
PROCEDURE `GetUserName`(INOUT user_name varchar(16),
IN user_id varchar(16))
BEGIN
DECLARE uname varchar(16);
SELECT name INTO uname
FROM user
WHERE userid = user_id;
IF user_id = "scott123" 
THEN
SET user_name = "Scott";
ELSEIF user_id = "ferp6734" 
THEN
SET user_name = "Palash";
ELSEIF user_id = "diana094" 
THEN
SET user_name = "Diana";
END IF;
END
Execute the procedure:

mysql> CALL GetUserName(@A,'scott123')$$
Query OK, 1 row affected (0.00 sec)

mysql> SELECT @A;
    -> $$
+-------+
| @A    |
+-------+
| Scott |
+-------+
1 row in set (0.00 sec)
```

#### CASE Statement Syntax

```sql
CASE case_value
    WHEN when_value THEN statement_list
    [WHEN when_value THEN statement_list] ...
    [ELSE statement_list]
END CASE
```

#### Example


Example:

We have table called 'jobs' with following records :

+------------+---------------------------------+------------+------------+
| JOB_ID     | JOB_TITLE                       | MIN_SALARY | MAX_SALARY |
+------------+---------------------------------+------------+------------+
| AD_PRES    | President                       |      20000 |      40000 |
| AD_VP      | Administration Vice President   |      15000 |      30000 |
| AD_ASST    | Administration Assistant        |       3000 |       6000 |
| FI_MGR     | Finance Manager                 |       8200 |      16000 |
| FI_ACCOUNT | Accountant                      |       4200 |       9000 |
| AC_MGR     | Accounting Manager              |       8200 |      16000 |
| AC_ACCOUNT | Public Accountant               |       4200 |       9000 |
| SA_MAN     | Sales Manager                   |      10000 |      20000 |
| SA_REP     | Sales Representative            |       6000 |      12000 |
| PU_MAN     | Purchasing Manager              |       8000 |      15000 |
| PU_CLERK   | Purchasing Clerk                |       2500 |       5500 |
| ST_MAN     | Stock Manager                   |       5500 |       8500 |
| ST_CLERK   | Stock Clerk                     |       2000 |       5000 |
| SH_CLERK   | Shipping Clerk                  |       2500 |       5500 |
| IT_PROG    | Programmer                      |       4000 |      10000 |
| MK_MAN     | Marketing Manager               |       9000 |      15000 |
| MK_REP     | Marketing Representative        |       4000 |       9000 |
| HR_REP     | Human Resources Representative  |       4000 |       9000 |
| PR_REP     | Public Relations Representative |       4500 |      10500 |
+------------+---------------------------------+------------+------------+

- Here is the procedure:

```sql
DELIMITER $$
CREATE PROCEDURE `hr`.`my_proc_CASE` 
(INOUT no_employees INT, IN salary INT)
BEGIN
CASE
WHEN (salary>10000) 
THEN (SELECT COUNT(job_id) INTO no_employees 
FROM jobs 
WHERE min_salary>10000);
WHEN (salary<10000) 
THEN (SELECT COUNT(job_id) INTO no_employees 
FROM jobs 
WHERE min_salary<10000);
ELSE (SELECT COUNT(job_id) INTO no_employees 
FROM jobs WHERE min_salary=10000);
END CASE;
END$$
```

- In the above procedure, we pass the salary (amount) variable through IN parameter. Within the procedure, there is CASE statement along with two WHEN and an ELSE which will test the condition and return the count value in no_employees. Let execute the procedure in MySQL command prompt :

Number of employees whose salary greater than 10000 :

```sql
mysql> CALL my_proc_CASE(@C,10001);
Query OK, 1 row affected (0.00 sec)

mysql> SELECT @C;
+------+
| @C   |
+------+
|    2 |
+------+
1 row in set (0.00 sec)
```

- Number of employees whose salary less than 10000 :

```sql
mysql> CALL my_proc_CASE(@C,9999);
Query OK, 1 row affected (0.00 sec)

mysql> SELECT @C;
+------+
| @C   |
+------+
|    16|
+------+

1 row in set (0.00 sec)
```

- Number of employees whose salary equal to 10000 :

```sql
mysql> CALL my_proc_CASE(@C,10000);
Query OK, 1 row affected (0.00 sec)
mysql> SELECT @C;
+------+
| @C   |
+------+
|    1 |
+------+
1 row in set (0.00 sec)
```

