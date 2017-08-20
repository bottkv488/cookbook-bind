bind_service 'default' do
  sysconfdir '/test/etc'
  vardir '/test/var'
  run_user 'bind'
  run_group 'bind'
  run_user_id 891
  run_group_id 892
  action [:create, :start]
end

bind_config 'default' do
  ipv6_listen false
  options_file '/etc/bind/bind.options'
  conf_file '/etc/bind/bind.conf'
  query_log 'query.log'
  options [
    'notify no',
    'recursion yes',
  ]
end
