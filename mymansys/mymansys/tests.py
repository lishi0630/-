from django.views import View
from django.shortcuts import render,HttpResponse,redirect
from django import forms
import pymysql
import math
import xlrd
db = pymysql.connect("localhost","root","root","stu",charset='utf8',cursorclass= pymysql.cursors.DictCursor)
# 分页
def getpages(total,page,url):
    items=3
    str1='''
     <a href="%s?page=0">首页</a>
    '''%(url)

    up=page-1 if page-1>0 else 0
    str1 += '''
         <a href="%s?page=%s">上一页</a>
        '''%(url,up)
    next=page+1 if page+1<total else page

    before = page if page<math.floor(items/2) else math.floor(items/2)
    for item in range(before,0,-1):
         num=page-item
         if num==page:
             str1+='''
                  <a href="%s?page=%s" style="color:red">%s</a>
            '''%(url, num, num + 1)
         else:
            str1 += '''
              <a href="%s?page=%s">%s</a>
        ''' % (url, num, num + 1)
    after=items-before
    for item in range(after):
         num=page+item
         if (num<total):
             if num==page:
                 str1 += '''
                       <a href="%s?page=%s" style="color:red">%s</a>
                 ''' % (url, num, num + 1)
             else:
                 str1+='''
                      <a href="%s?page=%s">%s</a>
                '''%(url,num,num+1)
    str1 += '''
             <a href="%s?page=%s">下一页</a>
            '''%(url,next)
    str1 += '''
             <a href="%s?page=%s">尾页</a>
            '''%(url,total-1)
    return str1
class tests(View):
    def get(self,request):
        page = request.GET.get("page") if request.GET.get("page") else 0
        page = int(page)
        num = 3
        condition=" where 1=1"
        condition += " and tests.gid="+request.GET.get("gid") if request.GET.get("gid") else ""
        condition += " and tests.pid="+request.GET.get("pid") if request.GET.get("pid") else ""
        condition += " and tests.tid="+request.GET.get("tid") if request.GET.get("tid") else ""
        condition += " and tests.title like '%%{0}%%'".format(request.GET.get("search")) if request.GET.get("search") else ""
        cursor=db.cursor()
        sql="select tests.title,tests.id,types.tname as tnames,part.pname as pnames,grade.gname as gnames from tests LEFT JOIN types on types.tid = tests.tid LEFT JOIN part on part.pid=tests.pid LEFT JOIN grade on tests.gid=grade.gid"+condition+' limit %s,%s'
        cursor.execute(sql,(page*num,num))
        result=cursor.fetchall()
        sql5="SELECT COUNT(*) AS a FROM tests"
        cursor.execute(sql5)
        nums = cursor.fetchone()
        # print(nums)
        nums= nums["a"]
        total = math.ceil(nums / num)
        sql1="select * from grade"
        sql2="select * from part"
        sql3 = "select * from types"
        cursor.execute(sql1)
        grades=cursor.fetchall()
        cursor.execute(sql2)
        parts=cursor.fetchall()
        cursor.execute(sql3)
        types=cursor.fetchall()
        return render(request,"tests.html",{"data":result,"grades":grades,"parts":parts,"types":types,"page":getpages(total,page,"/tests/")})
class testsAdd(View):
    def get(self,request):
        return  render(request,"testsAdd.html")
    def post(self,request):
        gid=request.POST.get("gid")
        tid=request.POST.get("tid")
        pid=request.POST.get("pid")
        title=request.POST.get("title")
        opts=request.POST.get("opts")
        result=request.POST.get("result")
        # print(gid,tid,pid,title,opts,result)
        cursor=db.cursor()
        sql="insert into tests(gid,tid,pid,title,opts,result) values('%s','%s','%s','%s','%s','%s')"%(gid,tid,pid,title,opts,result)
        cursor.execute(sql)
        db.commit()
        return HttpResponse("ok")
class mycheck(forms.Form):
    gid=forms.CharField(required=True,error_messages={"required":"请选择年级"})
    pid=forms.CharField(required=True,error_messages={"required":"请选择阶段"})
    file=forms.FileField(required=True,error_messages={"required":"请选择文件"})
# 上传文件
class testsupAdd(View):
    def get(self,request):
        return render(request,"testsupAdd.html")
    def post(self,request):
        obj=mycheck(request.POST,request.FILES)
        # print(obj.is_valid())
        if obj.is_valid():
            file=request.FILES["file"]
            pid=request.POST.get("pid")
            gid=request.POST.get("gid")
            # print(file,gid,pid)
            cursor=db.cursor()
            sheet=xlrd.open_workbook(filename=None,file_contents=file.read())
            data=sheet.sheet_by_index(0)
            arrs=[]
            type="select tname,tid from types"
            cursor.execute(type)
            type = cursor.fetchall()
            typeDict={}
            for i in type:
                typeDict[i["tname"]] = i["tid"]
            # print(typeDict)
            for row in range(1,data.nrows):
                arr=data.row_values(row)
                arr[0]=typeDict[arr[0]]
                arr[2]="|".join(arr[2].split("\n"))
                arr.append(gid)
                arr.append(pid)
                arrs.append(arr)
            sql = "insert IGNORE into tests(tid,title,opts,result,gid,pid) values(%s,%s,%s,%s,%s,%s)"
            cursor.executemany(sql,arrs)
            db.commit()
            return redirect("/testsupAdd/")
        else:
            error=obj.errors
            return render(request,"testsupAdd.html",{"error":error})
class testsDel(View):
    def get(self,req):
        id=req.GET.get("id")
        cursor=db.cursor()
        sql="delete from tests where id="+id
        cursor.execute(sql)
        db.commit()
        return redirect("/tests/")
class testsEdit(View):
    def get(self,req):
        id=req.GET.get("id")
        cursor=db.cursor()
        sql="select * from tests where id='%s'"%(id)
        cursor.execute(sql)
        result=cursor.fetchone()
        sql1="select * from grade"
        sql2="select * from part"
        sql3="select * from types"
        cursor.execute(sql1)
        cursor.execute(sql2)
        cursor.execute(sql3)
        data=cursor.fetchall()
        data1=cursor.fetchall()
        data2=cursor.fetchall()
        return render(req,"testsEdit.html",{"one":result,"data":data,"data1":data1,"data2":data2})