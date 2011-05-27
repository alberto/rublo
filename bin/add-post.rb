#!/usr/bin/env ruby
require "fileutils"
require_relative "../lib/post"
require_relative "factory"

post = Factory.create_post
FileUtils.mkdir_p(Paths.post_dirpath post)

repository = Factory.create_post_repository
repository.save(post)
