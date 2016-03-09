module Paperclip
  class VideoThumbnail < Processor

    attr_accessor :time_offset, :geometry, :whiny

    def initialize(file, options = {}, attachment = nil)
      super
      @file     = file
      @options  = options
      @instance = attachment.instance
      @whiny    = options[:whiny].nil? ? true : options[:whiny]
      @basename = File.basename(file.path, File.extname(file.path))
    end

    def make
      dst = Tempfile.new([@basename, 'png'].compact.join('.'))
      dst.binmode

      # Find the size for thumbnail
      size = @options[:geometry].split('x').first
      isSquare = @options[:geometry].include?('#')

      # Configure ffmpegthumbnailer
      cmd = "-i \"#{File.expand_path(file.path)}\" -o \"#{File.expand_path(dst.path)}\" -s #{size} "
      cmd << "-a" if isSquare

      begin
        success = Paperclip.run('ffmpegthumbnailer', cmd)
      rescue
        raise "There was an error processing the thumbnail for #{@basename}" if whiny
      end
      dst
    end
  end
end
