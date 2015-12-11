package "monit"
service "monit"

template node[:monit][:conf] do
  source "monitrc.erb"
  mode 0600
end

execute "reload monit" do
  command "sudo monit reload"
end
