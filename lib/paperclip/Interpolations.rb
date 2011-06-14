# 为Paperclip添加方法，支持图片上传按时间格式划分
# 读取图片的路径也按时间方式读取
module Paperclip
  module Interpolations
    def timestamp_partition attachment, style_name
      date = attachment.instance_read(:updated_at)
      return "" unless date
      "#{date.year}/#{date.month}/#{date.day}"
    end
  end
end