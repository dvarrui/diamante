namespace :devel do

  desc "Create /usr/local/bin/diamante"
  task :launcher do
    launcherpath = "/usr/local/bin/diamante"
    if File.exist?(launcherpath)
      warn "File exist! (#{launcherpath})"
      exit 1
    end

    rubypath = `rbenv which ruby`.strip
    teutonpath = File.join(Dir.pwd, "diamante")

    puts "# Created with: 'rake devel:launcher'"
    puts "# - Copy this content into: #{launcherpath}"
    puts "# - Then: chmod +x #{launcherpath}"
    puts "RUBYPATH=#{rubypath}"
    puts "COMMANDPATH=#{teutonpath}"
    puts "$RUBYPATH $COMMANDPATH $@"
  end
end
