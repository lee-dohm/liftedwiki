# 
# Copyright (c) 2012-2013 by Lifted Studios.  All Rights Reserved.
# 

require 'sinatra/base'

module LiftedWiki
  # Controls the wiki application by handling all routing and events.
  class WikiApp < Sinatra::Base
    # Indicates whether the given `path` has a file extension.
    # 
    # @param [String] path Path to check.
    # @return [Boolean] `true` if `path` has an extension; `false` otherwise.
    def has_extension(path)
      !File.extname(path).empty?
    end

    # Gets the pipeline object.
    # 
    # Creates a new pipeline object if one does not already exist.
    # 
    # @return [Pipeline] Pipeline object to use.
    def pipeline
      @pipeline = Pipeline.new if @pipeline.nil?
      @pipeline
    end

    # Reads in the content of the page at the given path.
    # 
    # @param [String] path Path within the wiki to the page.
    # @return [String] Contents of the page.
    def read_page(path)
      IO.read(validate_file(Dir.pwd, path + '.md'))
    end

    # Serves a wiki page.
    # 
    # @param [String] path Path of the wiki page to serve.
    # @return [String] Content of the page to serve.
    def serve_page(path)
      body = pipeline.run(read_page(path))

      erb :page, :locals => { :body => body, :path => path, :title => to_title(path) }
    end

    # Converts a path to a page title.
    # 
    # @param [String] path A file path.
    # @return [String] The filename, without extension, converted to a page title.
    def to_title(path)
      File.basename(path).gsub(/_/, ' ')
    end

    # Validates a file before returning the joined path.
    # 
    # @param [Array] args Components of the path to be joined together and validated.
    # @return [String] Validated and joined path.
    def validate_file(*args)
      filename = File.join(*args)
      raise Sinatra::NotFound unless File.exists?(filename)

      filename
    end

    # Writes the content of the page to the given path.
    # 
    # @param [String] path Path within the wiki to the page.
    def write_page(path, text)
      IO.write(File.join(Dir.pwd, path + '.md'), text)

      nil
    end

    configure :production, :development do
      enable :logging
    end

    get '/' do
      redirect to('/Home')
    end

    get '/favicon.ico' do
      raise Sinatra::NotFound
    end

    post '/edit/*' do
      path = params[:splat].first
      text = params[:text]

      write_page(path, text)

      redirect to(path)
    end

    get '/edit/*' do
      path = params[:splat].first
      text = read_page(path)

      erb :edit, :locals => { :path => path, :text => text, :title => to_title(path) }
    end

    get '*' do
      path = params[:splat].first
      pass if path =~ /^\/__sinatra__/

      serve_page(path)
    end
  end
end
