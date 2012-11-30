#encoding:utf-8
require "iconv"

class Appendix::PreviewController < ApplicationController
  

  def show
  	@page = Test.find_by_title("03doc-03htm")

    @changedpath = params[:id]
    params[:id]=  params[:id].gsub("@^@", "/")

    @bookpath =  params[:id].gsub("^@^", "/")
    @tempath = params[:id]

    @bookname = params[:id].gsub("^@^", "/")[0, @tempath.index("^@^")]
    #@bookname = Iconv.conv("gbk", "utf-8", @bookname)
    #处理上一页与下一页
    pagenumber = @changedpath[-6, 6].to_i

    prevnumber = pagenumber - 1
    nextnumber = pagenumber + 1

    @prevpath = @changedpath.gsub(pagenumber.to_s, prevnumber.to_s)
    @nextpath = @changedpath.gsub(pagenumber.to_s, nextnumber.to_s)

    File.open(Rails.root.to_s + "/" +$convertDestDir + "/" + @bookpath + "." + params[:format], "r") do |file|
    buffer = file.read

    #转成mercury能够应用的img和css引用方式
    buffer = buffer.gsub("href=\"", "href=\"/books/" + @bookname + "/")
    buffer = buffer.gsub("src=\"", "src=\"/books/" + @bookname + "/")

    @page.detail = buffer
    file.close
    end

  end

  def update
    require 'FileUtils' 

    page = Test.find_by_title(params[:id])

    params[:id] = params[:id].gsub("@^@", "/")
    @bookpath =  Iconv.conv("gb2312", "utf-8", params[:id].gsub("^@^", "/"))

    
    File.open(Rails.root.to_s + "/" +$convertDestDir + "/" + @bookpath + "." + params[:format], "w") do |file|

    @changedpath = Iconv.conv("gbk", "utf-8", params[:id])
    @bookname = @bookpath[0, @changedpath.index("^@^")]

    printlog(@bookname)

    buffer = params[:content][:page_content][:value]

    #还原原来的引用css和img的模式
    buffer = buffer.gsub("href=\"/books/" + @bookname + "/", "href=\"")
    buffer = buffer.gsub("src=\"/books/" + @bookname + "/", "src=\"")

    #修改视频音频路径
    buffer = buffer.gsub("src=\"/videos", "src=\"" + @bookname + ".files")

    #修改图片路径
    buffer = buffer.gsub("src=\"/system/images", "src=\"" + @bookname + ".files")

    #通过字符串处理，移动视频文件
    videostart = buffer.index("<video")
    tempbuffer = buffer
    while videostart != nil do
        videoend = tempbuffer.index("</video")
        substr = tempbuffer[videostart, videoend - videostart]
        
        namestart = substr.index(".files") + 7
        nameend = substr.index("\">")
        videoname = substr[namestart, nameend-namestart]

        source = Rails.root.to_s + "/public/videos/" + videoname
        dest = Rails.root.to_s + "/public/books/" + @bookname + "/" + @bookname + ".files/" + videoname


        if FileTest::exist?(source)
            FileUtils.mv source, dest
        end


        tempbuffer = tempbuffer.sub("<video", "aaa")
        tempbuffer = tempbuffer.sub("</video", "aaa")
        videostart = tempbuffer.index("<video")
    end


    #通过字符串处理，移动音频文件
    audiostart = buffer.index("<audio")
    tempaudiobuffer = buffer
    while audiostart != nil do
        audioend = tempaudiobuffer.index("</audio")
        subaudiostr = tempaudiobuffer[audiostart, audioend - audiostart]
        
        audionamestart = subaudiostr.index(".files") + 7
        audionameend = subaudiostr.index("\">")
        audioname = subaudiostr[audionamestart, audionameend-audionamestart]

        audiosource = Rails.root.to_s + "/public/videos/" + audioname
        audiodest = Rails.root.to_s + "/public/books/" + @bookname + "/" + @bookname + ".files/" + audioname

        if FileTest::exist?(audiosource)
            FileUtils.mv audiosource, audiodest
        end

        tempaudiobuffer = tempaudiobuffer.sub("<audio", "aaa")
        tempaudiobuffer = tempaudiobuffer.sub("</audio", "aaa")
        audiostart = tempaudiobuffer.index("<audio")
    end

    #通过字符串处理，复制图片文件
    imagestart = buffer.index("<img")
    tempimagebuffer = buffer

    while imagestart != nil do
        
        tempimagebuffer = tempimagebuffer[imagestart, tempimagebuffer.length-imagestart]

        imageend = tempimagebuffer.index("\">")
        subimagestr = tempimagebuffer[0, imageend]
        
       

        imagenamestart = subimagestr.index(".files") + 7
        imagenameend = subimagestr.index("?")

        if imagenameend != nil
            imagename = subimagestr[imagenamestart, imagenameend-imagenamestart]
            newimagename = imagename.gsub("/", "_")

            imagesource = Rails.root.to_s + "/public/system/images/" + imagename
            imagedest = Rails.root.to_s + "/public/books/" + @bookname + "/" + @bookname + ".files/" + newimagename

            if FileTest::exist?(imagesource)
                FileUtils.cp imagesource, imagedest
            end

            buffer = buffer.gsub(imagename, newimagename)
        end
        tempimagebuffer = tempimagebuffer.sub("<img", "aaa")
        imagestart = tempimagebuffer.index("<img")
    end


    file.write(buffer)
    file.close
    end
    render text: ""
  end

end
