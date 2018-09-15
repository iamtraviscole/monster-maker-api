class ApplicationController < ActionController::API
  include Knock::Authenticable

  def sort_since(collection, since)
    collection.where('created_at < ?', Time.at(since))
  end

  def sort_username(collection, username)
    collection.where(user: User.where(username: username))
  end
end
