# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Test.create! title: "03doc-03htm", detail: <<-HTML
<!DOCTYPE html>
<html>
<head><meta charset="gb2312">
<title>第1章</title>
<link href="01.css" rel="stylesheet" type="text/css">
</head>
<body lang="ZH-CN">
<div class="WordSection1"><p class='head' style='margin:0 0 0 0;text-align:right;line-height:30px'>第1章  电路板设计基础</p><hr class='head' style='margin:0 0 0 0;'><p class="MsoNormal" style='text-indent:20.0pt'>禁止布线层主要用来规划电路板的电气边界，电路板上所有导电图件均不能超出该边界，否则系统在进行DRC设计校验时汇报错误。图1-9所示为一规划好的电路板的电气边界。</p><p class="MsoNormal" style='text-indent:20.0pt'>（6）【MultiLayer】（多层面）</p><p class="MsoNormal" style='text-indent:20.0pt'>多层面主要用来放置元器件的焊盘和连接不同工作层面上的导电图件的过孔等图件，如图1-10所示。</p><table class="MsoNormalTable" style='margin-left:5.4pt;border-collapse:collapse;
 border:none;
 '>
 <tr>
  <td style='width:132.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class="a3" style='margin-top:9.35pt;margin-right:0cm;margin-bottom:3.1pt;
  margin-left:0cm'><img width="167" height="101" src="01.files/image031.jpg"></p>
  </td>
  <td style='width:291.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class="a3" style='margin-top:9.35pt;margin-right:0cm;margin-bottom:3.1pt;
  margin-left:0cm'><img width="375" height="220" src="01.files/image033.jpg"></p>
  </td>
 </tr>
 <tr style='height:17.0pt;'>
  <td style='width:132.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;
  height:17.0pt;'>
  <p class="a4" style='margin-bottom:7.8pt'>图1-9&nbsp; 禁止布线层</p>
  </td>
  <td style='width:291.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;
  height:17.0pt;'>
  <p class="a4" style='margin-bottom:7.8pt'>图1-10&nbsp; 多层面</p>
  </td>
 </tr>
</table><p class="a6">&nbsp;</p><table class="MsoNormalTable" style='width:420.4pt;border-collapse:collapse;border:none;'>
 <tr style='height:2.25pt'>
  <td style='width:40.55pt;border-top:solid windowtext 1.0pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:none;
  padding:0cm 5.4pt 0cm 0cm;height:2.25pt'>
  <p class="MsoNormal" style='margin-top:3.1pt;margin-right:0cm;margin-bottom:
  3.1pt;margin-left:0cm;
  text-indent:0cm;
  '><img width="47" height="43" src="01.files/image027.jpg"></p>
  </td>
  <td style='width:379.85pt;border-top:solid windowtext 1.0pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:none;
  padding:0cm 0cm 0cm 5.4pt;height:2.25pt'>
  <p class="a7">单面板只有一个信号层，通常选用底层信号层。而多层板，除了增加内部电源层外，对于层数较多的多面板可能还有多个信号层。</p>
  </td>
 </tr>
</table><h3>1.3.2&nbsp; 认识电路板上的图件</h3><p class="MsoNormal" style='text-indent:20.0pt'>电路板上的图件包括两大类：导电图件和非导电图件。导电图件主要包括焊盘、过孔、导线、多边形填充、矩形填充等。非导电图件主要包括介质、抗蚀剂、阻焊图形、丝印文字、图形等。下面主要介绍一下导电图件。</p><p class="MsoNormal" style='text-indent:20.0pt'>图1-11所示为一电路板的PCB文件，该电路板上的导电图件主要有焊盘、过孔、导线、矩形填充等。下面分别介绍这些图件的功能。</p><p class="a3" style="margin-top:9.35pt;margin-right:0cm;margin-bottom:3.1pt;
margin-left:0cm;text-align:left;margin-left:63px;"><span style='position:
absolute;z-index:251662848;left:0px;margin-left:413px;margin-top:254px;
width:148px;height:41px'><img width="148" height="41" src="01.files/image034.png" alt="圆角矩形标注: 电路板边界"></span><span style='position:
absolute;z-index:251660800;left:0px;margin-left:426px;margin-top:185px;
width:139px;height:38px'><img width="139" height="38" src="01.files/image035.png" alt="圆角矩形标注: 导线"></span><span style='position:
absolute;z-index:251658752;left:0px;margin-left:454px;margin-top:141px;
width:107px;height:40px'><img width="107" height="40" src="01.files/image036.png" alt="圆角矩形标注: 过孔"></span><span style='position:
absolute;z-index:251657728;left:0px;margin-left:446px;margin-top:88px;
width:115px;height:68px'><img width="115" height="68" src="01.files/image037.png" alt="圆角矩形标注: 焊盘"></span><span style='position:
absolute;z-index:251655680;left:0px;margin-left:407px;margin-top:16px;
width:158px;height:87px'><img width="158" height="87" src="01.files/image038.png" alt="圆角矩形标注: 安装孔"></span><span style='position:
absolute;z-index:251663872;left:0px;margin-left:-5px;margin-top:118px;
width:104px;height:44px'><img width="104" height="44" src="01.files/image039.png" alt="圆角矩形标注: 多边形填充"></span><span style='position:
absolute;z-index:251659776;left:0px;margin-left:-5px;margin-top:20px;
width:143px;height:35px'><img width="143" height="35" src="01.files/image040.png" alt="圆角矩形标注: 矩形填充"></span><span style='position:
absolute;z-index:251656704;left:0px;margin-left:-5px;margin-top:76px;
width:132px;height:34px'><img width="132" height="34" src="01.files/image041.png" alt="圆角矩形标注: 元器件"></span><span style='position:
absolute;z-index:251661824;left:0px;margin-left:-5px;margin-top:192px;
width:111px;height:56px'><img width="111" height="56" src="01.files/image042.png" alt="圆角矩形标注: 接插件"></span><img width="414" height="251" src="01.files/image043.jpg"></p></div>
</body>
</html>
HTML