$:.unshift File.dirname(__FILE__)
require 'Directory.rb'
require 'DirRepository.rb'
require 'Command.rb'
require 'CommandParser.rb'

class Main
    def initialize
        commandparser= CommandParser.new(ARGV)
        command= commandparser.parse
        if command.type == 'generate' then
            # 親ディレクトリの作成
            repo_dir= DirRepository.new(command.dir_name)
            repo_dir.make
            # 子ディレクトリの生成
            num= (1..command.max).to_a
            dir= Array.new(command.max)
            num.map{ |n|
                str= n.to_s
                while true do
                    if str.length <command.format then
                        str= "0"+str
                    else break
                    end
                end
                dir[n]= Directory.new(command.dir_name + "/" + command.header + str)
                dir[n].make
            }
        end
    end
end

Main.new
