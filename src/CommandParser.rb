class Command
    attr_accessor :type, :dir_name, :header, :format, :max
    def initialize(type, dir_name, point_h, point_f, point_m)
        @type= type
        @dir_name= dir_name 
        @header= point_h 
        @format= point_f 
        @max= point_m 
    end
end

class CommandParser 
    attr_reader :argv 
    def initialize(argv)
        @argv= argv
    end
    def parse
        # return Command
        type= argv[0]
        dir_name= argv[1]
        point_f= 1
        point_h="ex"
        point_m=13
        for i in 2..7
            if argv[i]=='-h' then
                point_h= argv[i+1]
            end
        end
        for i in 2..7
            if argv[i]=='-f' then
                point_f= argv[i+1].to_i
            end
        end
        for i in 2..7
            if argv[i]=='-m' then
                point_m= argv[i+1].to_i
            end
        end
        command= Command.new(type, dir_name, point_h, point_f, point_m)
        return command
    end
end


