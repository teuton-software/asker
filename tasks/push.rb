# frozen_string_literal: true

require_relative '../lib/asker/version'

namespace :push do
  desc 'Push docker'
  task :docker do
    puts '[INFO] Pushing docker...'
    system("docker push dvarrui/#{Asker::NAME}:#{Asker::VERSION}")
  end
end
