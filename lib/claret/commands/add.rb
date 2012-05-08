desc 'Add a new task to do'
long_desc <<EOS
Add a new task to the list.  The task name can be specified with or without quotes
EOS
arg_name 'task name'
command :add do |c|
  c.action do |global_options,options,args|
    $task_list << Claret::Task.new(args.join(' '))
  end
end

