# Load the bundled environment
require "rubygems"
require "bundler/setup"

# Require gems specified in the Gemfile
require 'dropbox'
require 'yaml'

config = YAML.load_file('dropbox.api.yml')
token = config['token']
dbx = Dropbox::Client.new(token)

files = Dir.glob("/export/backup/mysql/*.sql")
files.each do |f|
  file = dbx.upload("/#{Time.now.strftime('%Y%m%d')}/#{f.split("/").last}", File.read(f) ) # => Dropbox::FileMetadata
end
