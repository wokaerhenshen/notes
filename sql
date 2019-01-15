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

11. nosql(mongodb) and sql(mysql)
diff

When it comes to choosing a database, one of the biggest decisions is picking a relational (SQL) or non-relational (NoSQL) data structure. While both are viable options, there are certain key differences between the two that users must keep in mind when making a decision.

Here, we break down the most important distinctions and discuss two of the key players in the relational vs non-relational debate: MySQL and MongoDB.

This helps illustrate one of the fundamental differences between SQL relational and NoSQL non-relational databases, and this distinction has big implications. Let’s explain:

SQL databases use structured query language (SQL) for defining and manipulating data. On one hand, this is extremely powerful: SQL is one of the most versatile and widely-used options available, making it a safe choice and especially great for complex queries. On the other hand, it can be restrictive. SQL requires that you use predefined schemas to determine the structure of your data before you work with it. In addition, all of your data must follow the same structure. This can require significant up-front preparation, and, as with Town A, it can mean that a change in the structure would be both difficult and disruptive to your whole system.

A NoSQL database, on the other hand, has dynamic schema for unstructured data, and data is stored in many ways: it can be column-oriented, document-oriented, graph-based or organized as a KeyValue store. This flexibility means that:

You can create documents without having to first define their structure
Each document can have its own unique structure
The syntax can vary from database to database, and
You can add fields as you go.
The Scalability
In most situations, SQL databases are vertically scalable, which means that you can increase the load on a single server by increasing things like CPU, RAM or SSD. NoSQL databases, on the other hand, are horizontally scalable. This means that you handle more traffic by sharding, or adding more servers in your NoSQL database. It’s like adding more floors to the same building versus adding more buildings to the neighborhood. The latter can ultimately become larger and more powerful, making NoSQL databases the preferred choice for large or ever-changing data sets.

The Structure
SQL databases are table-based, while NoSQL databases are either document-based, key-value pairs, graph databases or wide-column stores. This makes relational SQL databases a better option for applications that require multi-row transactions - such as an accounting system - or for legacy systems that were built for a relational structure.

Some examples of SQL databases include MySQL, Oracle, PostgreSQL, and Microsoft SQL Server. NoSQL database examples include MongoDB, BigTable, Redis, RavenDB Cassandra, HBase, Neo4j and CouchDB.

SQL vs NoSQL: MySQL vs MongoDB
Now that we’ve established the key structural differences between SQL and NoSQL databases, let’s delve into the key functional differences between the two, looking specifically at MySQL and MongoDB as examples.

MySQL: The SQL Relational Database
The following are some MySQL benefits and strengths:

Maturity: MySQL is an extremely established database, meaning that there’s a huge community, extensive testing and quite a bit of stability.
Compatibility: MySQL is available for all major platforms, including Linux, Windows, Mac, BSD and Solaris. It also has connectors to languages like Node.js, Ruby, C#, C++, Java, Perl, Python and PHP, meaning that it’s not limited to SQL query language.
Cost-effective: The database is open source and free.
Replicable: The MySQL database can be replicated across multiple nodes, meaning that the workload can be reduced and the scalability and availability of the application can be increased.
Sharding: While sharding cannot be done on most SQL databases, it can be done on MySQL servers. This is both cost-effective and good for business.
MongoDB: The NoSQL Non-Relational Database
The following are some of MongoDB benefits and strengths:

Dynamic schema: As mentioned, this gives you flexibility to change your data schema without modifying any of your existing data.
Scalability: MongoDB is horizontally scalable, which helps reduce the workload and scale your business with ease.
Manageability: The database doesn’t require a database administrator. Since it is fairly user-friendly in this way, it can be used by both developers and administrators.
Speed: It’s high-performing for simple queries.
Flexibility: You can add new columns or fields on MongoDB without affecting existing rows or application performance.
So Which Database Is Right For Your Business?
MySQL is a strong choice for any business that will benefit from its pre-defined structure and set schemas. For example, applications that require multi-row transactions - like accounting systems or systems that monitor inventory - or that run on legacy systems will thrive with the MySQL structure.

MongoDB, on the other hand, is a good choice for businesses that have rapid growth or databases with no clear schema definitions. More specifically, if you cannot define a schema for your database, if you find yourself denormalizing data schemas, or if your schema continues to change - as is often the case with mobile apps, real-time analytics, content management systems, etc.- MongoDB can be a strong choice for you.

If you’re still uncertain about which type of database is best for your business, you can schedule a consultation with one of our experts today.

12.中文区别：“

MySQL是关系型数据库。

   优势：

在不同的引擎上有不同 的存储方式。

查询语句是使用传统的sql语句，拥有较为成熟的体系，成熟度很高。

开源数据库的份额在不断增加，mysql的份额页在持续增长。

   缺点：

在海量数据处理的时候效率会显著变慢。

Mongodb是非关系型数据库(nosql ),属于文档型数据库。文档是mongoDB中数据的基本单元，类似关系数据库的行，多个键值对有序地放置在一起便是文档，语法有点类似javascript面向对象的查询语言，它是一个面向集合的，模式自由的文档型数据库。

存储方式：虚拟内存+持久化。

查询语句：是独特的Mongodb的查询方式。

适合场景：事件的记录，内容管理或者博客平台等等。

架构特点：可以通过副本集，以及分片来实现高可用。

数据处理：数据是存储在硬盘上的，只不过需要经常读取的数据会被加载到内存中，将数据存储在物理内存中，从而达到高速读写。

成熟度与广泛度：新兴数据库，成熟度较低，Nosql数据库中最为接近关系型数据库，比较完善的DB之一，适用人群不断在增长。

优点：

快速！在适量级的内存的Mongodb的性能是非常迅速的，它将热数据存储在物理内存中，使得热数据的读写变得十分快。高扩展性，存储的数据格式是json格式！

缺点：

不支持事务，而且开发文档不是很完全，完善。

   Mysql和Mongodb主要应用场景

1.如果需要将mongodb作为后端db来代替mysql使用，即这里mysql与mongodb 属于平行级别，那么，这样的使用可能有以下几种情况的考量： (1)mongodb所负责部分以文档形式存储，能够有较好的代码亲和性，json格式的直接写入方便。(如日志之类) (2)从datamodels设计阶段就将原子性考虑于其中，无需事务之类的辅助。开发用如nodejs之类的语言来进行开发，对开发比较方便。 (3)mongodb本身的failover机制，无需使用如MHA之类的方式实现。

2.将mongodb作为类似redis ，memcache来做缓存db，为mysql提供服务，或是后端日志收集分析。 考虑到mongodb属于nosql型数据库，sql语句与数据结构不如mysql那么亲和 ，也会有很多时候将mongodb做为辅助mysql而使用的类redis memcache 之类的缓存db来使用。 亦或是仅作日志收集分析。
--------------------- 
接！

