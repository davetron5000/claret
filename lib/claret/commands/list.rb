desc 'List tasks'
command [:list,:ls] do |c|
  c.action do |global_options,options,args|
    $task_list.tasks.each do |task|
      printf("[%d] %s\n",task.id,task.name) unless task.completed?
    end
  end
end

