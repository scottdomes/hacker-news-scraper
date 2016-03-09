require 'rspec'
require_relative 'scraper'
require_relative 'post_class'

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

  it "should have a @comments variable set to an empty array" do
    expect(@post.comments).to eq([])
  end

end