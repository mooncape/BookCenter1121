class Mercury::Image < ActiveRecord::Base

  self.table_name = :mercury_images

  has_attached_file :image, :styles => { :xlarge => "640x640>", :large => "400x400>", :medium => "320x320>", :small => "200x200", :thumb => "100x100>" },
        :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
        :url => "/system/:attachment/:id/:style/:filename"

  delegate :url, :to => :image

  def serializable_hash(options = nil)
    options ||= {}
    options[:methods] ||= []
    options[:methods] << :url
    super(options)
  end

end
