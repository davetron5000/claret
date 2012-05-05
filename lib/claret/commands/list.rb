desc 'List tasks'
command [:list,:ls] do |c|
  c.action do |global_options,options,args|
    $tasks.each do |task|
      puts task
    end
  end
end

