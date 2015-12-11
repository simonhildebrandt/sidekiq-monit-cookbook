include_recipe "sidekiq-monit::service"

package "monit"

template node[:monit][:conf] do
  source "monitrc.erb"
  mode 0600

  notifies :reload, "service[monit]", :immediately

  sleep(10)
end
