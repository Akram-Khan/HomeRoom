class Attachment < Post
	validates :description, :presence => {:message => "Description can't be blank" }
end