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
