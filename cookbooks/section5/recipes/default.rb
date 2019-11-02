#
# Cookbook:: section5
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#

file '/welcome' do 
  content "#{node['memory']['total']}"
end
