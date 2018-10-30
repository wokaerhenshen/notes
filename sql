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
