require 'rspec'
require_relative 'scraper'
require_relative 'post_class'
require_relative 'comment'

describe "#user_input" do

  # xit "should receive ARGV as its input" do
  # end

  # xit "should call url?" do
  #   expect(url?("sdfss")).to eq(true || false)
  # end

  xit "should create a new Post object and pass the URL- if the URL is valid" do
    expect(Post).to receive(:new).with("http://www.google.ca")
    user_input("http://www.google.ca")
  end

  it "should return an error message if the URL is not valid" do
    expect(UserInput.new.user_input("foo")).to eq("Please enter a real URL")
  end

  # it "should return the Post object if created" do
  #   expect(user_input("http://www.google.ca")).to be_kind_of(Post)
  # end

end

describe "#url?" do

  it "should return false if ARGV is not a URL" do
    expect(UserInput.new.url?("foo")).to eq(false)
  end

  it "should return true if ARGV is a URL" do
    expect(UserInput.new.url?("http://www.google.ca")).to eq(true)
  end

end

describe "parse_file" do

  xit "should return a Tempfile" do
    expect(parse_file('http://www.google.ca')).to be_kind_of(Tempfile)
  end

end

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

  it "should raise NoFileError if the file doesn't exist" do
    expect{@post.open_file('fake.html')}.to raise_error(NoFileError, "File not found!")
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

  it "should have a @title variable set to post title" do
    expect(@post.title).to eq("How We Build Code at Netflix")
  end

  it "should raise an ImproperPostError if no title found" do

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

  describe "add_comment" do

    before :each do
      @fake_comment = instance_double("Comment", :html => "post.html")
    end 

    it "should add the comment to the post's @comments array" do
      @post.add_comment(@fake_comment)
      expect(@post.comments.last).to eq(@fake_comment)
    end

    it "should increase the @comments array accordingly" do
      length = @post.comments.length
      @post.add_comment(@fake_comment)
      expect(@post.comments.length).to eq(length + 1)
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

describe "display_output" do

  before :each do
    @user = UserInput.new
    @fake_comment = instance_double("Comment", :content => "I'm a comment!")
    @fake_post = instance_double("Post", :title => "My post title", :id => 1234242, :points => 43, :comments => [@fake_comment])
  end

  xit "should send a pretty string to print_output" do
  # expect(display_output(@fake_post)).to eq("My post title
  # Post ID: 1234242. Points: 43
  # Number of comments: 1
  # Top comment: I'm a comment!")
    
    expect(@user).to receive(print_output).with("My post title", "Post ID: 1234242. Points: 43", "Number of comments: 1", "Top comment: I'm a comment!")
    @user.display_output(@fake_post)
  end

end