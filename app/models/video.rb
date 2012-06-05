class Video < Post
	url_regex = /https?:\/\/[\S]+/

	validates :url, :presence => {:message => "URL can't be blank" },
					:format => {:with => url_regex, :message => "Please enter a valid URL (http://..)"}

	validates :description, :presence => {:message => "Description can't be blank" }
end
