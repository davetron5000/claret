desc 'Operate on tasks'
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

