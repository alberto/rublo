#!/usr/bin/env ruby

require "yaml"
require "fileutils"

require_relative "../lib/post"
require_relative "../lib/post_generator"
require_relative "../lib/post_repository"
require_relative "../lib/template_parser"

yaml = YAML.load_file("post.yaml")
template = File.read('post.rhtml')
template_parser = TemplateParser.new(template)
post = Post.new(yaml)

post_path = File.dirname(__FILE__) + "/../posts" + PostGenerator.relative_dir_path_for(post)
FileUtils.mkdir_p(post_path)
f = File.new(post_path + 'index.html',  "w+")

post_generator = PostGenerator.new(f, template_parser)
repository = PostRepository.new([post_generator])
repository.save(post)
