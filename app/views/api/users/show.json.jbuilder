json.partial! "api/users/user", user: @user

json.followed do
  json.array! @user.followed do |user|
    json.extract! user, :username, :state, :city
  end
end

json.followers do
  json.array! @user.followers do |user|
    json.extract! user, :id, :username, :state, :city
  end
end

json.authored_recipes do
  json.array! @user.authored_recipes do |recipe|
    json.extract! recipe, :id, :name, :style
  end
end

json.added_recipes do
  json.array! @user.added_recipes do |recipe|
    json.extract! recipe, :id, :name, :style, :author_id
    json.author_username recipe.author.username
  end
end

json.batches do
  json.array! @user.batches do |batch|
    json.extract! batch, :id, :recipe_id, :brew_date, :rating
    json.recipe_name batch.recipe.name
  end
end
