# 代码生成时间: 2025-09-21 08:26:49
# frozen_string_literal: true

# database_migration_tool.rb
# This script provides a database migration tool for Hanami framework applications.

require 'hanami'
require 'hanami/model'
require 'hanami/model/migrations'
require 'pathname'

# The MigrationTool class encapsulates the functionality for running migrations.
class MigrationTool
  # Initialize with a Hanami application and a migration directory path.
  # @param app [Hanami::App] The Hanami application instance.
  # @param migrations_path [String] The path to the migrations directory.
  def initialize(app, migrations_path)
    @app = app
    @migrations_path = Pathname.new(migrations_path).realpath
  end

  # Run all pending migrations.
  # @return [void]
  def run
    Hanami::Model::Migrations.new(@app) do
      directory @migrations_path
    end.run
  end

  # Rollback the last batch of migrations.
  # @return [void]
  def rollback
    Hanami::Model::Migrations.new(@app) do
      directory @migrations_path
    end.rollback
  end

  # List all available migrations.
  # @return [Array<String>]
  def list
    @migrations_path.children.map(&:basename).map(&:to_s)
  end
end

# Usage example:
# Assuming a Hanami application instance is available as `app` and the migrations
# directory is located at './db/migrations'.

if __FILE__ == $0
  app = Hanami::App.locate!
  tool = MigrationTool.new(app, './db/migrations')
  begin
    tool.run
    puts 'Migrations ran successfully.'
  rescue StandardError => e
    puts 'An error occurred while running migrations: ' + e.message
  end
end