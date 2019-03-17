require_relative './database_connection'
require 'pg'
class Peep

  attr_reader :id, :peep, :time

  def initialize(id:, peep:, time:)
    @id = id
    @peep = peep
    @time = time
  end

  def self.all
    result = DatabaseConnection.query( "SELECT * FROM peeps" )
    result.map { |row| Peep.new(id: row['id'], peep: row['peep'], time: row['time']) }
  end

  def self.post(peep:)
    result = DatabaseConnection.query( "INSERT INTO peeps(peep, time) VALUES('#{peep}', '#{Time.now}' ) RETURNING id, peep, time;")
    Peep.new(id: result[0]['id'], peep: result[0]['peep'], time: result[0]['time'])
  end

end
