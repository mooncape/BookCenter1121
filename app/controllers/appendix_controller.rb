#encoding:utf-8
require "iconv"

class AppendixController < ApplicationController
	def YHTop
	end

	def YHMenu
	end

	def YHChannelApply
	end

	def YHUpload
	end

	def update
	end

	def YHPreview
		#@page = "http://localhost:3000/books/" + params[:page]

		@page = Test.find_by_title(params[:page])
	end



	def YHList
		@books = Dir.new($bookpath)
	end

	def YHConvertedList
		@books = Dir.new($convertDestDir)
	end

	def YHChapterList
		@bookname = params[:book]
		@chapters = Dir.new($convertDestDir + "/" + params[:book])
	end

	def YHListContents   
		@book = $convertDestDir + '/' + params[:bookname] + "/" + params[:chapter]
		@bookname = params[:bookname] + "@^@" + params[:chapter]
		@contents = Dir.new(@book)
	end

	def save 
       unless request.get? 
         if filename = uploadFile(params[:file]['file']) #调用application.rb里写的uploadFile对文件保存
           render :text=>'<br>' + filename
         end 
       end 
	end

	def mercurysave
       unless request.get? 
         filename = mercuryuploadFile(params[:file]['file']) #调用application.rb里写的uploadFile对文件保存
	    	respond_to do |format|
	      	format.html { redirect_to "/mercury/modals/upload"}
	      	format.json { head :no_content }
         end 
       end 
	end

	def download  
  
  		if FileTest::exist?($exepath + "a.rar")
  			File.delete($exepath + "a.rar")
  		end

		system $exepath + "WinRAR.exe a -r " + $exepath +"a.rar " + $convertDestDir + "/" + params[:book]
		send_file $exepath + "a.rar"
	end


	def delete

		File.delete($bookpath + '/' + params[:book])

    	respond_to do |format|
      	format.html { redirect_to "/appendix/YHList"}
      	format.json { head :no_content }
		end
	end

	def deletepage

		@index = params[:book].index("@^@")
		@bookname = params[:book][0..@index-1]
		@chapter = params[:book][@index+3..-1]


		File.delete(Rails.root.to_s + "/" + params[:page])

    	respond_to do |format|
      	format.html { redirect_to "/appendix/YHListContents?bookname=" + @bookname + "&chapter=" + @chapter}
      	format.json { head :no_content }
		end
	end

	def convert
		require 'FileUtils' 
		require 'digest/sha1'  

		if File.exist?($convertSrcDir)
			FileUtils.rm_r $convertSrcDir
		end


		Dir.mkdir $convertSrcDir
		FileUtils.mv $bookpath + '/' + params[:book], $convertSrcDir + '/' + params[:book] 


		#解压缩书籍文件
		system $exepath + "WinRAR.exe x \"" + ($convertSrcDir + '/' + Iconv.conv("gbk", "utf-8", params[:book])) +"\" \"" + $convertSrcDir + "\""

		#将书籍文件中的空格转换为"_"
		if params[:book].index(" ") != nil
			@bookdir = params[:book].gsub(".rar", "").gsub(" ", "_")
			printlog($convertSrcDir + "/" + params[:book].gsub(".rar", "") + "    " +$convertSrcDir + "/" + @bookdir);
			FileUtils.mv $convertSrcDir + "/" + params[:book].gsub(".rar", ""), $convertSrcDir + "/" + @bookdir
		else
			@bookdir = params[:book].gsub(".rar", "")
		end
		@destdir = (Rails.root.to_s + "/public/books/" + Digest::SHA1.hexdigest(@bookdir))

		if File.directory?@destdir
			FileUtils.mv $convertSrcDir + '/' + params[:book], $bookpath + '/' + params[:book]
			respond_to do |format|
      		format.html { redirect_to "/appendix/YHList"}
      		format.json { head :no_content }

      		FileUtils.rm_r $convertSrcDir
      		end
			return
		end



		Dir.mkdir @destdir
		system $exepath + "ProjectCom1.2.exe " + $convertSrcDir + '/' + Iconv.conv("gbk", "utf-8", @bookdir) + " " + @destdir

    	metafile = File.new(Rails.root.to_s + "/public/books/" + Iconv.conv("gbk", "utf-8", @bookdir) + ".@@@", "w+") 
    	metafile.puts("fyx")
    	metafile.close

    	respond_to do |format|
      	format.html { redirect_to "/appendix/YHList"}
      	format.json { head :no_content }

      	#FileUtils.rm_r $convertSrcDir
		end
	end

	def deletefolder

		require 'FileUtils'

		FileUtils.rm_r $convertDestDir + '/' + params[:book]
		FileUtils.rm_rf($convertDestDir + '/' + params[:bookname])

    	respond_to do |format|
      	format.html { redirect_to "/appendix/YHConvertedList"}
      	format.json { head :no_content }
		end
	end

	def deletechapter
		require 'FileUtils'

		FileUtils.rm_r $convertDestDir + '/' + params[:bookname] + "/" + params[:chapter]

		respond_to do |format|
      	format.html { redirect_to "/appendix/YHChapterList?book=" + params[:bookname]}
      	format.json { head :no_content }
      end
	end

end