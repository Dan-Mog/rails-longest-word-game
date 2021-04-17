require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = [*'A'..'Z']
    10.times { @letters << alphabet[rand(0..25)] }
  end

  def score
    def attempt_match?
      return params[:answer].upcase.chars.all? do |char|
      params[:letters].split(" ").count(char) >= params[:answer].upcase.count(char)
      end
    end
    def english_word?
      url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
      result = open(url).read
      return JSON.parse(result)["found"]
    end
    def score
    score = session[:score]
      if english_word? && attempt_match?
        score = params[:answer].length
      end
    end
    @attempt_match = attempt_match?
    @english_word = english_word?
    session[:score] += score
  end
end
