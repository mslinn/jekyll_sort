# frozen_string_literal: true

require_relative "lib/jekyll_sort/version"

module GemSpecHelper
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  def self.spec_files
    Dir.chdir(File.expand_path(__dir__)) do
      `git ls-files -z`.split("\x0").reject do |f|
        (f == __FILE__) || f.match(%r!\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)!)
      end
    end
  end

  def self.spec_executables(files)
    files.grep(%r!\Aexe/!) { |f| File.basename(f) }
  end
end

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.bindir = "exe"
  spec.authors = ["Mike Slinn"]
  spec.email = ["mslinn@mslinn.com"]
  spec.executables = GemSpecHelper.spec_executables(files)
  spec.files = GemSpecHelper.spec_files
  spec.homepage = "https://github.com/mslinn/jekyll_sort"
  spec.license = "MIT"
  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri"   => "#{github}/issues",
    "changelog_uri"     => "#{github}/CHANGELOG.md",
    "homepage_uri"      => spec.homepage,
    "source_code_uri"   => spec.homepage,
  }
  spec.name = "jekyll_sort"
  spec.post_install_message = <<~END_MESSAGE

    Thanks for installing #{spec.name}!

  END_MESSAGE
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.6.0"
  spec.summary = "Provides a Jekyll filter that provides case-insensitive hash key sorting."
  spec.version = JekyllSort::VERSION

  spec.add_dependency "jekyll", ">= 3.5.0"
  spec.add_dependency "jekyll_plugin_logger"

  spec.add_development_dependency "debase"
  spec.add_development_dependency "rubocop-jekyll"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "ruby-debug-ide"
end
# rubocop:enable Metrics/BlockLength
