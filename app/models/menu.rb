class Menu < ActiveRecord::Base
    belongs_to :mart
    has_many :ingredients
    has_many :sources
    has_many :provides
    has_many :boxes
    has_many :howtos
    has_many :readies
    
    has_many :purchases 
    has_many :users, :through => :purchases
    
    mount_uploader :menu_img1, S3uploaderUploader
    mount_uploader :menu_img2, S3uploaderUploader
    mount_uploader :menu_img3, S3uploaderUploader
    mount_uploader :menu_img4, S3uploaderUploader
    
end
