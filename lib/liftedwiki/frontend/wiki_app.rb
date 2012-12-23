# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

require 'sinatra/base'

module LiftedWiki
  # Controls the wiki application by handling all routing and events.
  class WikiApp < Sinatra::Base
    def pipeline
      @pipeline = Pipeline.new if @pipeline.nil?
      @pipeline
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

      filename = File.join(Dir.pwd, path + '.md')
      raise Sinatra::NotFound unless File.exists?(filename)

      body = pipeline.run(File.read(filename))

      erb :page, :locals => { :body => body, :title => File.basename(path) }
    end
  end
end
