desc 'Add a new task to do'
arg_name 'task_name'
command :add do |c|
  c.action do |global_options,options,args|
    $tasks << args.join(' ').force_encoding("UTF-8")
  end
end

