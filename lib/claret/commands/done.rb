desc 'Complete a task'
arg_name 'task_id'
command :done do |c|
  c.action do |global_options,options,args|
    raise GLI::BadCommandLine,"task_id is required" if args.empty?
    index = args[0].to_i
    if $tasks.length > index
      $tasks.delete_at(args[0].to_i)
    else
      exit_now!("No task with id #{index}",1)
    end
  end
end

