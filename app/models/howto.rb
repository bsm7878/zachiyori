class Howto < ActiveRecord::Base
    belongs_to :menu
    
    mount_uploader :howto_img, S3uploaderUploader
    
end
