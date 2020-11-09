require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    9.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @guess = params[:word].downcase
    @letters = params['letters'].downcase
    if included?
      if a_word?
        @result = "Greats! Your score is #{@guess.length}"
      elsif !a_word?
        @result = 'Is not a word'
      end
    else
      @result = 'Is not in the grid'
    end
  end

  def included?
    @guess.chars.all? { |letter| @guess.count(letter) <= @letters.count(letter) }
  end

  def a_word?
    url = open("https://wagon-dictionary.herokuapp.com/#{@guess}")
    file = JSON.parse(url.read)
    return file['found']
  end
end
