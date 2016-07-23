
class Directory
    attr_accessor :name
    def initialize(name)
        @name= name
    end
    def make
        Dir.mkdir(name,0707)
    end
end

