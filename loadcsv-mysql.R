library(RMySQL)
con=dbConnect(MySQL(),user="root",password="jun@325",dbname="test")
table.names=dbListTables(con)
fields.names=dbListFields(con,"NapaWinery")
# dbSendQuery(con,'SET NAMES gbk') # 注意该行代码是告诉通过什么字符集来获取数据库字段，gbk或者utf8与你当初设置保持一致。
res=dbSendQuery(con,"select * from NapaWinery order by id")
dat=fetch(res)
dat
con
table.names
fields.names
# dbSendQuery(con,"insert into hi values('阿明',28,'男')")
# res=dbSendQuery(con,"select * from hi order by age")
# dat=fetch(res)
# dat
# dbDisconnect(con) 