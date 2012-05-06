desc 'List tasks'
command [:list,:ls] do |c|
  c.instance_eval do
    desc 'List all tasks, including completed ones'
    command :all do |all|
      all.action do 
        Claret::TaskListTerminalSerializer.new(:all).write($task_list)
      end
    end
  end
  c.action do |global_options,options,args|
    Claret::TaskListTerminalSerializer.new.write($task_list)
  end
end

