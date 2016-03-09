require 'rspec'
require_relative 'scraper'
require_relative 'post_class'
require_relative 'comment'

# describe "#user_input" do

#   # xit "should receive ARGV as its input" do
#   # end

#   # xit "should call is_url?" do
#   #   expect(is_url?("sdfss")).to eq(true || false)
#   # end

#   xit "should create a new Post object and pass the URL- if the URL is valid" do
#     expect(Post).to receive(:new).with("http://www.google.ca")
#     user_input("http://www.google.ca")
#   end

#   it "should return an error message if the URL is not valid" do
#     expect(user_input("foo")).to eq("Please enter a real URL")
#   end

#   it "should return the Post object if created" do
#     expect(user_input("http://www.google.ca")).to be_kind_of(Post)
#   end

# end

# describe "#is_url?" do

#   it "should return false if ARGV is not a URL" do
#     expect(is_url?("foo")).to eq(false)
#   end

#   it "should return true if ARGV is a URL" do
#     expect(is_url?("http://www.google.ca")).to eq(true)
#   end

# end

# describe "parse_file" do

#   xit "should return a Tempfile" do
#     expect(parse_file('http://www.google.ca')).to be_kind_of(Tempfile)
#   end

# end

describe "Post" do

  before :each do
    @post = Post.new("post.html", "http://post.com")
  end

  it "should have a @page variable" do
    expect(@post).to respond_to(:page)
  end

  it "should set the @page variable equal to the parsed HTML page" do
    expect(@post.page).to be_kind_of(Nokogiri::HTML::Document)
  end

  it "should have a @url variable equal to the passed URL" do
    expect(@post.url).to eq("http://post.com")
  end

  it "should have a @points variable equal to the number of points on the post" do
    expect(@post.points).to eq("253 points")
  end

  it "should have a @id variable equal to the post ID" do
    expect(@post.id).to eq(11253321)
  end

  it "should have a @comments variable which is an array" do
    expect(@post.comments).to be_kind_of(Array)
  end

  it "should have actual Comments in the @comments array" do
    expect(@post.comments.first).to be_kind_of(Comment)
  end

  describe "get_comments" do

    xit "should search @page for the comments" do
      expect(@post.page).to receive(:search).with (".athing")
      @post.get_comments
    end

    it "should create new comments" do
      expect(Comment).to receive(:new).at_least(:once)
      @post.get_comments
    end

  end

end

describe "Comment" do 

  before :each do
    @post = Post.new('post.html', 'http://post.com')
    @comments = @post.comments
    @first_comment = @post.comments[0]
  end

  # xit "should have a @html variable set to the parameter" do
  #   expect(Comment.new("Hi!").html).to eq("Hi!")
  # end

  it "should have an @html variable that is a Nokogiri XML Element" do
    expect(@first_comment.html).to be_kind_of(Nokogiri::XML::Element)
  end

  it "should have a @username variable set to the correct username" do
    expect(@first_comment.username).to eq('neduma')
  end

  it "should have a @content variable set to the actual comment text" do
    expect(@first_comment.content). to eq("How do they 'externalize config' with respect to http://12factor.net/config?")
  end

end