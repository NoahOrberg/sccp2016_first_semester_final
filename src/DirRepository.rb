class DirRepository
    attr_reader :name
    def initialize(name)
        @name= name
    end
    def make
        Dir.mkdir(name,0707)
    end
end

