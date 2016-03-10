class NoFileError < StandardError
end

class ImproperPostError < StandardError
end

class Post
  attr_reader :page, :url, :points, :id, :comments, :title

  def initialize(file, url)
    @page = open_file(file)
    @url = url
    @points = get_points 
    @id = get_id
    @title = get_title
    @comments = []
    get_comments
  end

  def open_file(file)
    raise NoFileError, "File not found!" if !File.file?(file)
    Nokogiri::HTML(File.open(file))
  end

  def get_title
    result = page.search('.title > a').map { |element| element.inner_text }[0]
    raise ImproperPostError, "No title found!" if result.nil?
  end

  def get_points
    result = page.search('.subtext > .score').map { |span| span.inner_text }[0]
    raise ImproperPostError, "No points found!" if result.nil?
  end

  def get_id
    id = page.search('.subtext > .score').map { |span| span['id'] }
    raise ImproperPostError, "No id found!" if id.nil?
    id[0].scan(/\d+/)[0].to_i
  end

  def get_comments
    page_comments = @page.search('.comment-tree .athing')
    page_comments.each do |comment|
      comments << Comment.new(comment)
    end
    comments
  end

  def add_comment(comment)
    comments << comment
  end

end

class Echo_Post 

end

# post = Post.new('post.html', 'http://post.com')
# post.get_comments.inspect
