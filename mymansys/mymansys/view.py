from django.shortcuts import render,redirect,HttpResponse
import pymysql
import hashlib
import math
import json
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
# 验证页面
def checks(callback):
    def bb(request):
        if request.session.get('login') == "yes":
            return callback(request)
        else:
            return redirect("/login/")
    return bb
def md5(str):
    md5=hashlib.md5()
    md5.update(str.encode("utf8"))
    return md5.hexdigest()
def index(request):
    if request.session.get("login")=="yes":
        cursor = db.cursor()
        sql = "select * from class"
        cursor.execute(sql)
        result = cursor.fetchall()
        return render(request, "index.html", {"data": result})
    else:
        return redirect(login)
# def cla(request):
#     cursor=db.cursor()
#     cid=request.GET.get("cid")
#     sql="select * from stu left join class on stu.cid=class.cid where class.cid="+cid
#     cursor.execute(sql)
#     result = cursor.fetchall()
#     # print(result)
#     return render(request,"class.html",{"data":result})
# 登陆页面
def login(request):
    if request.method == "GET":
        if request.session.get("login")=='yes':
            return redirect(index)
        else:
            return render(request,"login.html",{"message":""})
    elif request.method == "POST":
        name = request.POST.get("user")
        pass1 = md5(request.POST.get("pass"))
        sign=request.POST.get("sign")
        save=request.POST.get("save")
        code=request.POST.get("code")
        if code!=request.session.get("code"):
            # return render(request, "login1.html")
            return HttpResponse("ok")
        # print(code)
        # print(name, pass1, sign,save)
        if name == "" and pass1 == "":
            return render(request,"login.html",{"message:请输入用户名"})
        else:
            cursor=db.cursor()
            sql="select * from demo where user='%s'and pass='%s'and sign='%s'"%(name,pass1,sign)
            cursor.execute(sql)
            result=cursor.fetchall()
            # print(result)
            if len(result)>0:
                if save=="week":
                    obj=redirect(index)
                    request.session['login'] = "yes"
                    request.session['name']=name
                    request.session.set_expiry(60*60*24*7)
                    return obj
                else:
                    obj=redirect(index)
                    request.session['login'] = "yes"
                    request.session['name']=name
                    request.session.set_expiry(0)
                    return obj
            else:
                return render(request,"login.html",{"message":"登录失败"})
def del_cookie(request):
    request.session.clear()
    return redirect(login)
# 注册页面
def reg(request):
    if request.method=="GET":
        return render(request,"reg.html")
    elif request.method=="POST":
        name = request.POST.get("user")
        pass1 = request.POST.get("pass")
        sign = request.POST.get("sign")
        cursor = db.cursor()
        sql="insert into demo (user,pass,sign) values ('%s','%s','%s') " %(name,pass1,sign)
        cursor.execute(sql)
        db.commit()
        return redirect(login)

# 学生的增删改
@checks
def stu(request):
    page = request.GET.get("page") if request.GET.get("page") else 0
    page = int(page)
    num = 2
    cursor=db.cursor()
    sql="select * from stu left join class on stu.cid=class.cid limit %s,%s"
    cursor.execute(sql,(page*num,num))
    result = cursor.fetchall()
    # print(result)
    sql1 = "SELECT COUNT(*) AS t FROM stu LEFT JOIN class ON stu.cid=class.cid "
    cursor.execute(sql1)
    nums = cursor.fetchone()
    # print(nums)
    nums = nums["t"]

    total = math.ceil(nums / num)
    # up = page - 1 if page - 1 > 0 else 0
    # next = page + 1 if page + 1 < nums else page
    obj = render(request, "stu.html", {"data": result,"page":getpages(total,page,"/stu/")})
    return obj
def delete(request):
    cursor = db.cursor()
    id = request.GET.get("id")
    sql = "delete from stu where id="+id
    cursor.execute(sql)
    db.commit()
    return redirect(stu)
@checks
def add(request):
    cursor=db.cursor()
    sql="select * from class"
    cursor.execute(sql)
    result = cursor.fetchall()
    # print(result)
    return render(request, "stu-add.html",{"data":result})
def addCon(request):
    name=request.GET.get("name")
    sex=request.GET.get("sex")
    age=request.GET.get("age")
    class1=request.GET.get("cid")
    sid=request.GET.get("sid")
    cursor=db.cursor()
    sql="insert into stu(name,sex,age,cid,sid) VALUES ('%s','%s','%s','%s','%s')"%(name,sex,age,class1,sid)
    cursor.execute(sql)
    db.commit()
    return redirect(stu)
@checks
def edit(request):
    id = request.GET.get("id")
    cursor = db.cursor()
    sql = "select * from stu where id=" + id
    cursor.execute(sql)
    result = cursor.fetchone()
    sql="select * from class"
    cursor.execute(sql)
    res=cursor.fetchall()
    return render(request,"stu-edit.html",{"one":result,"res":res})
def change(request):
    name = request.POST.get("name")
    sex = request.POST.get("sex")
    age = request.POST.get("age")
    class1=request.POST.get("cid")
    sid=request.POST.get("sid")
    id = request.POST.get("id")
    cursor = db.cursor()
    sql = "update stu set name='%s',sex='%s',age='%s',cid='%s',sid='%s' where id='%s'" % (name, sex, age,class1,sid, id)
    cursor.execute(sql)
    db.commit()
    return redirect(stu)
#ajax验证
def ajax1(request):
    sid=request.GET.get("sid")
    cursor = db.cursor()
    sql="select * from stu where sid='%s'"%(sid)
    cursor.execute(sql)
    result=cursor.fetchone()
    if result:
        return HttpResponse("false")
    else:
        return HttpResponse("true")
#老师的增删改
@checks
def teacher(request):
    page = request.GET.get("page") if request.GET.get("page") else 0
    page = int(page)
    num = 3
    cursor=db.cursor()
    sql="select * ,GROUP_CONCAT(part.pname) as pnames from teacher left join part on find_in_set(part.pid,teacher.pid) group by teacher.tname order by teacher.tid asc limit %s,%s "
    cursor.execute(sql,(page*num,num))
    result = cursor.fetchall()
    # print(result)
    sql1 = "SELECT COUNT(*) AS t FROM teacher left join part on find_in_set(part.pid,teacher.pid) group by teacher.tname"
    cursor.execute(sql1)
    nums = cursor.fetchall()
    # nums = nums["t"]
    nums=len(nums)
    total = math.ceil(nums / num)
    # print(result)
    obj = render(request, "teacher.html", {"data": result,"page":getpages(total,page,"/teacher/")})
    return obj
def delete1(request):
    cursor = db.cursor()
    tid = request.GET.get("tid")
    sql = "delete teacher,tea_class from teacher left join tea_class on teacher.tid=tea_class.tid where teacher.tid=" + tid
    cursor.execute(sql)
    db.commit()
    return redirect(teacher)
@checks
def add1(request):
    cursor = db.cursor()
    sql="select * from part"
    cursor.execute(sql)
    result=cursor.fetchall()
    return render(request, "tea-add.html",{"data":result})
def addCon1(request):
    name=request.GET.get("tname")
    sex=request.GET.get("tsex")
    tnum=request.GET.get("tnum")
    pid=request.GET.getlist("pid")
    cursor=db.cursor()
    sql="select * from teacher where tnum='%s'"%(tnum)
    cursor.execute(sql)
    result=cursor.fetchone()
    # print(result)
    if result:
        return render(request,"tea-add.html")
    str1=""
    for item in pid:
        str1+=item+","
        pid=str1[:-1]
    sql="insert into teacher(tname,tsex,tnum,pid) VALUES (%s,%s,%s,%s)"
    cursor.execute(sql,[name,sex,tnum,pid])
    # print(name)
    db.commit()
    return redirect(teacher)
@checks
def edit1(request):
    tid = request.GET.get("tid")
    cursor = db.cursor()
    sql = "select *,GROUP_CONCAT(part.pname) as pnames from teacher LEFT JOIN part on FIND_IN_SET(part.pid,teacher.pid) where tid='%s' GROUP BY tid"%(tid)
    cursor.execute(sql)
    result= cursor.fetchone()
    print(result)
    sql="select * from part"
    cursor.execute(sql)
    res=cursor.fetchall()
    return render(request,"tea-edit.html",{"one":result,"data":res})
def change1(request):
    name = request.POST.get("tname")
    sex = request.POST.get("tsex")
    tnum=request.POST.get("tnum")
    tid = request.POST["tid"]
    pid=request.POST.getlist("pid")
    pid = ','.join(pid)
    print(type(pid))
    cursor = db.cursor()
    sql = "update teacher set tname='%s',tsex='%s',tnum='%s',pid='%s' where tid='%s'" % (name,sex,tnum,pid,tid)
    print(sql)
    cursor.execute(sql)
    db.commit()
    return redirect(teacher)
#ajax验证
def ajax(request):
    tnum=request.GET.get("tnum")
    cursor = db.cursor()
    sql="select * from teacher where tnum='%s'"%(tnum)
    cursor.execute(sql)
    result=cursor.fetchone()
    if result:
        return HttpResponse("false")
    else:
        return HttpResponse("true")
# 班级的增删改
@checks
def clas(request):
    cursor=db.cursor()
    sql="select *,class.cname,grade.gname,GROUP_CONCAT(teacher.tname) as tnames,GROUP_CONCAT(part.pname) as pnames  from class left join grade on class.gid=grade.gid left join tea_class on class.cid=tea_class.cid left join teacher on  tea_class.tid=teacher.tid left join part on tea_class.pid=part.pid group by grade.gname,class.cid"
    cursor.execute(sql)
    result = cursor.fetchall()
    # print(result)
    return render(request, "class.html", {"data": result})
def delete2(request):
    cursor = db.cursor()
    cid = request.GET.get("cid")
    sql = "delete class,tea_class from class left join tea_class on class.cid=tea_class.cid where class.cid="+cid
    cursor.execute(sql)
    db.commit()
    return redirect(clas)
@checks
def add2(request):
    cursor=db.cursor()
    sql="select * from grade"
    cursor.execute(sql)
    result = cursor.fetchall()
    # print(result)
    return render(request, "class-add.html",{"data":result})
def addCon2(request):
    cname=request.GET.get("cname")
    gid=request.GET.get("gid")
    infos = request.GET.get("infos")
    # print(tid)
    cursor=db.cursor()
    sql="insert into class(cname,gid) VALUES (%s,%s)"
    cursor.execute(sql,[cname,gid])
    infos = json.loads(infos).values()
    # print(infos)
    cid=db.insert_id()
    # print(cid)
    arr=[]
    for item in infos:
        yz=(item["tid"],cid,item["pid"])
        arr.append(yz)
    # print(arr)
    sql="insert into tea_class(tid,cid,pid) values (%s,%s,%s)"
    cursor.executemany(sql,arr)
    db.commit()
    return redirect(clas)
@checks
def edit2(request):
    cid = request.GET.get("cid")
    cursor = db.cursor()
    sql="select class.cname,class.cid,grade.gname,grade.gid as gids,GROUP_CONCAT(teacher.tname) as tnames,GROUP_CONCAT(part.pname) as pnames  from class left join grade on class.gid=grade.gid left join tea_class on class.cid=tea_class.cid left join teacher on  tea_class.tid=teacher.tid left join part on tea_class.pid=part.pid where class.cid=%s group by grade.gname,class.cid"%(cid)
    cursor.execute(sql)
    result= cursor.fetchone()
    # print(result)
    sql="select * from grade"
    cursor.execute(sql)
    res=cursor.fetchall()
    # print(res)
    return render(request,"class-edit.html",{"one":result,"data":res})
def change2(request):
    cname = request.POST.get("cname")
    gid=request.POST.get("gid")
    cid = request.GET.get("id")
    # print(cid)
    infos=request.POST.get("infos")
    cursor = db.cursor()
    sql = "update class set cname='%s',gid='%s' where  cid='%s'" % (cname,gid,cid)
    cursor.execute(sql)
    sql1 = "delete from tea_class where cid='%s'" % (cid)
    cursor.execute(sql1)
    db.commit()
    infos = json.loads(infos).values()
    # print(cid)
    arr=[]
    for item in infos:
        yz=(item["tid"],cid,item["pid"])
        arr.append(yz)
    print(arr)
    sql="insert into tea_class(tid,cid,pid) values (%s,%s,%s)"
    cursor.executemany(sql,arr)
    db.commit()
    return redirect(clas)
#ajax验证
def ajax2(request):
    cname=request.GET.get("cname")
    cursor = db.cursor()
    sql="select * from class where cname='%s'"%(cname)
    cursor.execute(sql)
    result=cursor.fetchone()
    if result:
        return HttpResponse("false")
    else:
        return HttpResponse("true")
# 班级的联动菜单
def classajax(request):
    gid=request.GET.get("gid")
    cursor=db.cursor()
    sql="select *,group_concat(part.pid)as pids,group_concat(part.pname) AS pnames from grade left join part on find_in_set(part.pid,grade.pid) where gid=" + gid
    cursor.execute(sql)
    result=cursor.fetchone()
    return HttpResponse(json.dumps(result))
def classajax1(request):
    pid=request.GET.get("pid")
    cursor=db.cursor()
    sql="select * from teacher where find_in_set('%s',pid)"%(pid)
    cursor.execute(sql)
    result=cursor.fetchall()
    return HttpResponse(json.dumps(result))