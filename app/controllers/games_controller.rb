require 'open-uri'
require 'json'

class GamesController < ApplicationController
  # attr_accessor :letters

  # def init
  #   @letters = []
  # end

  def new
    @letters = []
    10.times do
      @letters << ("a".."z").to_a.sample
    end
    @letters
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    grid = @word.chars.all? { |char| @letters.count(char) >= @word.chars.count(char) }
    api = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    if grid && api["found"]
      @answer = "well done word is found"
    elsif api["found"]
      @answer = "word not in grid"
    else
      @answer = "not an english word"
    end
  end
end
