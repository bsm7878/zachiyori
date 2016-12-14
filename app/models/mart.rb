class Mart < ActiveRecord::Base
    has_many :menus
    has_many :addresses
    has_many :relaxes
    has_many :makers
    
    mount_uploader :mart_img, S3uploaderUploader
    
     
    
    
    
end
