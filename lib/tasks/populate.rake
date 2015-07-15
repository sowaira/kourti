# encoding: utf-8

namespace :db do
  desc "Bootstrap Data"
  task :bootstrap => :environment do
    #TODO
  end

  desc "Erase and fill database"
  task :populate => :environment do

    [AdminUser].each(&:delete_all)

    Rake::Task["db:bootstrap"].invoke

    AdminUser.create do |a|
      a.email = 'admin@local.dev'
      a.password = a.password_confirmation = 'admin@local.dev'
    end

  end
end
