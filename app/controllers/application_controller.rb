#encoding:utf-8
class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery

      $bookpath = "D:/books";
      $convertSrcDir = "G:/SrcDir"
      $convertDestDir = "public/books"

      $videosdir = "public/videos"

      $exepath = "G:/RelatedProjects/"

      def uploadFile(file) #处理上传后的文件保存
       if !file.original_filename.empty? 
         #生成一个随机的文件名 
         @filename=getFileName(file.original_filename) 
         #向dir目录写入文件 
         File.open($bookpath + "/#{@filename}", "wb") do |f| 
           f.write(file.read) 
           f.close
         end 
         #返回文件名称
         return @filename 
       end 
    end 

    def mercuryuploadFile(file) #处理上传后的文件保存
       if !file.original_filename.empty? 
         #生成一个随机的文件名 
         @filename=getFileName(file.original_filename) 
         #向dir目录写入文件 
         File.open(Rails.root.to_s + "/" + $videosdir + "/#{@filename}", "wb") do |f| 
           f.write(file.read)
           f.close
         end 
         #返回文件名称
         return @filename 
       end 
    end 

    def getFileName(filename) #获取文件名
       if !filename.nil? 
         return filename 
       end 
    end

    def printlog(str)
        File.open("G:/log.txt", "wb") do |f| 
           f.write(str) 
        f.close
        end
    end

end
