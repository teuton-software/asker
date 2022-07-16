# frozen_string_literal: true

require_relative '../lib/asker/version'

namespace :docker do
  desc 'Push docker'
  task :push do
    puts '[INFO] Pushing docker...'
    system("docker push dvarrui/#{Asker::NAME}") #{}":#{Asker::VERSION}")
  end
end
