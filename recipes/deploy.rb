node[:deploy].each do |application, deploy|
  execute "restart sidekiq workers" do
    command "monit -g sidekiq_#{deploy[:application]}_group restart"
    action :nothing

    subscribes :run, "deploy[#{deploy[:deploy_to]}]", :immediately
  end
end
