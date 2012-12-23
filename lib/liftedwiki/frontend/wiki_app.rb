# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

require 'sinatra/base'

module LiftedWiki
  # Controls the wiki application by handling all routing and events.
  class WikiApp < Sinatra::Base
    def new_pipeline
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
      path = path[1..-1] if path[0] == '/'
      filename = File.join(Dir.pwd, path + '.md')

      if File.exists?(filename)
        pipeline = new_pipeline
        body = pipeline.run(File.read(File.join(Dir.pwd, path + '.md')))

        erb :page, :locals => { :body => body, :title => path }
      else
        raise Sinatra::NotFound
      end
    end
  end
end
