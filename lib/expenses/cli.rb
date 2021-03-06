require 'thor'

module Expenses

  ## CLI (via Thor)
  class CLI < Thor

    desc 'project INPUT_FILE', <<-eos
        Project balances from the input file.
        eos
    method_option :start, aliases: '-s', desc: 'Specify a start date for the projection'
    method_option :count, aliases: '-c', desc: 'Number of days to project'
    def project( filename )
      ProjectionCommand.new.run( options, ConfigurationLoader.new.load( filename ) )
    end

    default_task :project

  end

end
