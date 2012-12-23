# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
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

    # Serves a file.
    # 
    # @param [String] path Path to the file to serve.
    # @return Contents of the file.
    def serve_file(path)
      logger.info "Entered serve_file with parameters: #{path}"
      File.read(File.join(File.dirname(__FILE__), 'css', path))
    end

    # Serves a wiki page.
    # 
    # @param [String] path Path of the wiki page to serve.
    # @return [String] Content of the page to serve.
    def serve_page(path)
      logger.info "Entered serve_page with parameters: #{path}"

      filename = File.join(Dir.pwd, path + '.md')
      raise Sinatra::NotFound unless File.exists?(filename)

      body = pipeline.run(File.read(filename))

      erb :page, :locals => { :body => body, :title => File.basename(path) }
    end

    configure :production, :development do
      enable :logging
    end

    get '/' do
      redirect '/Home'
    end

    get '/favicon.ico' do
      raise Sinatra::NotFound
    end

    get '*' do
      path = params[:splat].first
      pass if path =~ /^\/__sinatra__/

      if has_extension(path)
        serve_file(path)
      else
        serve_page(path)
      end
    end
  end
end
