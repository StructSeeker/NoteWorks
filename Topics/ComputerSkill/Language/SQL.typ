#outline()
= SQL必知必会（第5版）
<sql必知必会第5版>
#strong[作者]: Ben Forta

#strong[从 Readest 导出]: 2025-07-13

#let horizontalrule = line(length: 100%)

#horizontalrule

== 划线和笔记
<划线和笔记>
=== 第 1 课 了解SQL
<第-1-课-了解sql>
#quote(block: true)[
"数据库（database） 保存有组织的数据的容器（通常是一个文件或一组文件）"
]

#quote(block: true)[
“表中的任何列都可以作为主键，只要它满足以下条件：
任意两行都不具有相同的主键值；
每一行都必须具有一个主键值（主键列不允许空值NULL）；
主键列中的值不允许修改或更新；
主键值不能重用（如果某行从表中删除，它的主键不能赋给以后的新行）。”
]



#horizontalrule

=== 第 2 课 检索数据
<第-2-课-检索数据>
#quote(block: true)[
"多条SQL语句必须以分号（;）分隔"
]

#quote(block: true)[
"在处理SQL语句时，其中所有空格都被忽略。SQL语句可以写成长长的一行，也可以分写在多行。"
]

#quote(block: true)[
"SELECT DISTINCT vend\_id"
]

#quote(block: true)[
"注意：不能部分使用DISTINCT
DISTINCT关键字作用于所有的列，不仅仅是跟在其后的那一列"
]

#horizontalrule

=== 第 3 课 排序检索数据
<第-3-课-排序检索数据>
#quote(block: true)[
"在对文本性数据进行排序时，A与a相同吗？a位于B之前，还是Z之后？这些问题不是理论问题，其答案取决于数据库的设置方式。
在字典（dictionary）排序顺序中，A被视为与a相同，这是大多数数据库管理系统的默认做法。但是，许多DBMS允许数据库管理员在需要时改变这种行为（如果你的数据库包含大量外语字符，可能必须这样做）。"
]

#horizontalrule

=== 第 4 课 过滤数据
<第-4-课-过滤数据>
#quote(block: true)[
"在同时使用ORDER BY和WHERE子句时，应该让ORDER
BY位于WHERE之后，否则将会产生错误（关于ORDER BY的使用，请参阅第3课）"
]

#quote(block: true)[
"通过过滤选择不包含指定值的所有行时，你可能希望返回含NULL值的行。但是这做不到。因为NULL比较特殊，所以在进行匹配过滤或非匹配过滤时，不会返回这些结果。"
]

#horizontalrule

=== 第 14 课 组合查询
<第-14-课-组合查询>
#quote(block: true)[
"这一课一开始我们说过，UNION几乎总是完成与多个WHERE条件相同的工作。UNION
ALL为UNION的一种形式，它完成WHERE子句完成不了的工作。如果确实需要每个条件的匹配行全部出现（包括重复行），就必须使用UNION
ALL，而不是WHERE。"
]

#quote(block: true)[
"实际上，这些UNION很少使用，因为相同的结果可利用联结得到。"
]
#strong[笔记]:: ```sql 
SELECT id FROM tableA 
EXCEPT 
SELECT ClientId FROM tableB

SELECT id 
FROM tableA a LEFT JOIN tableB b 
ON b.ClientID = a.id 
WHERE b.id is null 
```


#horizontalrule
