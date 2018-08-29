import pymysql
class mysql():
    def __init__(self):
        self.db=pymysql.connect("localhost","root","root","stu",charset="utf8", cursorclass=pymysql.cursors.DictCursor)
        self.cursor = self.db.cursor()
    def sel_one(self, sql, *args):
        self.cursor.execute(sql,*args)
        return self.cursor.fetchone()

    def sel_many(self,sql,*args):
        self.cursor.execute(sql,*args)
        return self.cursor.fetchall()

    def exe_one(self, sql, args):
        self.cursor.execute(sql, args)
        self.db.commit()

    def exe_many(self, sql, args):
        self.cursor.executemany(sql, args)
        self.db.commit()
    def close(self):
        self.cursor.close()
        self.db.close()


