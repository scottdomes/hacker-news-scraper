class Post
  attr_reader :page, :url, :points, :id, :comments, :title

  def initialize(file, url)
    @page = Nokogiri::HTML(File.open(file))
    @url = url
    @points = get_points 
    @id = get_id
    @title = get_title
    @comments = []
    get_comments
  end

  def get_title
    page.search('.title > a').map { |element| element.inner_text }[0]
  end

  def get_points
    page.search('.subtext > .score').map { |span| span.inner_text }[0]
  end

  def get_id
    id = page.search('.subtext > .score').map { |span| span['id'] }
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

# post = Post.new('post.html', 'http://post.com')
# post.get_comments.inspect
