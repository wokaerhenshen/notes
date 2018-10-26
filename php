php some useful functions and methods.

1.When you want to compare two strings, never use "==" You shoulud use "==="

2. Method "isset($var)"
 Returns TRUE if var exists and has value other than NULL. FALSE otherwise. 
 
 3."@" before the function means that the function shouldn't output any error when you have a head @
 
 4.form submit to itself: action =  $_SERVER['PHP_SELF']
 
 5. Stirng and date covert :
 
     Use strtotime() on your first date then date('Y-m-d') to convert it back:

     $time = strtotime('10/16/2003');

     $newformat = date('Y-m-d',$time);

     echo $newformat;
     // 2003-10-16
     
   6.If you have a onlick event output by using echo, you should pay attention that “YOU CAN'T USE TWO SINGLE QUATION MARKS” both for the variable in the onlick function and for the function. You need to transfer the page to html and using another <?php ?> to make it work.

   7. ez way to create a form that submit to itself:
   
   echo "<form method='post' action='". $_SERVER['PHP_SELF'] ."'>";
   echo "</form>";

  8. Microsoft db function sqlsrv_fetch_array()
    The value it returns is the datatype in the table of database. For example, when the datatype in the databse is "date". The datatype what PHP get is also "date"
    But you can't just output a date to the page. You need to transfer it to a string. In this case '->format('Y-m-d')' is used to do the transform.
    Mention: The datatype thing!

 9. one form multiple submit buttons with different names, then 
 <input type="submit" name="publish" value="Publish">
<input type="submit" name="save" value="Save">
PHP side:
<?php
    if (isset($_POST['publish'])) {
        # Publish-button was clicked
    }
    elseif (isset($_POST['save'])) {
        # Save-button was clicked
    }
?>

This will work if you want different submit button get different actions.

10.If you want to execute one php code from another php file
just use include/include_one/require/require_once these four commands.

11.php 排序
1) 冒泡排序
循环一遍，最大的放在最右边。
2）插入排序
循环一遍，后面的一个一个往前面已经排序好的数字里面插。
3)选择排序
循环一遍，选出最小的放在最左边，然后从剩下的里面找最小的，依次差在之前找到的最小的后面即可。
4）快速排序
选一个基准元素，一般为第一个元素或者最后一个元素，在这边选取第一个元素为基准元素
将剩余元素推进两个数组，左array and right array
the elements in the left array is smaller than 基准元素
the elements in the right array is bigger than 基准元素
然后对两个array再进行快排，
最后用array_merge 将快排后的左数组，基准元素 与 快排后的右数组，一并merge了
最后的merge后的数组即为排序后的结果。

12.使用strip_tags() 函数来让 原来的string 摆脱 HTML, XML, and PHP tags.
Syntax：strip_tags(string,allow)


Example 1
Strip the string from HTML tags, but allow <b> tags to be used:

<?php
echo strip_tags("Hello <b><i>world!</i></b>","<b>");
?>


13. php  json转换

PHP has some built-in functions to handle JSON.

Objects in PHP can be converted into JSON by using the PHP function json_encode():

ex1:

<?php
$myObj->name = "John";
$myObj->age = 30;
$myObj->city = "New York";

$myJSON = json_encode($myObj);

echo $myJSON;
?>

ex2:

<?php
$myArr = array("John", "Mary", "Peter", "Sally");

$myJSON = json_encode($myArr);

echo $myJSON;
?>





