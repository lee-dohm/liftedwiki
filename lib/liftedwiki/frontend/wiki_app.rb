# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

require 'sinatra/base'

module LiftedWiki
  # Controls the wiki application by handling all routing and events.
  class WikiApp < Sinatra::Base
    # Initializes a new instance of the `WikiApp` class.
    def initialize
      @pipeline = Pipeline.new
    end

    # Returns the absolute path to the directory underneath which all the resources are stored.
    # 
    # @return [Pathname] Absolute path to the frontend directory.
    def resource_base
      Pathname.new(File.dirname(File.absolute_path(__FILE__)))
    end

    get ':page' do
      body = @pipeline.run(params[:page])
      erb :page, :locals => { :body => body }
    end
  end
end
