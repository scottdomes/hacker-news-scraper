require 'nokogiri'
require 'open-uri'
require_relative 'post_class'
require_relative 'comment'

def user_input(input)
  if is_url?(input[0])
    file = parse_file(input)
    post = Post.new(file, input)
    output = display_output(post)
    print_output(output)
  else
    "Please enter a real URL"
  end
end

def is_url?(input)
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
  "#{post.title}
  Post ID: #{post.id}. Points: #{post.points}
  Number of comments: #{post.comments.length}
  Top comment: #{post.comments[0].content}"
end

def print_output(str)
  puts str
end

user_input(ARGV)

# doc = Nokogiri::HTML(File.open('post.html'))
# puts doc.search('.subtext > span:first-child').map { |span| span.inner_text}.inspect
# puts doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }.inspect
# puts doc.search('.title > a:first-child').map { |link| link.inner_text}
# puts doc.search('.title > a:first-child').map { |link| link['href']}
# puts doc.search('.comment > font:first-child').map { |font| font.inner_text}