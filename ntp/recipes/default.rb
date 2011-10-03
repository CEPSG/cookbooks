#
# Cookbook Name:: ntp
# Recipe:: default
# Author:: Joshua Timberman (<joshua@opscode.com>)
#
# Copyright 2009, Opscode, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node[:platform] 
when "ubuntu","debian"
  package "ntpdate" do
    action :install
  end
end

package "ntp" do
  action :install
end

service node[:ntp][:service] do
  action :stop
end

is_xen = ::File.exist?("/proc/sys/xen")
log "  Configure Xen for independent wall clock..." if is_xen
bash "independent wallclock" do
  only_if { is_xen }
  code <<-EOH
    echo 1 > /proc/sys/xen/independent_wallclock
  EOH
end

log "  Update time using ntpdate..."
bash "update time" do
  code <<-EOH
    ntpdate pool.ntp.org
  EOH
end

template "/etc/ntp.conf" do
  source "ntp.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => node[:ntp][:service])
end

service node[:ntp][:service] do
  action :start
end