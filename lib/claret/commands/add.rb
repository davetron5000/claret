desc 'Add a new task to do'
arg_name 'task_name'
command :add do |c|
  c.action do |global_options,options,args|
    $task_list << Claret::Task.new(args.join(' '))
  end
end

