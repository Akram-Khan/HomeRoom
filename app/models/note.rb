class Note < Post

	validates :description, :presence => {:message => "Note can't be blank" }

end
