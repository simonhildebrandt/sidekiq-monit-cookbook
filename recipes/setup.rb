include_recipe "sidekiq-monit::service"

node[:deploy].each do |application, deploy|
  identifier = "sidekiq_#{application}"

  template "#{node[:monit][:conf_dir]}/sidekiq_#{application}.monitrc" do
    mode 0644
    source "sidekiq_monitrc.erb"
    variables({
      user: deploy[:user],
      current_path: "#{deploy[:deploy_to]}/current",
      pid_file: "#{deploy[:deploy_to]}/shared/pids/sidekiq.pid",
      rails_env: deploy[:rails_env],
      identifier: identifier,
      log_file: "#{deploy[:deploy_to]}/shared/log/#{identifier}_#{deploy[:rails_env]}.log"
    })

    notifies :reload, "service[monit]", :immediately
  end
end
