class Question < Post
	validates :description, :presence => {:message => "Question can't be blank" }
end
