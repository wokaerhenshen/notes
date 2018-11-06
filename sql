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
