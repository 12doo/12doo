class Picture < ActiveRecord::Base
  before_create :randomize_file_name
  validates_presence_of :file
  
  cattr_reader :per_page
  paginates_per 20
  
  has_attached_file :file, :styles => { :medium => "225x350>" },
                    :url  => "/uploads/pictures/#{Time.now.year}/#{Time.now.month}/#{Time.now.day}/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/pictures/#{Time.now.year}/#{Time.now.month}/#{Time.now.day}/:style/:basename.:extension"
                    
  validates_attachment_presence :file
  validates_attachment_size :file, :less_than => 1.megabytes
  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png']
  
  private  
  def randomize_file_name  
    #archives 就是你在 has_attached_file :archives 使用的名字  
    extension = File.extname(file.original_filename).downcase  
    #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
    self.file.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
    
  end
end