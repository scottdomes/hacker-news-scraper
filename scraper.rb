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
    Post.new(file, input)
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
    open(url[0])
  end

  def display_output(post)
    title = "#{post.title}"
    id = "Post ID: " + "#{post.id}".colorize(:blue) + ". Points: " + "#{post.points}".colorize(:green)
    num_comments = "Number of comments: " + "#{post.comments.length}".red
    top_com = "Top comment: #{post.comments[0].content}"
    print_output(title, id, num_comments, top_com)
  end

  def print_output(title, id, num_comments, top_com)
    puts title.colorize(:red)
    puts id
    puts num_comments
    puts top_com
  end

end

UserInput.new.user_input(ARGV)

# doc = Nokogiri::HTML(File.open('post.html'))
# puts doc.search('.subtext > span:first-child').map { |span| span.inner_text}.inspect
# puts doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }.inspect
# puts doc.search('.title > a:first-child').map { |link| link.inner_text}
# puts doc.search('.title > a:first-child').map { |link| link['href']}
# puts doc.search('.comment > font:first-child').map { |font| font.inner_text}