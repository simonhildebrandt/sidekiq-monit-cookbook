include_recipe "opsworks_sidekiq::service"

node[:deploy].each do |application, deploy|
  template "#{node[:monit][:conf_dir]}/sidekiq_#{application}.monitrc" do
    mode 0644
    source "sidekiq_monitrc.erb"
    variables({
      user: deploy[:user],
      current_path: "#{deploy[:deploy_to]}/current",
      pid_file: "#{deploy[:deploy_to]}/shared/pids/sidekiq.pid",
      rails_env: deploy[:rails_env],
      identifier: "sidekiq_#{application}"
    })
    notifies :reload, resources(:service => "monit"), :immediately
  end
end
