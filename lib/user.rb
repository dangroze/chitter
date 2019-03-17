require 'pg'
require_relative './database_connection'

class User
  attr_reader :id, :email, :username, :password

  def initialize(id:, email:, username:, password:)
    @id = id
    @email = email
    @username = username
    @password = password
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM users;")
    result.map { |user| User.new(id: user['id'], email: user['email'], username: user['username'], password: user['password']) }
  end

  def self.add(email:, username:, password:)
    result = DatabaseConnection.query("INSERT INTO users(email, username, password) VALUES('#{email}', '#{username}', '#{password}' ) RETURNING id, email, username, password;")
    User.new(id: result[0]['id'], email: result[0]['email'], username: result[0]['username'], password: result[0]['password'])
  end
end
