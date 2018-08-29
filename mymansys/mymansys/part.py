from django.views import View
from django.shortcuts import render,HttpResponse,redirect
import pymysql
import json
db = pymysql.connect("localhost","root","root","stu",charset='utf8',cursorclass= pymysql.cursors.DictCursor)
class part(View):
    def get(self,request):
        cursor=db.cursor()
        sql="select * from part"
        cursor.execute(sql)
        result=cursor.fetchall()
        return render(request,"part.html",{"data":result})
    def post(self,request):
        pass
class partAdd(View):
    def get(self,request):
        return render(request,"partAdd.html")
    def post(self,request):
        pname=request.POST.get("pname")
        pid=request.POST.get("pid")
        cursor=db.cursor()
        sql="insert into part(pname,pid) values (%s,%s)"
        cursor.execute(sql,(pname,pid))
        db.commit()
        return redirect("/part")
class partDel(View):
    def get(self,request):
        cursor=db.cursor()
        id=request.GET.get("id")
        sql="delete from part where id=%s"%(id)
        cursor.execute(sql)
        sql = "select teacher.tname,teacher.pid from teacher where find_in_set('%s',pid)" % (id)
        cursor.execute(sql)
        data = cursor.fetchall()
        arr = []
        for item in data:
            arr = item["pid"].split(",")
            arr.remove(id)
            arr = ",".join(arr)
            sql = "update teacher set pid=%s where tname=%s", [arr, item['tname']]
            cursor.execute(sql)
        sql = "select gid,pid from grade where find_in_set('%s',id)" % (id)
        cursor.execute(sql)
        data1 = cursor.fetchall()
        arr = []
        for item in data1:
            arr = item["staid"].split(",")
            arr.remove(id)
            arr = ",".join(arr)
            sql = "update grade set pid=%s where gid=%s"
            cursor.execute(sql, [arr, item['gid']])
        sql = "delete from tea_class where id=%s"
        # print(pid,id)
        cursor.execute(sql,(id))
        db.commit()
        return redirect("/part")
class partEdit(View):
    def get(self,request):
        id=request.GET.get("id")
        cursor=db.cursor()
        sql="select * from part where id='%s'"%(id)
        cursor.execute(sql)
        result=cursor.fetchone()
        # print(result,1111111111111)
        return render(request,"partEdit.html",{"one":result})
    def post(self,request):
        id=request.POST.get("id")
        pname=request.POST.get("pname")
        pid=request.POST.get("pid")
        cursor=db.cursor()
        sql="update part set pid=%s,pname=%s where id=%s"
        cursor.execute(sql,[pid,pname,id])
        sql="select teacher.tname,teacher.pid from teacher where find_in_set('%s',pid)" % (id)
        cursor.execute(sql)
        data=cursor.fetchall()
        arr=[]
        for item in data:
            arr = item["pid"].split(",")
            arr.remove(id)
            arr.append(pid)
            arr = ",".join(arr)
            sql="update teacher set pid=%s where tname=%s", [arr, item['tname']]
            cursor.execute(sql)
        sql="select gid,pid from grade where find_in_set('%s',pid)" % (id)
        cursor.execute(sql)
        data1=cursor.fetchall()
        arr = []
        for item in data1:
            arr = item["staid"].split(",")
            arr.remove(id)
            arr.append(pid)
            arr = ",".join(arr)
            sql="update grade set pid=%s where gid=%s"
            cursor.execute(sql,[arr, item['gid']])
        sql="update tea_class set pid=%s where id=%s"
        # print(pid,id)
        cursor.execute(sql,(pid,id))
        db.commit()
        return redirect("/part")
class partajax(View):
    def get(self,request):
        cursor=db.cursor()
        sql="select * from part"
        cursor.execute(sql)
        result=cursor.fetchall()
        return  HttpResponse(json.dumps(result))