desc 'Operate on tasks'
arg_name 'task_id'
command :task do |task_command|
  task_command.instance_eval do 

    desc 'Complete a task'
    command :done do |c|
      c.action do |global_options,options,args|
        raise GLI::BadCommandLine,"task_id is required" if args.empty?
        id = args[-1].to_i
        task = $task_list.tasks.select {|_| _.id == id }.first
        if task
          task.complete!
        else
          exit_now!("No task with id #{id}, ids are #{$task_list.tasks.map(&:id).join(',')}",1)
        end
      end
    end

    desc 'Start a task'
    arg_name 'task_id'
    command :start do |c|
      c.action do |global_options,options,args|
      end
    end
  end
end


desc 'Complete a task'
arg_name 'task_id'
command :done do |c|
  c.action do |global_options,options,args|
    command = commands.values.select { |_| _.name == :task }.first.commands.values.select { |_| _.name == :done }.first
    command.execute(global_options,options,args)
  end
end

