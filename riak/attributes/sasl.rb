#
# Author:: Benjamin Black (<b@b3k.us>)
# Cookbook Name:: riak
#
# Copyright (c) 2010 Basho Technologies, Inc.
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
#

set_unless[:riak][:sasl][:sasl_error_logger][:file] = "/var/log/riak/sasl-error.log"
set_unless[:riak][:sasl][:errlog_type] = :error
node[:riak][:sasl][:errlog_type] = node[:riak][:sasl][:errlog_type].to_s.to_sym
set_unless[:riak][:sasl][:error_logger_mf_dir] = "/var/log/riak/sasl"
set_unless[:riak][:sasl][:error_logger_mf_maxbytes] = 10485760
set_unless[:riak][:sasl][:error_logger_mf_maxfiles] = 5
