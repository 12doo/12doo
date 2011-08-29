# from https://github.com/mpelos/nova_marine/blob/2dc882dac31532024d4edb196e4a632801738341/lib/paperclip_processors/watermark.rb
# Rails.root /lib/paperclip_processors/watermark.rb
module Paperclip
  class Watermark < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      super
      @watermark_path = options[:watermark_path]
      @position       = options[:position].nil? ? "SouthEast" : options[:position]
    end

    def make
      src = @file
      dst = Tempfile.new([@basename].compact.join("."))
      dst.binmode

      return super unless @watermark_path

      params = ":source #{transformation_command.join(" ")} #{@watermark_path} -gravity #{@position} -composite :dest"

      begin
        success = Paperclip.run("convert", params, :source => "#{File.expand_path(src.path)}[0]", :dest => File.expand_path(dst.path))
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the watermark for #{@basename}" if @whiny
      end

      dst
    end
  end
end