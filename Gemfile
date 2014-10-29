source 'https://rubygems.org'

gemspec

gem "zmq", :git => "https://github.com/opscode/rbzmq", :branch => "master"


platforms :mswin, :mingw do
  gem "ffi"
  gem "rdp-ruby-wmi"
  gem "windows-api"
  gem "windows-pr"
  gem "win32-api"
  gem "win32-dir"
  gem "win32-event"
  gem "win32-mutex"
  gem "win32-process", "~> 0.7.3"
  gem "win32-service"
end

platforms :mingw_18 do
  gem "win32-open3"
end

group :test do
  gem "rspec"
  gem 'rack'
  gem 'thin'
end
