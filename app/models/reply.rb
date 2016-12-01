class Reply < ActiveRecord::Base
    belongs_to :menu
    
    mount_uploader :reply_img, S3uploaderUploader
    
end
