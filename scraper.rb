require 'nokogiri'
require 'open-uri'
require_relative 'post_class'

def user_input(input)
  if is_url?(input)
    file = parse_file(input)
    Post.new(file, input)
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
  open(url)
end

user_input(ARGV)

# doc = Nokogiri::HTML(File.open('post.html'))
# puts doc.search('.subtext > span:first-child').map { |span| span.inner_text}.inspect
# puts doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }.inspect
# puts doc.search('.title > a:first-child').map { |link| link.inner_text}
# puts doc.search('.title > a:first-child').map { |link| link['href']}
# puts doc.search('.comment > font:first-child').map { |font| font.inner_text}