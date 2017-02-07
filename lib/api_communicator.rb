require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films_array = nil

  character_hash["results"].each do |person|
    person.each do |attribute, info|
      if person[attribute] == character
        films_array = person["films"]
      end
    end
  end
  return films_array
end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

def parse_character_movies(films_hash)
  # films_array = []
  counter = 1
  # Remove counter and puts statement below if you un-comment the rest of this

  films_hash.each do |url|
    movie_JSON = RestClient.get(url)
    movie_hash = JSON.parse(movie_JSON)

    puts "#{counter}. #{movie_hash["title"]}"
    counter += 1

  #  movie_hash.each do |attribute, info|
  #    if attribute == "title"
  #      films_array << info
  #    end
  #  end
  end
  # films_array.each_with_index do |title, i|
  #   puts "#{i+1}. #{title}"
  # end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
