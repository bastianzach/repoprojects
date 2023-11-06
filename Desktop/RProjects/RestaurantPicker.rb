require 'json'
require 'net/http'
require 'uri'

# Function to get the restaurant data from rapidapi
def get_restaurant_data
  url = URI("https://restaurants-near-me-usa.p.rapidapi.com/restaurants/location/zipcode/43015/1")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Key"] = '750207631emsh8b26ad00ec3b13fp1e48d6jsn7b0475e43476'
  request["X-RapidAPI-Host"] = 'restaurants-near-me-usa.p.rapidapi.com'

  response = http.request(request)

  if response.code == '200'
    return JSON.parse(response.body)['restaurants']
  else
    puts "Failed to get restaurant data. Status code: #{response.code}"
    return []
  end
end

# Randomly select a restaurant from the API data
def random_restaurant(restaurants)
  return nil if restaurants.empty?
  random_index = rand(restaurants.length)
  restaurants[random_index]
end

# Simulate a button press
def push_button
  restaurant_data = get_restaurant_data
  if restaurant_data.nil?
    puts "No restaurant data available."
    return
  end

  restaurant = random_restaurant(restaurant_data)
  
  if restaurant
    puts "You should go to #{restaurant['restaurantName']} at #{restaurant['address']}, #{restaurant['cityName']}, #{restaurant['stateName']}!"
  else
    puts "No restaurants found."
  end
end

# Simulate a button press
push_button
