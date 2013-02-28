# 
# Copyright (c) 2012-2013 by Lifted Studios.  All Rights Reserved.
# 

require 'date'
require File.expand_path('../lib/liftedwiki/version', __FILE__)

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'
  s.required_ruby_version = ">= 1.9.3"

  s.name    = 'liftedwiki'
  s.version = LiftedWiki::VERSION
  s.date    = Date.today.to_s

  s.summary     = "A personal wiki solution"
  s.description = "A personal wiki solution inspired by Gollum"

  s.authors  = ["Lee Dohm"]
  s.email    = 'lee@liftedstudios.com'
  s.homepage = 'https://github.com/lee-dohm/liftedwiki'

  s.require_paths = ['lib']

  s.executables = ['liftedwiki']

  s.add_dependency('github-linguist')
  s.add_dependency('html-pipeline', '>= 0.0.8')
  s.add_dependency('sinatra', '~> 1.3')

  s.add_development_dependency('minitest', '~> 3.0')
  s.add_development_dependency('rake', '~> 10.0')
  s.add_development_dependency('redcarpet')
  s.add_development_dependency('yard')

  s.files = `git ls-files`.
    split("\n").
    sort.
    reject { |file| file =~ /^\./ }.
    reject { |file| file =~ /^(rdoc|pkg)/ }

  s.test_files = s.files.select { |path| path =~ /^spec\/.*_spec\.rb/ }
end
