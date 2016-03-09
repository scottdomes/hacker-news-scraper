class Post
  attr_reader :page, :url, :points, :id, :comments

  def initialize(file, url)
    @page = Nokogiri::HTML(File.open(file))
    @url = url
    @points = get_points 
    @id = get_id
    @comments = []
  end

  def get_points
    page.search('.subtext > .score').map { |span| span.inner_text}[0]
  end

  def get_id
    id = page.search('.subtext > .score').map { |span| span['id']}
    id[0].scan(/\d+/)[0].to_i
  end

end