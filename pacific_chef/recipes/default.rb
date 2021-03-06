#
# Cookbook Name:: pacific
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
#

group 'pacific'

user 'pacific' do
  group 'pacific'
  system true
  shell '/bin/bash'
end

include_recipe 'apt'
include_recipe 'apache2'

# disable default site
apache_site '000-default' do
  enable false
end

# create apache config
template "#{node['apache']['dir']}/sites-available/pacific.conf" do
  source 'apache2.conf.erb'
  notifies :restart, 'service[apache2]'
end

# create document root
directory '/srv/apache/pacific' do
  action :create
  recursive true
end

# write site
cookbook_file '/srv/apache/pacific/index.html' do
  mode '0644' # forget me to create debugging exercise
end


# enable pacific
apache_site 'pacific' do
  enable true
end
