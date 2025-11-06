require 'sinatra'
require 'json'

# For Vercel deployment - reads from pre-generated JSON instead of Calibre database
# This is a simplified version that works as a static site

## Load books from JSON
def load_books
  json_file = File.join(settings.public_folder, 'books.json')
  if File.exist?(json_file)
    JSON.parse(File.read(json_file), symbolize_names: true)
  else
    []
  end
rescue => e
  puts "Error loading books: #{e.message}"
  []
end

## Homepage
get '/' do
  @books = load_books
  erb :index
end

## JSON API endpoint
get '/books.json' do
  content_type :json
  json_file = File.join(settings.public_folder, 'books.json')
  if File.exist?(json_file)
    File.read(json_file)
  else
    '[]'
  end
end

## Static file serving (CSS, fonts, etc handled by Sinatra automatically)

## Book class for ERB compatibility
class Book
  attr_reader :id, :title, :author, :description, :cover_url, :book_url,
              :cover_color, :cover_contrast, :page_count, :aspect_ratio,
              :series, :series_index
  
  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @author = data[:author]
    @description = data[:description] || ""
    @cover_url = data[:cover_url]
    @book_url = data[:book_url]
    @cover_color = data[:cover_color] || "#8B4513"
    @cover_contrast = data[:cover_contrast] || "#ffffff"
    @page_count = data[:page_count] || 300
    @aspect_ratio = data[:aspect_ratio] || 0.67
    @series = data[:series]
    @series_index = data[:series_index]
    @nonlinear_thickness = data[:nonlinear_thickness] || 30
  end
  
  def cover
    @cover_url
  end
  
  def file_path
    @book_url
  end
  
  def nonlinear_thickness
    @nonlinear_thickness
  end
  
  def author_sort
    @author
  end
  
  def self.has_pages?
    true
  end
end

# Modify load_books to return Book objects for ERB compatibility
helpers do
  def books_as_objects
    load_books.map { |data| Book.new(data) }
  end
end

# Override get '/' to use Book objects
get '/' do
  @books = books_as_objects
  erb :index
end

