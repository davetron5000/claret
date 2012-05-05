desc 'List tasks'
command [:list,:ls] do |c|
  c.action do |global_options,options,args|
    $tasks.each_with_index do |task,index|
      printf("[%d] %s\n",index,task)
    end
  end
end

