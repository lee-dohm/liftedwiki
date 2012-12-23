# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

require 'sinatra/base'

module LiftedWiki
  # Controls the wiki application by handling all routing and events.
  class WikiApp < Sinatra::Base
    get '/' do
      redirect '/Home'
    end

    get '*' do
      path = params[:splat].first
      erb :page, :locals => { :body => "<p>It works!</p>", :title => "#{path}: It Works!" }
    end
  end
end
