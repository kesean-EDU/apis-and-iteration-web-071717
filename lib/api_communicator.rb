require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_hash["results"].each_with_index do |char, index|
    if char["name"].downcase == character.downcase
      return character_hash["results"][index]["films"]
    end
  end
end

def parse_character_movies(films_array)
  films = films_array.collect do |api|
    binding.pry
    JSON.parse(RestClient.get(api))["title"]
  end

  films.each_with_index do |film, index|
    puts "#{index + 1} #{film}"
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  parse_character_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
