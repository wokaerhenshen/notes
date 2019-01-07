1.
在mysql / sql 中我们可以使用 != 或者<> 都可以作为不等于来使用。

我们也可以在取余的时候使用 mod 或者 %

使用mod的时候就直接 mod(id,2) 就是说取id 除以2 的余数。

2.order by two fields.

SELECT FirstName, LastName, City, Country
  FROM Customer
 ORDER BY Country, City

3.Now I want to use a aggresive var such as count,avg or something.
So I need to use a [Group By] key word to say which one you want to group all the vars in.
And if you have addtional conditions you need to use [having] instead of [WHERE]

4. when my sql is 
declare @model char(5) = '$ooModelNumber'
            declare @days int = $ooDays
            declare @periods int = $ooPeriodEnd
            declare @period int = $ooPeriodStart
            declare @T table (Period int not null, ords int not null, entpage varchar(100) not null)
            While (@period < @periods) BEGIN
            insert into @T
            select @period [Period], sum(o.qty) ords,z.entpage from orderdata o 
            left join zordstats z on z.oid=o.oid
            where model = @model and z.entdate > getdate()-(@days*@period) and z.entdate < getdate()-(@days*(@period-1))
            group by z.entpage
            Set @period=@period+1
            END
            select entpage from @T
  
 And i want to execute the sqlsrv_query() method I will meet errors, what I need to do is :
 
 It's been a while but in case someone is still having this problem: all you have to do is to call SET NOCOUNT ON at the beginning of the stored procedure. This will prevent the "rows affected" messages to be sent to the client and be mistaken for the output of the procedure.



5. script to drop all tables in a db:
/* Azure friendly */
/* Drop all Foreign Key constraints */
DECLARE @name VARCHAR(128)
DECLARE @constraint VARCHAR(254)
DECLARE @SQL VARCHAR(254)

SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' ORDER BY TABLE_NAME)

WHILE @name is not null
BEGIN
    SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
    WHILE @constraint IS NOT NULL
    BEGIN
        SELECT @SQL = 'ALTER TABLE [dbo].[' + RTRIM(@name) +'] DROP CONSTRAINT [' + RTRIM(@constraint) +']'
        EXEC (@SQL)
        PRINT 'Dropped FK Constraint: ' + @constraint + ' on ' + @name
        SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' AND CONSTRAINT_NAME <> @constraint AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
    END
SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'FOREIGN KEY' ORDER BY TABLE_NAME)
END
GO

/* Drop all Primary Key constraints */
DECLARE @name VARCHAR(128)
DECLARE @constraint VARCHAR(254)
DECLARE @SQL VARCHAR(254)

SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' ORDER BY TABLE_NAME)

WHILE @name IS NOT NULL
BEGIN
    SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
    WHILE @constraint is not null
    BEGIN
        SELECT @SQL = 'ALTER TABLE [dbo].[' + RTRIM(@name) +'] DROP CONSTRAINT [' + RTRIM(@constraint)+']'
        EXEC (@SQL)
        PRINT 'Dropped PK Constraint: ' + @constraint + ' on ' + @name
        SELECT @constraint = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' AND CONSTRAINT_NAME <> @constraint AND TABLE_NAME = @name ORDER BY CONSTRAINT_NAME)
    END
SELECT @name = (SELECT TOP 1 TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_catalog=DB_NAME() AND CONSTRAINT_TYPE = 'PRIMARY KEY' ORDER BY TABLE_NAME)
END
GO

/* Drop all tables */
DECLARE @name VARCHAR(128)
DECLARE @SQL VARCHAR(254)

SELECT @name = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'U' AND category = 0 ORDER BY [name])

WHILE @name IS NOT NULL
BEGIN
    SELECT @SQL = 'DROP TABLE [dbo].[' + RTRIM(@name) +']'
    EXEC (@SQL)
    PRINT 'Dropped Table: ' + @name
    SELECT @name = (SELECT TOP 1 [name] FROM sysobjects WHERE [type] = 'U' AND category = 0 AND [name] > @name ORDER BY [name])
END
GO

6. sql中的事物（transcation 详解）如果一次性要向数据库中插入多条数据，用transcation
事务是在数据库上按照一定的逻辑顺序执行的任务序列，既可以由用户手动执行，也可以由某种数据库程序自动执行。

事务实际上就是对数据库的一个或者多个更改。当你在某张表上创建更新或者删除记录的时，你就已经在使用事务了。控制事务以保证数据完整性，并对数据库错误做出处理，对数据库来说非常重要。

实践中，通常会将很多 SQL 查询组合在一起，并将其作为某个事务一部分来执行。

事务的属性：

事务具有以下四个标准属性，通常用缩略词 ACID 来表示：

原子性：保证任务中的所有操作都执行完毕；否则，事务会在出现错误时终止，并回滚之前所有操作到原始状态。
一致性：如果事务成功执行，则数据库的状态得到了进行了正确的转变。
隔离性：保证不同的事务相互独立、透明地执行。
持久性：即使出现系统故障，之前成功执行的事务的结果也会持久存在。
事务控制：
有四个命令用于控制事务：

COMMIT：提交更改；
ROLLBACK：回滚更改；
SAVEPOINT：在事务内部创建一系列可以 ROLLBACK 的还原点；
SET TRANSACTION：命名事务；
COMMIT 命令：
COMMIT 命令用于保存事务对数据库所做的更改。

COMMIT 命令会将自上次 COMMIT 命令或者 ROLLBACK 命令执行以来所有的事务都保存到数据库中。
ROLLBACK 命令：
ROLLBACK 命令用于撤销尚未保存到数据库中的事务。

ROLLBACK 命令只能撤销自上次 COMMIT 命令或者 ROLLBACK 命令执行以来的事务。

7.What is “with (nolock)” in SQL Server?
WITH (NOLOCK) is the equivalent of using READ UNCOMMITED as a transaction isolation level. So, you stand the risk of reading an uncommitted row that is subsequently rolled back, i.e. data that never made it into the database. So, while it can prevent reads being deadlocked by other operations, it comes with a risk. In a banking application with high transaction rates, it's probably not going to be the right solution to whatever problem you're trying to solve with it IMHO.

8. In the where condition, if you want to [disable] the condition for a specific value
Use 
(P.CategoryId = @Category OR @Category = 0)
In this case if the @category = 0 then the where statement just omit the value and this condition just pass and doesn't take any effect.


9.
The SQL Server ISNULL() function lets you return an alternative value when an expression is NULL:

10.

The SQL UNION Operator
The UNION operator is used to combine the result-set of two or more SELECT statements.

Each SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in each SELECT statement must also be in the same order

UNION ALL Syntax
The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:
