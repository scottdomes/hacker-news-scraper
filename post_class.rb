require 'pry'

class NoFileError < StandardError
end

class ImproperPostError < StandardError
end

class Post
  attr_reader :page, :url, :points, :id, :comments, :title

  def initialize(file, url)
    @page = open_file(file)
    @url = url
    @comments = []
  end

  def open_file(file)
    raise NoFileError, "File not found!" if !File.file?(file)
    Nokogiri::HTML(File.open(file))
  end

  def add_new_comment(comment)
    comments << comment
  end

  def add_all_comments(arr)
    arr.each do |comment|
      comments << Comment.new(comment)
    end
    comments
  end

end

class RedditPost < Post

  def initialize(file, url)
    super
    @title = get_title
    get_comments
  end

  def get_title
    result = @page.search('.title > .title').map { |element| element.inner_text }[0]
    raise ImproperPostError, "No title found!" if result.nil?
    result
  end

  def get_comments
    page_comments = @page.search('.commentarea  .comment')
    add_all_comments(page_comments)
  end

  def add_all_comments(arr)
    arr.each do |comment|
      comments << RedditComment.new(comment)
    end
    comments
  end

end

class HackerNewsPost < Post

  def initialize(file, url)
    super(file, url)
    @points = get_points 
    @id = get_id
    @title = get_title
    get_comments
  end

  def get_title
    result = @page.search('.title > a').map { |element| element.inner_text }[0]
    raise ImproperPostError, "No title found!" if result.nil?
    result
  end

  def get_points
    result = @page.search('.subtext > .score').map { |span| span.inner_text }[0]
    raise ImproperPostError, "No points found!" if result.nil?
    result
  end

  def get_id
    id = page.search('.subtext > .score').map { |span| span['id'] }
    raise ImproperPostError, "No id found!" if id.nil?
    id[0].scan(/\d+/)[0].to_i
  end

  def get_comments
    page_comments = @page.search('.comment-tree .athing')
    add_all_comments(page_comments)
  end

  def add_all_comments(arr)
    arr.each do |comment|
      comments << Comment.new(comment)
    end
    comments
  end

end

class EchoJSPost < Post

  def initialize(file, url)
    super(file, url)
    @title = get_title
    get_comments
  end

  def get_title
    result = @page.search('h2 a').map { |element| element.inner_text }[0]
    raise ImproperPostError, "No title found!" if result.nil?
    result
  end

  def get_comments
    page_comments = @page.search('.comment')
    add_all_comments(page_comments)
  end

  def add_all_comments(arr)
    arr.each do |comment|
      comments << EchoJSComment.new(comment)
    end
    comments
  end

end

class ImgurPost < Post

  def initialize(file, url)
    super(file, url)
    @title = get_title
    get_comments
  end

  def get_title
    result = @page.search('.post-title').map { |element| element.inner_text }[0]
    raise ImproperPostError, "No title found!" if result.nil?
    result
  end

  def get_comments
    page_comments = @page.search('div.comment')
    # raise ImproperPostError, "No comments found!" if page_comments[0].nil?
    add_all_comments(page_comments)
  end

  def add_all_comments(arr)
    arr.each do |comment|
      comments << ImgurComment.new(comment)
    end
    comments
  end

end