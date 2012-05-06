desc 'List tasks'
command [:list,:ls] do |c|
  c.instance_eval do
    desc 'List all tasks, including completed ones'
    command :all do |all|
      all.action do 
        Claret::TaskListTerminalSerializer.new(:all).write($task_list)
      end
    end

    desc 'List only tasks in-progress'
    command [:wip,:inprogress] do |wip|
      wip.action do
        Claret::TaskListTerminalSerializer.new(:wip).write($task_list)
      end
    end

    desc 'List tasks that are not completed'
    command [:tasks] do |tasks|
      tasks.action do |global_options,options,args|
        Claret::TaskListTerminalSerializer.new.write($task_list)
      end
    end
  end
  c.default_command :tasks
end

