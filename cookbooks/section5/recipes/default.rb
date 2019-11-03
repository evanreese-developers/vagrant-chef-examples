#
# Cookbook:: section5
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
node.default['message'] = "Welcome to Chef"
file '/welcome' do 
  content "#{node['message']}"
end
