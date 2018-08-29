from django.views import View
from django.shortcuts import render,HttpResponse,redirect
from django import forms
import pymysql
import math
import xlrd
db = pymysql.connect("localhost","root","root","stu",charset='utf8',cursorclass= pymysql.cursors.DictCursor)
class zuti(View):
    def get(self,req):
        gid=req.GET.get("gid")
        pid=req.GET.get("pid")
        tid=req.GET.get("tid")
        condition = " where 1=1"
        condition += " and tests.gid=" + gid if gid else ""
        condition += " and tests.pid=" + pid if pid else ""
        condition += " and tests.tid=" + tid if tid else ""
        condition += " and tests.title like '%%{0}%%'".format(req.GET.get("search")) if req.GET.get(
            "search") else ""
        cursor = db.cursor()
        sql = "select tests.id as id,tests.pid as pid,tests.gid as gid,result,title,opts,types.tname as tnames,part.pname as pnames,grade.gname as gnames from tests LEFT JOIN types on types.tid = tests.tid LEFT JOIN part on part.pid=tests.pid LEFT JOIN grade on tests.gid=grade.gid"+condition
        cursor.execute(sql)
        result = cursor.fetchall()
        sql1 = "select * from grade"
        sql2 = "select * from part"
        sql3 = "select * from types"
        cursor.execute(sql1)
        grades = cursor.fetchall()
        cursor.execute(sql2)
        parts = cursor.fetchall()
        cursor.execute(sql3)
        types = cursor.fetchall()
        gid = "0" if not req.GET.get("gid") else req.GET.get("gid")
        pid = "0" if not req.GET.get("pid")else req.GET.get("pid")
        tid = "0" if not req.GET.get("tid")else req.GET.get("tid")
        return render(req, "zuti.html", {"data": result, "grades": grades, "parts": parts, "types": types,"gids":int(gid),"pids":int(pid),"tids":int(tid)})
