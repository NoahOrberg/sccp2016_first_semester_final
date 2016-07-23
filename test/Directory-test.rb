require 'test/unit'
require_relative '../src/Directory'

class DirectoryTest < Test::Unit::TestCase
    def test_directory
        dir= Directory.new("Ex")
        assert_equal 'Ex', dir.name
    end
end

