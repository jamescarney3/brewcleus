# STARTING INGREDIENTS #

ingredient_names = IO.read("db/ingredient_seeds.txt").split($/).select{ |el| el != "" }
ingredient_names.each{ |name| Ingredient.create(name: name) }


# EXAMPLE USERS #

User.create(
  username: "stannis",
  password: "password",
  state: "MA",
  city: "Boston",
  bio: "King Stannis of the House Baratheon, First of His Name, King of the Andals
  and the First Men, Lord of the Seven Kingdoms and Protector of the Realm. The
  night is dark and full of terrors.")

User.create(
  username: "davos",
  password: "oniononion",
  state: "ME",
  city: "Portland",
  bio: "You want me to have a god? Fine. King Stannis is my god. He raised me up
  and blessed me with his trust. He gave you a future I could never have
  imagined. You know how to read, you'll be a knight some day. You think a fire-
  god commanded all that? It was Stannis, only Stannis.")

User.create(
  username: "melisandre",
  password: "azorahai",
  state: "RI",
  city: "Providence",
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

Recipe.create(
  name: "Fratricide",
  style: "ESB",
  author_id: User.find_by_username("stannis").id,
  description: "Abv alcohol all-malt barrel becher beer bitter carbonation
  carboy cold dopplebock ester krausen malt original priming pump trappist tulip
  tun.")

Recipe.create(
  name: "One True King",
  style: "IPA",
  author_id: User.find_by_username("stannis").id,
  description: "Alcohol amber anaerobic barleywine bottle brewpub bright cask
  chocolate degrees dopplebock double draft exchanger fermentation fermenting
  final heat hefe ipa keg noble original primary pump racking secondary shelf.")

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("One True King").id,
  user_id: User.find_by_username("davos").id
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
  recipe_id: Recipe.find_by_name("Fratricide").id,
  user_id: User.find_by_username("melisandre").id
)

RecipeAdd.create(
  recipe_id: Recipe.find_by_name("One True King").id,
  user_id: User.find_by_username("davos").id
)
