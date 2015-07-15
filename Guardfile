# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'zeus rspec' do
  watch(%r{^app/(.+)\.rb$})           { "spec" }
  watch('config/routes.rb')           { "spec" }
  watch(%r{^lib/(.+)\.rb$})           { "spec" }

  watch('spec/spec_helper.rb')        { "spec" }
  watch(%r{^spec/support/(.+)\.rb$})  { "spec" }
  watch(%r{^spec/.+_spec\.rb$})       { "spec" }
end
