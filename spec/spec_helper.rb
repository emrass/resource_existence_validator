require 'rails'
require 'sqlite3'
require 'active_record'
require 'active_record/base'

require 'resource_existence_validator'
Dir["support/**/*.rb"].each do |file|
  require file
  # autoload file.to_s.chomp(".rb").to_s.capitalize file
end

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection( adapter: "sqlite3", database: ":memory:" )

autoload :Validatable,             File.join(File.dirname(__FILE__), "support", "models", "validatable.rb")
autoload :ValidatableAllowNil,     File.join(File.dirname(__FILE__), "support", "models", "validatable_allow_nil.rb")
autoload :ValidatableForeignName,  File.join(File.dirname(__FILE__), "support", "models", "validatable_foreign_name.rb")
autoload :Associatable,            File.join(File.dirname(__FILE__), "support", "models", "associatable.rb")

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'

  config.before(:suite) do
    ActiveRecord::Schema.define(version: 1) do
      create_table :associatables, force: true do |t|
        t.string :associatable_name
      end

      create_table :validatables, force: true do |t|
        t.references :associatable
      end

      create_table :validatable_foreign_names, force: true do |t|
        t.references :foreigner
      end
    end
  end

  config.after(:suite) do
    ActiveRecord::Base.connection.drop_table(:associatables)
    ActiveRecord::Base.connection.drop_table(:validatables)
    ActiveRecord::Base.connection.drop_table(:validatable_foreign_names)
  end
end
