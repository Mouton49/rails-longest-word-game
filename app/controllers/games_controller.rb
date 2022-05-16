require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:grid].split(' ')
    @words = params[:word].split(//)

    if @words.each { |i| break unless @letters.include?(i) }
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      api_response_serialized = URI.open(url).read
      dictionary_data = JSON.parse(api_response_serialized)
      english_word = dictionary_data["found"]
      if english_word
        @result = 'Congrats'
      else @result = "You sucks in english, #{params[:word]} is not in the dictionary."
      end
    else @result = "You lose, #{params[:word]} doesn't respect the giver letters"
    end
  end
end
