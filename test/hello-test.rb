require 'test/unit'
require_relative '../src/hello.rb'

class HelloTest < Test::Unit::TestCase
    def test_greeting 
        hello= Hello.new
        assert_equal 'Hello, world!\n', hello.greeting
    end
end

