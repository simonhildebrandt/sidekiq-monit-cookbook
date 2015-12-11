node[:deploy].each do |application, deploy|
  execute "restart sidekiq workers" do
    command "sudo monit -g sidekiq_#{deploy[:application]}_group restart"
    action :nothing

    subscribes :run, "deploy[#{deploy[:deploy_to]}]", :delayed
  end
end
