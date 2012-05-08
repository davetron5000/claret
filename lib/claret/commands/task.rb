desc 'Complete, start, or split up tasks in your task list'
arg_name 'task_id'
command :task do |task_command|
  task_command.instance_eval do 

    desc 'Complete a task'
    command :done do |c|
      c.action do |global_options,options,args|
        $task_list.find(args[0]).complete!
      end
    end

    desc 'Start a task'
    arg_name 'task_id'
    command :start do |c|
      c.action do |global_options,options,args|
        $task_list.find(args[0]).start!
      end
    end

    desc 'Split a task into two or more subtasks'
    long_desc <<EOS
Decomposes a task into more tasks, to make it easier to show progress.  The task names can be specified
in two ways:  a comma delimited list, unquotes, or a series of quoted arguments.  The task you split
will be removed and replaced with the new tasks
EOS
    arg_name 'task, task[, task]*'
    command :split do |c|
      c.action do |global_options,options,args|
        $task_list.split(args.shift,Claret::SmartTaskParser.new.parse(args))
      end
    end
  end
end
