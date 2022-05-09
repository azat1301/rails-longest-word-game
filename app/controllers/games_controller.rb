require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word_array = params[:word].upcase.split
    @word = params[:word].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_searched = URI.open(url).read
    @result = JSON.parse(word_searched)
    @current_letters = params[:letters].split
    @ingrid = @word.chars.all? do |letter|
      @word.count(letter) <= @current_letters.count(letter)
    end

    if @ingrid && @result["found"]
      @results = "Congratulations! #{params[:word]} is a valid English word!"
    elsif @ingrid && @result["found"] == false
      @results = "Sorry but #{params[:word]} does not seem to be English word..."
    else
      @results = "Sorry but #{params[:word]} cannot be build out of #{params[:letters]}"
    end
  end
end
