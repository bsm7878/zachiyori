class Mart < ActiveRecord::Base
    has_many :menus
    has_many :addresses
    mount_uploader :mart_img, S3uploaderUploader
    
     
    
    
    
end
