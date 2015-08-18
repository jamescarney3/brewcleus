json.partial! "api/users/user", user: @user

json.followed do
  json.array! @user.followed do |user|
    json.extract! user, :username, :state, :city
  end
end

json.followers do
  json.array! @user.followers do |user|
    json.extract! user, :username, :state, :city
  end
end
