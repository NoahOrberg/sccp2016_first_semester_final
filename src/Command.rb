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

