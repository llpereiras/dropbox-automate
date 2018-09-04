# Load the bundled environment
require "rubygems"
require "bundler/setup"

# Require gems specified in the Gemfile
require 'dropbox'
require 'yaml'

config = YAML.load_file('dropbox.api.yml')
token = config['token']
dbx = Dropbox::Client.new(token)

FOLDER_BACKUPS = nil

abort ("FOLDER_BACKUPS not set") unless FOLDER_BACKUPS

dbs = ['blog',
       'busbudget',
       'eventos_rails',
       'eventos',
       'jobs_dev',
       'mystore',
       'railsvacinas',
       'ricardo_gama',
       'social_tracker_dev',
       'temperatura',
       'twitter_manager',
       'twitter_search_dev']

dbs.each do |current_file|
  file, body = dbx.download("/#{FOLDER_BACKUPS}/#{current_file}.sql") # => Dropbox::FileMetadata, HTTP::Response::Body
  file_new = File.open("/export/backup/mysql/#{current_file}.sql", "w")
  file_new.write(body)
end
