# STARTING INGREDIENTS #

ingredient_names = IO.read("db/ingredient_seeds.txt").split($/).select{ |el| el != "" }
ingredient_names.each{ |name| Ingredient.create(name: name) }

seed_styles = []
seed_recipe_names = []
File.readlines("db/style_seeds.txt").each{ |line| seed_styles << line.chomp }
File.readlines("db/recipe_name_seeds.txt").each{ |line| seed_recipe_names << line.chomp }
description_words = "Adjunct amber barleywine bottle bright bung carboy chocolate cold conditioning crystal dopplebock dunkle grainy hopping krausen malt pint priming pub reinheitsgebot saccharification tun units. Ale all-malt anaerobic barleywine berliner bitter bitterness black brewhouse bright caramel carbonation carboy cold draft grainy heat hydrometer lagering lambic lauter length microbrewery pilsner priming sour specific tun wheat wort."

# EXAMPLE USERS #

User.create(
  username: "stannis",
  password: "password",
  state: "MA",
  city: "Boston",
  avatar: URI.parse("https://pbs.twimg.com/profile_images/579269999996497920/Yf26Stvu.jpg"),
  bio: "King Stannis of the House Baratheon, First of His Name, King of the Andals
  and the First Men, Lord of the Seven Kingdoms and Protector of the Realm. The
  night is dark and full of terrors.")

User.create(
  username: "davos",
  password: "oniononion",
  state: "ME",
  city: "Portland",
  avatar: URI.parse("http://assets.viewers-guide.hbo.com/large5374fb8e3f48c.jpg"),
  bio: "You want me to have a god? Fine. King Stannis is my god. He raised me up
  and blessed me with his trust. He gave you a future I could never have
  imagined. You know how to read, you'll be a knight some day. You think a fire-
  god commanded all that? It was Stannis, only Stannis.")

User.create(
  username: "melisandre",
  password: "azorahai",
  state: "RI",
  city: "Providence",
  avatar: URI.parse("http://static.dnaindia.com/sites/default/files/2014/05/05/233675-mel-lead.jpg"),
  bio: "It is not the foes who curse you to your face that you must fear, but
  those who smile when you are looking and sharpen their knives when you turn
  your back. You would do well to keep your wolf close beside you. Ice, I see,
  and daggers in the dark. Blood frozen red and hard, and naked steel. It
  was very cold.")

User.create(
  username: "jon_snow_998",
  password: "youknownothing",
  state: "ME",
  city: "Bangor",
  avatar: URI.parse("http://hype.my/wp-content/uploads/2014/07/Jon-Snow-GoT.jpg"),
  bio: "Tell Robb that I'm going to command the Night's Watch and keep him
  safe, so he might as well take up needlework with the girls and have Mikken
  melt down his sword for horseshoes.")

# EXAMPLE USER FOLLOWS #

UserFollow.create(
  follower_id: User.find_by_username("stannis").id,
  followed_id: User.find_by_username("jon_snow_998").id
)

UserFollow.create(
  follower_id: User.find_by_username("stannis").id,
  followed_id: User.find_by_username("davos").id
)

UserFollow.create(
  follower_id: User.find_by_username("stannis").id,
  followed_id: User.find_by_username("melisandre").id
)

UserFollow.create(
  follower_id: User.find_by_username("davos").id,
  followed_id: User.find_by_username("stannis").id
)

UserFollow.create(
  follower_id: User.find_by_username("melisandre").id,
  followed_id: User.find_by_username("jon_snow_998").id
)

UserFollow.create(
  follower_id: User.find_by_username("melisandre").id,
  followed_id: User.find_by_username("stannis").id
)


# EXAMPLE RECIPES #

Recipe.create(
  name: "Take the Black IPA",
  style: "Black IPA",
  author_id: User.find_by_username("jon_snow_998").id,
  description: "Adjunct attenuation back barley bitter bittering brewpub chiller
  dry hoppy infusion keg mead microbrewery noble pitch pub sour stout terminal
  weisse. Aerobic alcohol attenuation barrel berliner bitterness bock carboy
  craft crystal dextrin dry enzymes exchanger final hopping ipa lagering tun.
  All-malt alpha anaerobic attenuation barley beer black dunkle fermentation
  filter goblet hopping hops imperial kettle lagering mash mouthfeel original
  pub racking rest secondary sparge terminal units wheat.")
Recipe.find_by_name("Take the Black IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Rahr 2-Row Malt").id,
  amount: 5,
  units: "lbs"
)
Recipe.find_by_name("Take the Black IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Crisp Maris Otter").id,
  amount: 2,
  units: "lbs"
)
Recipe.find_by_name("Take the Black IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Calypso Hop Pellets").id,
  amount: 1,
  units: "oz"
)
Recipe.find_by_name("Take the Black IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Wyeast 1272 American Ale II").id,
  amount: 11,
  units: "g"
)

Recipe.create(
  name: "Perpetual Ice",
  style: "Eisbier",
  author_id: User.find_by_username("jon_snow_998").id,
  original_grav: 1.055,
  final_grav: 1.010,
  yield: 6,
  ibus: 25,
  description: "Acid barley black bung caramel carbonation copper draft enzymes
  exchanger fermentation filter garde gravity heat hoppy hydrometer imperial ipa
  noble stout. Alcohol ale balthazar barleywine bitter bright cask chiller craft
  draft filter glass grainy hand hefe hopping hoppy hops ibu imperial pint
  racking seidel sparge specific.")
Recipe.find_by_name("Perpetual Ice").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Warminster Floor Malted Maris Otter").id,
  amount: 4,
  units: "lbs"
)
Recipe.find_by_name("Perpetual Ice").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Salzgitter German Pilsner Malt").id,
  amount: 3,
  units: "lbs"
)
Recipe.find_by_name("Perpetual Ice").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Lemondrop Hop Pellets").id,
  amount: 0.75,
  units: "oz"
)
Recipe.find_by_name("Perpetual Ice").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Wyeast 4347 Extreme Fermentation").id,
  amount: 11,
  units: "g"
)


Recipe.create(
  name: "Fratricide",
  style: "ESB",
  author_id: User.find_by_username("stannis").id,
  description: "Abv alcohol all-malt barrel becher beer bitter carbonation
  carboy cold dopplebock ester krausen malt original priming pump trappist tulip
  tun.")
Recipe.find_by_name("Fratricide").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Best Malz Munich Malt").id,
  amount: 2,
  units: "lbs"
)
Recipe.find_by_name("Fratricide").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Schill Vienna Malt").id,
  amount: 5,
  units: "lbs"
)
Recipe.find_by_name("Fratricide").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Warrior® Hop Pellets").id,
  amount: 0.5,
  units: "oz"
)
Recipe.find_by_name("Fratricide").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Equinox™ Pellet Hops").id,
  amount: 0.75,
  units: "oz"
)
Recipe.find_by_name("Fratricide").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Wyeast 1968 London ESB").id,
  amount: 8,
  units: "g"
)

Recipe.create(
  name: "One True King",
  style: "IPA",
  author_id: User.find_by_username("stannis").id,
  description: "Alcohol amber anaerobic barleywine bottle brewpub bright cask
  chocolate degrees dopplebock double draft exchanger fermentation fermenting
  final heat hefe ipa keg noble original primary pump racking secondary shelf.")
Recipe.find_by_name("One True King").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Rahr 6-Row Malt").id,
  amount: 4,
  units: "lbs"
)
Recipe.find_by_name("One True King").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Alexander's Pale Malt Syrup").id,
  amount: 4,
  units: "lbs"
)
Recipe.find_by_name("One True King").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("US Goldings Leaf Hops").id,
  amount: 1,
  units: "oz"
)
Recipe.find_by_name("One True King").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Summit™ Hop Pellets").id,
  amount: 0.5,
  units: "oz"
)
Recipe.find_by_name("One True King").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Wyeast 1335 British Ale II").id,
  amount: 10,
  units: "g"
)

Recipe.create(
  name: "Blackwater",
  style: "IPA",
  author_id: User.find_by_username("stannis").id,
  description: "All-malt anaerobic back balthazar biere bottle bottom brew cold
  conditioning double exchanger hopping imperial krug lauter mash pitch
  saccharification shelf squares top-fermenting tulip tun wort. Aau adjunct
  anaerobic barley biere bittering bitterness bock bottom brewhouse bright carboy
  dry fermenting final finishing glass infusion priming pump saccharification
  top-fermenting.")
Recipe.find_by_name("Blackwater").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Maillard Malts® Amber Malt Extract Syrup").id,
  amount: 10,
  units: "g"
)
Recipe.find_by_name("Blackwater").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Jarrylo™ Hop Pellets").id,
  amount: 0.75,
  units: "oz"
)
Recipe.find_by_name("Blackwater").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("German Magnum Hop Pellets").id,
  amount: 0.5,
  units: "oz"
)
Recipe.find_by_name("Blackwater").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Fermenter's Favorites™ Priming Sugar (Corn Sugar)").id,
  amount: 5,
  units: "oz"
)
Recipe.find_by_name("Blackwater").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Wyeast 1335 British Ale II").id,
  amount: 10,
  units: "g"
)

Recipe.create(
  name: "Smuggler's IPA",
  style: "IPA",
  author_id: User.find_by_username("davos").id,

  original_grav: 1.06,
  final_grav: 1.008,
  yield: 5.25,
  ibus: 90,

  description: "Adjunct attenuation back barley bitter bittering brewpub chiller
  dry hoppy infusion keg mead microbrewery noble pitch pub sour stout terminal
  weisse. Aerobic alcohol attenuation barrel berliner bitterness bock carboy
  craft crystal dextrin dry enzymes exchanger final hopping ipa lagering tun.")
Recipe.find_by_name("Smuggler's IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("MaltEurop American 2-Row Pale Malt").id,
  amount: 7,
  units: "lbs"
)
Recipe.find_by_name("Smuggler's IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Citra® Leaf Hops").id,
  amount: 1.5,
  units: "oz"
)
Recipe.find_by_name("Smuggler's IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Rice Syrup Solids").id,
  amount: 5,
  units: "oz"
)
Recipe.find_by_name("Smuggler's IPA").recipe_ingredients.create(
  ingredient_id: Ingredient.find_by_name("Muntons Ale Dry Yeast").id,
  amount: 10,
  units: "g"
)

# EXAMPLE RECIPE FOLLOWS #

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Blackwater").id,
  user_id: User.find_by_username("davos").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Blackwater").id,
  user_id: User.find_by_username("jon_snow_998").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Blackwater").id,
  user_id: User.find_by_username("melisandre").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Perpetual Ice").id,
  user_id: User.find_by_username("melisandre").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Perpetual Ice").id,
  user_id: User.find_by_username("stannis").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Smuggler's IPA").id,
  user_id: User.find_by_username("stannis").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Take the Black IPA").id,
  user_id: User.find_by_username("stannis").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("Fratricide").id,
  user_id: User.find_by_username("melisandre").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("One True King").id,
  user_id: User.find_by_username("davos").id
)


# EXAMPLE BATCHES #

Batch.create(
  user_id: User.find_by_username("jon_snow_998").id,
  recipe_id: Recipe.find_by_name("Take the Black IPA").id,
  brew_date: Date.parse("2015-05-01"),
  rating: 4
)








# AUTOMATIC FILLERS FOR ALL MODEL TYPES #

extra_users = 10
extra_recipes = 30


def create_filler_user
  username = Faker::Internet.user_name(nil, %w(_)) + Faker::Number.between(100, 999).to_s
  state = CS.states(:us).keys.sample.to_s
  city = CS.cities(state).sample
  bio = Faker::Lorem.paragraph(6)
  avatar = URI.parse(Faker::Avatar.image(username))
  password = Faker::Internet.password(8)
  User.create(
    username: username, state: state, city: city,
    bio: bio, avatar: avatar, password: password
  )
end

extra_users.times{ create_filler_user }



def create_filler_recipe(name, seed_styles, description_words, extra_users)
  style = seed_styles.sample
  name = Faker::Number.between(1, 10) > 4 ? "#{name} #{style}" : name
  author_id = Faker::Number.between(User.count - extra_users + 1, User.count)
  description = description_words

  recipe = Recipe.create(
    name: name, style: style, author_id: author_id, description: description
  )

  malt_ids = Ingredient.all.select do |ing|
    ing.name.downcase.include?("malt") || ing.name.downcase.include?("dme")
  end.map{|ing| ing.id }.sample(2)
  hops_ids = Ingredient.all.select do |ing|
    ing.name.downcase.include?("hops")
  end.map{|ing| ing.id }.sample(2)
  yeast_id = Ingredient.all.select do |ing|
    ing.name.downcase.include?("yeast")
  end.map{|ing| ing.id }.sample

  malt_ids.each do |id|
    recipe.recipe_ingredients.create(
      ingredient_id: id,
      units: "lbs",
      amount: Faker::Number.between(3, 5)
    )
  end

  hops_ids.each do |id|
    recipe.recipe_ingredients.create(
      ingredient_id: id,
      units: "oz",
      amount: 0.25 * Faker::Number.between(1, 8)
    )
  end

  recipe.recipe_ingredients.create(
    ingredient_id: yeast_id,
    units: "g",
    amount: Faker::Number.between(7, 11)
  )
end



seed_recipe_names.sample(extra_recipes).each do |name|
  create_filler_recipe(name, seed_styles, description_words, extra_users)
end



def create_user_follows(user)
  num = User.count / Faker::Number.between(2, 5)

  User.all.pluck(:id).select{ |id| id != user.id }.sample(num).each do |id|
    user.user_follow_followed.create(followed_id: id)
  end
end

User.last(extra_users).each{ |user| create_user_follows(user) }

def create_recipe_adds(recipe)
  num = User.count / Faker::Number.between(3, 10)

  User.all.pluck(:id).select{ |id| id != recipe.author_id }.sample(num).each do |id|
    recipe.recipe_adds.create(user_id: id)
  end
end

Recipe.all.each{ |recipe| create_recipe_adds(recipe) }
