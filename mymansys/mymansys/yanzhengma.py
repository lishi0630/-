from PIL import Image,ImageDraw,ImageFont
import random
import math
import io
class code:
    def __init__(self):
        # 画布大小
        # 字体大小
        # 颜色
        #字体颜色
        self.font="arial.ttf"
        self.pointNum=random.randint(100,200)
        self.lineNum = random.randint(10, 20)
        self.obj=""
        self.im=None
        self.bgcolor=""
        self.w=150
        self.h=60
        self.lineSize=random.randint(1,3)
        self.fontSizemin=20
        self.fontSizemax=40
        self.con="abcdefjhkABCDEFKH1234578"
        self.len=4
        self.str=""
    def fontColor(self):
        return (random.randint(0,125),random.randint(0,125),random.randint(0,125))
    def imgColor(self):
        return (random.randint(126,255),random.randint(126,255),random.randint(126,255))
    def creat(self):
        self.bgcolor=self.imgColor()
        self.im=Image.new("RGBA",(self.w,self.h),self.bgcolor)
    def drawPoint(self):
        draw=ImageDraw.Draw(self.im)
        for index in range(self.pointNum):
            x=random.randint(0,self.w)
            y=random.randint(0,self.h)
            draw.point([x,y],fill=self.imgColor())
    def drawLine(self):
        draw=ImageDraw.Draw(self.im)
        for index in range(self.lineNum):
            x=random.randint(0,self.w)
            y=random.randint(0,self.h)
            x1=random.randint(0,self.w)
            y1=random.randint(0,self.h)
            draw.line([x,y,x1,y1],fill=self.imgColor(),width=self.lineSize)
    def drawText(self):
        draw=ImageDraw.Draw(self.im)
        for index in range(self.len):
            con=self.con[random.randint(0,len(self.con)-1)]
            self.str+=con
            fontsize=random.randint(self.fontSizemin, self.fontSizemax)
            x=index*fontsize
            y=random.randint(0,self.h-fontsize)
            font = ImageFont.truetype(self.font,fontsize)
            draw.text((x,y),con,fill=self.fontColor(),font=font)
        self.rotate()
    def rotate(self):
        angle=random.randint(10,20)
        self.im=self.im.rotate(angle)
        im1=Image.new("RGBA",(self.w,self.h),self.bgcolor)
        self.im=Image.composite(self.im,im1,self.im)
    def output(self):
        self.creat()
        self.drawLine()
        self.drawPoint()
        self.drawText()
        # self.im.show()
        imgs=io.BytesIO()
        self.im.save(imgs,"png")
        return imgs.getvalue()
# obj=code()
# obj.output()