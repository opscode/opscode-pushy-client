#
# Copyright:: Copyright (c) 2013 Opscode, Inc.
# License:: Apache License, Version 2.0
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

name "opscode-pushy-client"

default_version "local_source"

# For the specific super-special version "local_source", build the source from
# the local git checkout. This is what you'd want to occur by default if you
# just ran omnibus build locally.
version("local_source") { source path: "#{project.files_path}/../.." }
#TODO: Check if I need to exclude any current omnibus generated files.
# options: {:exclude => [some paths]}

# For any version other than "local_source", fetch from github.
if version != "local_source"
  source git: "git://github.com/chef/opscode-pushy-client"
end

relative_path "opscode-pushy-client"

dependency "rubygems"
dependency "bundler"
dependency "appbundler"
dependency "chef"
dependency "openssl-customization"

if windows?
  dependency "libzmq4x-windows"
else
  dependency "libzmq"
end

build do
  env = with_standard_compiler_flags(with_embedded_path)

  zmq_lib_dir = if windows?
                  "#{install_dir}/embedded/bin"
                else
                  "#{install_dir}/embedded/lib"
                end

  bundle "install", env: env
  gem "build opscode-pushy-client.gemspec", env: env
  gem "install opscode-pushy-client*.gem" \
      " --no-ri --no-rdoc" \
      " --verbose", env: env

  appbundle 'opscode-pushy-client'
end
