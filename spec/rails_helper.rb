# rails_helper.rb

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("Production mode!") if Rails.env.production?

require 'rspec/rails'
require 'database_cleaner/active_record'    # ← ここを追加

# (もし spec/support/*.rb を使っているなら↓を有効化)
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# マイグレーションチェックなど…

RSpec.configure do |config|
  # fixtures は使わないなら nil でもOK
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # ここを false に！
  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # DatabaseCleaner の設定
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
