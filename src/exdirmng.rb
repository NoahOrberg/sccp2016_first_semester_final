$:.unshift File.dirname(__FILE__)
require 'Directory.rb'
require 'DirRepository.rb'
require 'Command.rb'
require 'CommandParser.rb'
require 'json'
p=__FILE__.split("/")
json_path =p[0]+'/data.json'
json_data=open(json_path) do |io|
    JSON.load(io)
end
class Main
    def initialize(json_data, json_path )
        @json_data = json_data
        @json_path = json_path
        commandparser= CommandParser.new(ARGV)
        command= commandparser.parse
        if command.type == 'generate' then
            # 親ディレクトリの作成
            repo_dir= DirRepository.new(command.dir_name)
            repo_dir.make
            json_data.store(command.dir_name,Array.new(command.max))
            # 子ディレクトリの生成
            num= (0..command.max-1).to_a
            dir= Array.new(command.max)
            num.map{ |n|
                str= (n+1).to_s
                while true do
                    if str.length <command.format then
                        str= "0"+str
                    else break
                    end
                end
                dir[n]= Directory.new(command.dir_name + "/" + command.header + str)
                dir[n].make
                json_data[command.dir_name][n]= command.header+str
            }
        elsif command.type == 'submit' then
            if json_data.has_key? then
                puts '提出状況だよっ！'
                json_data[command.dir_name]{|n|
                    
                }
                puts 'でも、実際は提出コマンド打って提出したのかどうかわからないから、ファイルが存在しているディレクトリはすぐに提出しようね！'
                puts 'あれ、、、提出コマンド知らない...？'
                puts '隣の人にでも聞いたらどうかなっ！'
            else
                puts 'そんなフォルダ作ってないよ！'
                puts '私が作成したフォルダ以外の面倒なんて見きれないわ！'
            end
        elsif command.type == 'undefined' then
            puts 'err!'
            puts 'そんな命令知らないっ！'
            puts ' generate'
            puts ' submit'
            puts ' list'
            puts 'のうちどれか選んでね！'
        end
        # json 書き込み
        open(json_path, 'w') do |io|
            JSON.dump(json_data, io)
        end
    end
end

Main.new(json_data,json_path)

