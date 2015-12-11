service "monit" do
  supports :reload => true
  reload_command "sudo monit reload && sleep 20"
  action :nothing
end
