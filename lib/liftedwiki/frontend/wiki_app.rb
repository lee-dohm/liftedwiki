# 
# Copyright (c) 2012 by Lifted Studios.  All Rights Reserved.
# 

require 'sinatra/base'

module LiftedWiki
  class WikiApp < Sinatra::Base
    def initialize
      @pipeline = Pipeline.new
    end

    get ':page' do
      body = @pipeline.run(params[:page])
      erb :page, :locals => { :body => body }
    end
  end
end
