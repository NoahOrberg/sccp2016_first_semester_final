#!/Users/reo/.rbenv/shims/ruby
$:.unshift File.dirname(__FILE__)
require 'Directory.rb'
require 'DirRepository.rb'
require 'Command.rb'
require 'CommandParser.rb'
require 'json'
class Main
    def initialize
        pa=__FILE__.split("/")
        pa.pop
        json_path =pa.join("/")+'/data.json'
        json_data=open(json_path) do |io|
            JSON.load(io)
        end
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
            cwd= Dir.pwd
            if json_data.has_key?(command.dir_name) then
                puts '提出状況だよっ！'
                json_data[command.dir_name].map{ |n|
                    Dir.chdir(cwd)
                    Dir.chdir(command.dir_name + '/' + n)
                    if Dir.glob("*").length == 0 then 
                        j= 'x'
                    else
                        j= 'o'
                    end
                    puts "["+j+"]"+n
                }
                puts 'でも、実際は提出コマンド打って提出したのかどうかわからないから、ファイルが存在しているディレクトリはすぐに提出しようね！'
                puts 'あれ、、、提出コマンド知らない...？'
                puts '隣の人にでも聞いたらどうかなっ！'
            else
                puts 'そんなフォルダ作ってないよ！'
                puts '私が作成したフォルダ以外の面倒なんて見きれないわ！'
            end
            Dir.chdir(cwd)
        elsif command.type == 'list' then
            puts '今まで私が作成したフォルダ一覧だよ！'
            puts '言わずもがなだけど、削除する際にはdelete命令で削除してね！'
            json_data.keys.map{|n| puts n}
        elsif command.type == 'delete' then
            if json_data.has_key?(command.dir_name) then
                puts '本当に削除していいの？？？(y/n)'
                temp= STDIN.gets
                temp.chomp!
                if temp == 'y' then
                    # 削除
                    json_data[command.dir_name].map{|n| Dir.delete(command.dir_name+"/"+n)} 
                    Dir.delete(command.dir_name)
                    json_data.delete(command.dir_name)
                    puts '削除完了！'
                else 
                    puts '消しませんでしたよ！'
                end
            else
                puts 'そんなディレクトリ管理してませんっ！'
            end
        else
            puts 'err!'
            puts 'そんな命令知らないっ！'
            puts ' generate [親ディレクトリ名] -h [ヘッダ文字] -f [何桁表示か] -m [子ディレクトリの個数]'
            puts ' submit [ディレクトリ名]'
            puts ' list'
            puts ' delete [ディレクトリ名]'
            puts 'のうちどれか選んでね！'
        end
        # json 書き込み
        open(json_path, 'w') do |io|
            JSON.dump(json_data, io)
        end
    end
end

Main.new

