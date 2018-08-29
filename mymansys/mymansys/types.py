from django.views import View
from django.shortcuts import render,HttpResponse,redirect
import pymysql
import json
db = pymysql.connect("localhost","root","root","stu",charset='utf8',cursorclass= pymysql.cursors.DictCursor)
class types(View):
    def get(self,request):
        cursor=db.cursor()
        sql="select * from types"
        cursor.execute(sql)
        result=cursor.fetchall()
        return render(request,"types.html",{"data":result})
    def post(self,request):
        pass
class typesAdd(View):
    def get(self, request):
        return render(request, "typesAdd.html")
    def post(self, request):
        tname = request.POST.get("tname")
        tid = request.POST.get("tid")
        cursor = db.cursor()
        sql = "insert into types(tname,tid) values (%s,%s)"
        cursor.execute(sql, (tname, tid))
        db.commit()
        return redirect("/types")
class typesajax(View):
    def get(self,request):
        cursor=db.cursor()
        sql="select * from types"
        cursor.execute(sql)
        result=cursor.fetchall()
        return HttpResponse(json.dumps(result))