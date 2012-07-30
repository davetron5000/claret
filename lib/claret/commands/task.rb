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
in two ways:  a comma delimited list, unquoted, or a series of quoted arguments.  The task you split
will be removed and replaced with the new tasks.  

Any tasks that the old task depended on, the new tasks will all depend on.  Any task that depended
on the old task will depend on all the new tasks.
EOS
    arg_name 'task, task[, task]*'
    command :split do |c|
      c.action do |global_options,options,args|
        $task_list.split(args.shift,Claret::SmartTaskParser.new.parse(args))
      end
    end

    desc 'Make the first task depend on the second'
    long_desc <<EOS
Creates a dependency between the two tasks (task_id1 will depend on task_id2) such that
the first task cannot be marked complete (or started) until the second task is complete.
This allows you to get a list of tasks that CAN be started, hiding those that cannot
be started due to missing dependencies.
EOS
    arg_name 'task_id1, task_id2'
    command [:depend,:dp,:dep] do |c|
      c.action do |global_options,options,args|
        $task_list.create_dependency(args[0],args[1])
      end
    end

    desc 'Break dependencies between two tasks'
    long_desc 'When task_id1 depends on task_id2, this command breaks the dependency between them'
    arg_name 'task_id1, task_id2'
    command [:undepend,:undep] do |c|
      c.action do |global_options,options,args|
        $task_list.break_dependency(args[0],args[1])
      end
    end
  end
end
