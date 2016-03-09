Paperclip::Attachment.default_options[:use_timestamp] = false
Paperclip::Thumbnail.default_options[:whiny] = false #Disable whiny

# Custom interpolations
module Paperclip
  module Interpolations
    def uuid(attachment, style)
      attachment.instance.uuid
    end

    def content_type_extension(attachment, style)
      if attachment.instance.class.to_s == 'Medium' && attachment.instance.kind == 'video' && style.to_s != 'original'
        return 'png'
      end

      File.extname(attachment.original_filename).gsub(/^\.+/, "")
    end
  end
end
