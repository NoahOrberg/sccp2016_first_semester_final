
require './Directory.rb'
require './DirRepository.rb'
require './Command.rb'
require './CommandParser.rb'

class Main
    def initialize
        commandparser= CommandParser.new(ARGV)
        command= commandparser.parse
        if command.type == 'generate' then
            # 親ディレクトリの作成
            repo_dir= DirRepository.new(command.dir_name)
            repo_dir.make
            command.header= command.dir_name + "/" + command.header 
            # 子ディレクトリの生成
            num= (1..command.max).to_a
            num.map{ |n|
                n= n.to_s
                while true do
                    if n.length <command.format then
                        n= "0"+n
                    else break
                    end
                end
                Dir.mkdir(command.header+n, 0707)
            }
            #
        end
    end
end

Main.new
