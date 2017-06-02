# Load the bundled environment
require "rubygems"
require "bundler/setup"

# Require gems specified in the Gemfile
require 'dropbox'
require 'yaml'

config = YAML.load_file('dropbox.api.yml')
token = config['token']
dbx = Dropbox::Client.new(token)

file = dbx.upload("/#{Time.now.strftime('%Y%m%d')}/Gemfile", File.read('Gemfile') ) # => Dropbox::FileMetadata
