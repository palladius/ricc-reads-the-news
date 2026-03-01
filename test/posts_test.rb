require_relative 'test_helper'

class PostsTest < Minitest::Test
  def setup
    @posts_dir = File.expand_path('../_posts', __dir__)
    @post_files = Dir.glob(File.join(@posts_dir, '**/*.{md,markdown}'))
  end

  def test_every_post_has_an_image
    @post_files.each do |file|
      content = File.read(file)

      # Extract frontmatter (content between the first two '---')
      if content =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
        frontmatter_yaml = ::Regexp.last_match(1)
        begin
          frontmatter = YAML.safe_load(frontmatter_yaml, permitted_classes: [Date, Time, Numeric])
          refute_nil frontmatter, "Frontmatter should not be empty in #{file}"

          # Check for the existence of the 'image' key
          has_image = frontmatter.key?('image')
          assert has_image, "Post #{File.basename(file)} is missing the 'image' property in its frontmatter."

          # Ensure there is an actual value for it
          refute_empty frontmatter['image'].to_s.strip,
                       "Post #{File.basename(file)} has an 'image' property but it is empty."
        rescue Psych::SyntaxError => e
          flunk "Failed to parse YAML frontmatter in #{file}: #{e.message}"
        end
      else
        flunk "Could not find valid YAML frontmatter in #{file}"
      end
    end
  end
end
