"""mymansys URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from .view import *
from .grade import *
from .part import *
from .types import *
from .tests import *
from .zuti import *
from .yanzhengma import *
def mycode(req):
    obj=code()
    con=obj.output()
    obj.str=obj.str.lower()
    req.session["code"] = obj.str
    return HttpResponse(con,"image/png")
urlpatterns = [
    # path('admin/', admin.site.urls),
    path("",index),
    path("login/",login),
    # path("reg/",reg),
    path("del_cookie/",del_cookie),
    path("stu/",stu),
    path("teacher/",teacher),
    path("clas/",clas),
    # path("cla/",cla),
    #学生
    path("del/",delete),
    path("stu-add/",add),
    path("stu-edit/",edit),
    path('addCon', addCon),
    path('change', change),
    path("ajax1/",ajax1),
    #老师
    path("del1/", delete1),
    path("tea-add1/", add1),
    path("tea-edit1/", edit1),
    path('addCon1', addCon1),
    path('change1', change1),
    path("ajax/",ajax),
    #班级
    path("del2/", delete2),
    path("class-add2/", add2),
    path("class-edit2/", edit2),
    path('addCon2', addCon2),
    path('change2', change2),
    path("ajax2/",ajax2),
    path("classajax/",classajax),
    path("classajax1/",classajax1),
    # 年纪
    path("grade",grade.as_view()),
    path("gradeAdd/",gradeAdd.as_view()),
    path("gradeDel/",gradeDel.as_view()),
    path("gradeEdit/",gradeEdit.as_view()),
    path("gradeajax/",gradeajax.as_view()),
    # 阶段
    path("part",part.as_view()),
    path("partAdd/", partAdd.as_view()),
    path("partDel/", partDel.as_view()),
    path("partEdit/", partEdit.as_view()),
    path("partajax/", partajax.as_view()),
    #类型
    path("types",types.as_view()),
    path("typesAdd/", typesAdd.as_view()),
    path("typesajax/",typesajax.as_view()),
    # 试题
    path("tests/",tests.as_view()),
    path("testsAdd/",testsAdd.as_view()),
    path("testsDel/",testsDel.as_view()),
    path("testsEdit/",testsEdit.as_view()),
    # 上传文件
    path("testsupAdd/",testsupAdd.as_view()),
    # 组题
    path("zuti/",zuti.as_view()),
    # 验证码
    path("code/", mycode)


]
