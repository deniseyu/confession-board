env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/confession_board_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!


# DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/confession_board_#{env}")
