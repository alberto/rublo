require_relative 'post_generator_test'
require_relative 'post_test'

tests = PostTest.new
tests.can_set_post_title
tests.can_set_post_body

tests = PostGeneratorTest.new
tests.generate_replaces_title_in_template
tests.generate_replaces_body_in_template
tests.generate_ignores_unknown_attributes
