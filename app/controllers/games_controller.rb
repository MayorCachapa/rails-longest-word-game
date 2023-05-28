require 'open-uri'

class GamesController < ApplicationController
    def new
        @letters = Array.new(5) { %w(A E I O U).sample }
        @letters += Array.new(5) { ('A'..'Z').to_a.sample }
        @letters.shuffle! 
    end

    def score
        @answer = params[:answer].upcase
        @letters = params[:letters].split
        @included = include?(@answer, @letters)
        @valid = valid_word?(@answer)
    end

    private
    
    def include?(word, letters)
        word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    end

    def valid_word?(word)
        response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(response.read)
        json['found']
    end
end
