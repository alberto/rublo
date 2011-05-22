require_relative '../lib/yaml_post_generator'
require 'fileutils'

module FileUtils
  def self.mkdir_p path
    @@path = path
  end

  def self.mkdir_p_args
    @@path
  end

  def self.cp_args
    [@@src, @@dest]
  end
  
  def self.cp src, dest
    @@src = src
    @@dest = dest
  end
end

class YamlPostGeneratorTest < Test
  def creates_posts_directory_if_it_doesnt_exist
    generator = YamlPostGenerator.new
    post = Post.new("title" => "title", "date" => '2011-05-22')
    generator.generate post
    expected_path = File.expand_path(File.dirname(__FILE__) + '/../posts')
    assert_equals(expected_path, File.expand_path(FileUtils.mkdir_p_args))
  end

  def copies_yaml_file_to_posts_dir
    generator = YamlPostGenerator.new
    post = Post.new("title" => "title", "date" => '2011-05-22')
    generator.generate post
    src, dest = FileUtils.cp_args
    assert_equals('post.yaml', src)
    assert_equals(File.expand_path(
        File.dirname(__FILE__) + '/../posts/2011-05-22-title.yaml'),
      File.expand_path(dest))
  end

  def gets_yaml_from_io
    YamlPostGenerator.find_all_files
  end
end
