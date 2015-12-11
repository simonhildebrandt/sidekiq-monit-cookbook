service "monit" do
  supports :reload => true
  reload_command "sudo monit reload"
  action :nothing
end
