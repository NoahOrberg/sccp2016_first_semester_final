require 'test/unit'
require_relative '../src/CommandParser'

class CommandParserTest < Test::Unit::TestCase
    def test_CommandParserTest
        argv= ['generate', 'Prog0', '-h', 'Ex','-m', '13']
        testCommandParser= CommandParser.new(argv)
        command=testCommandParser.parse
        assert_equal 'generate', command.type
        assert_equal 'Prog0', command.dir_name
        assert_equal 'Ex', command.header
        assert_equal 1, command.format
        assert_equal 13, command.max
    end
end

