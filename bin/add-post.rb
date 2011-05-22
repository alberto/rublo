#!/usr/bin/env ruby

require "yaml"
require "fileutils"

require_relative "../lib/post"
require_relative "../lib/path"
require_relative "../lib/post_generator"
require_relative "../lib/yaml_post_generator"
require_relative "../lib/post_repository"
require_relative "../lib/template_parser"
require_relative "../lib/index_generator"

yaml = YAML.load_file("post.yaml")
post = Post.new(yaml)

template = File.read('post.rhtml')
template_parser = TemplateParser.new(template)

public_path = File.dirname(__FILE__) + "/../public"
post_path = public_path + Path.path_for(post)
FileUtils.mkdir_p(post_path)
post_file = File.new(post_path + 'index.html',  "w+")

post_generator = PostGenerator.new(post_file, template_parser)
yaml_post_generator = YamlPostGenerator.new

index_path = public_path + "/index.html"
index_file = File.new(index_path, "w+")
posts_parser = TemplateParser.new(File.read("posts.rhtml"))
index_parser = TemplateParser.new(File.read("index.rhtml"))
index_generator = IndexGenerator.new(index_file, posts_parser, index_parser)
repository = PostRepository.new([post_generator, yaml_post_generator, index_generator])
repository.save(post)
