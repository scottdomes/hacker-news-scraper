require 'nokogiri'
require 'open-uri'
require 'colorize'
require_relative 'post_class'
require_relative 'comment'

class UserInput 

  def user_input(input)
    if url?(input[0])
      post = create_post(input)
      display_output(post)
    else
      "Please enter a real URL"
    end
  end

  def create_post(input)
    file = parse_file(input)
    post_type = check_post_type(input)
    case post_type
    when "reddit"
      RedditPost.new(file, input)
    when "hackernews"
      HackerNewsPost.new(file, input)
    when "echojs"
      EchoJSPost.new(file, input)
    when "imgur"
      ImgurPost.new(file, input)
    else
      puts "Post type not found!"
    end
  end

  def check_post_type(url)
    if url[0].include?("reddit")
      "reddit"
    elsif url[0].include?("ycombinator")
      "hackernews"
    elsif url[0].include?("echojs")
      "echojs"
    elsif url[0].include?("imgur")
      "imgur"
    end
  end

  def url?(input)
    result = input =~ /https?:\/\/.*\..+/
    if result == 0
      true
    else
      false
    end
  end

  def parse_file(url)
    file = open(url[0])
    if file.class == StringIO
      tempfile = File.new('temp', 'w')
      tempfile.binmode
      File.open(tempfile, 'w') { |temp| temp.write(file.read) }
      tempfile
    else
      file
    end

  end

  def display_output(post)
    title = "#{post.title}"
    if post.class == HackerNewsPost
      id = "Post ID: " + "#{post.id}".colorize(:blue) + ". Points: " + "#{post.points}".colorize(:green)
    end
    if post.class != ImgurPost
      num_comments = "Number of comments: " + "#{post.comments.length}".red
      top_com = "Top comment: #{post.comments[0].content}"
    else
      #print ascii picture
      img = post.image
    end
    print_output(title, id, num_comments, top_com, img)
  end

  def print_output(title, id, num_comments, top_com, img)
    puts title.colorize(:red)
    puts id unless id.nil?
    puts num_comments unless num_comments.nil?
    puts top_com unless top_com.nil?
    puts img unless img.nil?
  end

end

UserInput.new.user_input(ARGV)

# doc = Nokogiri::HTML(File.open('post.html'))
# puts doc.search('.subtext > span:first-child').map { |span| span.inner_text}.inspect
# puts doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }.inspect
# puts doc.search('.title > a:first-child').map { |link| link.inner_text}
# puts doc.search('.title > a:first-child').map { |link| link['href']}
# puts doc.search('.comment > font:first-child').map { |font| font.inner_text}