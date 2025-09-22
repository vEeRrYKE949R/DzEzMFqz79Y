# 代码生成时间: 2025-09-23 00:46:49
# process_manager.rb
# A simple process manager using Ruby and Hanami framework.
# This program allows to start, stop, and restart processes.

require 'hanami'
require 'hanami/utils'
require 'optparse'
require 'logger'
require 'yaml'

# Define a ProcessManager class
class ProcessManager
  # Initialize a new instance of ProcessManager
  #
  # @param [String] config_path path to the process configuration file
  def initialize(config_path)
    @config_path = config_path
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO
    @processes = []
  end

  # Load process configurations from a YAML file
  #
  # @return [Array<Hash>] list of process configurations
  def load_configurations
    YAML.load_file(@config_path)
  end

  # Start the processes
  #
  # @param [Array<Hash>] process_configs list of process configurations to start
  def start_processes(process_configs)
    process_configs.each do |config|
      process_name = config['name']
      command = config['command']
      @logger.info { "Starting process: #{process_name}" }
      system(command)
      @processes << process_name
    rescue => e
      @logger.error { "Error starting process: #{process_name} - #{e.message}" }
    end
  end

  # Stop the processes
  #
  # @param [Array<Hash>] process_configs list of process configurations to stop
  def stop_processes(process_configs)
    process_configs.each do |config|
      process_name = config['name']
      pid = config['pid']
      @logger.info { "Stopping process: #{process_name} with PID: #{pid}" }
      Process.kill('TERM', pid)
      @processes.delete process_name
    rescue => e
      @logger.error { "Error stopping process: #{process_name} - #{e.message}" }
    end
  end

  # Restart the processes
  #
  # @param [Array<Hash>] process_configs list of process configurations to restart
  def restart_processes(process_configs)
    stop_processes(process_configs)
    sleep(5) # wait for processes to stop
    start_processes(process_configs)
  end

  # Parse command line options
  #
  # @param [Array<String>] args command line arguments
  def parse_options(args)
    options = { action: nil, config_path: 'config.yml' }
    OptionParser.new do |opts|
      opts.banner = 'Usage: process_manager.rb [options]'
      opts.on('-a', '--action ACTION', 'Action to perform (start, stop, restart)') do |action|
        options[:action] = action
      end
      opts.on('-c', '--config CONFIG_PATH', 'Path to the process configuration file') do |config_path|
        options[:config_path] = config_path
      end
    end.parse!(args)
    options
  end

  # Run the process manager
  #
  # @param [Array<String>] args command line arguments
  def run(args)
    options = parse_options(args)
    process_configs = load_configurations
    case options[:action]
    when 'start'
      start_processes(process_configs)
    when 'stop'
      stop_processes(process_configs)
    when 'restart'
      restart_processes(process_configs)
    else
      @logger.error { 'Invalid action. Please provide a valid action (start, stop, restart).' }
    end
  end
end

# Main program
if __FILE__ == $0
  process_manager = ProcessManager.new('config.yml')
  process_manager.run(ARGV)
end