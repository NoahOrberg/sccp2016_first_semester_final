require 'test/unit'
require_relative '../src/dir-repository'

class DirRepositoryTest < Test::Unit::TestCase
    def test_construcor
        dir= DirRepository.new("Prog0", "Ex")
        assert_equal 'Prog0', dir.name
        assert_equal 'Ex', dir.header
    end
end

