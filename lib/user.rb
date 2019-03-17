require 'pg'
require_relative './database_connection'

class User
  attr_reader :id, :username, :password

  def initialize(id:, username:, password:)
    @id = id
    @username = username
    @password = password
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM users;")
    result.map { |row| User.new(id: row['id'], username: row['username'], password: row['password']) }
  end

  def self.add(username:, password:)
    result = DatabaseConnection.query("INSERT INTO users(username, password) VALUES('#{username}', '#{password}' ) RETURNING id, username, password;")
    User.new(id: result[0]['id'], username: result[0]['username'], password: result[0]['password'])
  end
end
