#!/usr/bin/env ruby

require "yaml"
require "fileutils"

require_relative "../lib/post"
require_relative "../lib/path"
require_relative "../lib/post_generator"
require_relative "../lib/yaml_post_generator"
require_relative "../lib/post_repository"
require_relative "../lib/template_parser"

yaml = YAML.load_file("post.yaml")
template = File.read('post.rhtml')
template_parser = TemplateParser.new(template)
post = Post.new(yaml)

post_path = File.dirname(__FILE__) + "/../public" + Path.path_for(post)
FileUtils.mkdir_p(post_path)
f = File.new(post_path + 'index.html',  "w+")

post_generator = PostGenerator.new(f, template_parser)
yaml_post_generator = YamlPostGenerator.new
repository = PostRepository.new([post_generator, yaml_post_generator])
repository.save(post)
