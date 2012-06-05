class Attachment < Post
	validates :description, :presence => {:message => "Description can't be blank" }
  	validates :attached,  :allow_blank => false, 
                      	  :file_size => { 
                          :maximum => 1.megabytes.to_i , :message => "maximum file size is 10MB"
                      } 	
end