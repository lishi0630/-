from django.views import View
from django.shortcuts import render,HttpResponse,redirect
import pymysql
import json
db = pymysql.connect("localhost","root","root","stu",charset='utf8',cursorclass= pymysql.cursors.DictCursor)
class grade(View):
    def get(self,request):
        cursor=db.cursor()
        sql="select *,group_concat(part.pname) as pnames from grade left join part on find_in_set(part.pid,grade.pid) group by grade.gname order by grade.id asc"
        cursor.execute(sql)
        result=cursor.fetchall()
        return render(request,"grade.html",{"data":result})
class gradeAdd(View):
    def get(self,request):
        cursor=db.cursor()
        sql="select * from part"
        cursor.execute(sql)
        res=cursor.fetchall()
        return render(request,"gradeAdd.html",{"data":res})
    def post(self,request):
        gname=request.POST.get("gname")
        gid=request.POST.get("gid")
        pid=request.POST.getlist("pid")
        print(pid)
        con=""
        for item in pid:
            con+=item+","
        pid=con[:-1]
        print(pid)
        cursor=db.cursor()
        sql="insert into grade (gname,gid,pid) values (%s,%s,%s)"
        cursor.execute(sql,[gname,gid,pid])
        db.commit()
        return redirect("/grade")
class gradeDel(View):
    def get(self,request):
        id=request.GET.get("id")
        gid=request.GET.get("gid")
        cursor=db.cursor()
        sql="delete from grade where id="+id
        cursor.execute(sql)
        sql="select * from class where find_in_set('%s',gid)" % (gid)
        cursor.execute(sql)
        cursor.fetchone()
        sql="update class set gid='' where gid=%s"
        cursor.execute(sql,[gid])
        db.commit()
        return redirect("/grade")
class gradeEdit(View):
    def get(self,request):
        id=request.GET.get("id")
        cursor=db.cursor()
        sql="select *,group_concat(part.pname) as pnames from grade left join part on find_in_set(part.pid,grade.pid) where grade.id='%s' group by grade.gname"%(id)
        cursor.execute(sql)
        result=cursor.fetchone()
        # print(result)
        sql="select * from part"
        cursor.execute(sql)
        data=cursor.fetchall()
        return render(request,"gradeEdit.html", {"one":result,"data":data})
    def post(self,req):
        id=req.GET.get("id")
        gname=req.POST.get("gname")
        gid=req.POST.get("gid")
        pid=req.POST.getlist("pid")
        print(pid,id)
        str=""
        for item in pid:
            str+=item+","
            print(str)
            pid=str[:-1]
        cursor=db.cursor()
        sql="update grade set gname=%s,gid=%s,pid=%s where id=%s"
        cursor.execute(sql,[gname,gid,pid,id])
        print(gname,gid,pid,id)
        db.commit()
        return  redirect("/grade")
class gradeajax(View):
    def get(self,request):
        cursor=db.cursor()
        sql="select *,group_concat(part.pname) as pnames from grade left join part on find_in_set(part.pid,grade.pid) group by grade.gname order by grade.id asc"
        cursor.execute(sql)
        result=cursor.fetchall()
        return HttpResponse(json.dumps(result))