module Expenses

  ## Loads configuration from file
  class ConfigurationLoader

    def initialize
      @loaders = {
        account: AccountLoader.new,
        once: OneTimeExpenseLoader.new,
        daily: DailyExpenseLoader.new,
        annual: AnnualExpenseLoader.new,
        monthly: MonthlyExpenseLoader.new,
        weekly: WeeklyExpenseLoader.new,
        biweekly: BiWeeklyExpenseLoader.new,
        budget: BudgetExpenseLoader.new
      }
    end

    def load( filename )
      configuration = Configuration.new
      File.open( filename ) do |f|
        read_file( f, configuration )
      end
      configuration
    end

    private

    def read_file( f, configuration )
      line_number = 0
      f.each_line do |line|
        line_number += 1
        process_line( line.strip, line_number, configuration )
      end
    end

    def process_line( line, line_number, configuration )
      return if line.empty?
      return if line[ 0 ] == '#'
      tokens = tokenize( line )
      raise "Unrecognized command on line #{line_number}: #{tokens[0]}" unless @loaders.key? tokens[ 0 ].to_sym
      @loaders[ tokens[ 0 ].to_sym ].load( tokens, line_number, configuration )
    end

    def tokenize( line )
      tokens = []
      in_string = false
      token = ''
      line.each_char do |c|
        if c == '"'
          if in_string
            tokens << token
            token = ''
            in_string = false
          else
            in_string = true
          end
        elsif c == ' ' || c == "\t"
          if in_string
            token << c
          else
            unless token.empty?
              tokens << token
              token = ''
            end
          end
        else
          token << c
        end
      end
      tokens << token unless token.empty?
      tokens
    end

    ## Helper parent class for loaders
    class Loader

      def validate_token_count( tokens, count, line_number )
        raise "Syntax error on line #{line_number}" unless tokens.length == count
      end

      def date( token )
        Date.parse( token )
      end

      def float( token )
        token.to_f
      end

      def int( token )
        token.to_i
      end

    end

    ## Loads an account
    class AccountLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 3, line_number )
        configuration.add_account( Account.new( tokens[ 1 ], float( tokens[ 2 ] ) ) )
      end

    end

    ## Loads a one-time expense
    class OneTimeExpenseLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 4, line_number )
        configuration.add_expense( OneTimeExpense.new( date( tokens[ 1 ] ), float( tokens[ 2 ] ), tokens[ 3 ] ) )
      end

    end

    ## Loads a daily expense
    class DailyExpenseLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 3, line_number )
        configuration.add_expense( DailyExpense.new( float( tokens[ 1 ] ), tokens[ 2 ] ) )
      end

    end

    ## Loads an annual expense
    class AnnualExpenseLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 4, line_number )
        month, day = tokens[ 1 ].split( '-' ).map( &:to_i )
        configuration.add_expense( AnnualExpense.new( month, day, float( tokens[ 2 ] ), tokens[ 3 ] ) )
      end

    end

    ## Loads a monthly expense
    class MonthlyExpenseLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 4, line_number )
        configuration.add_expense( MonthlyExpense.new( int( tokens[ 1 ] ), float( tokens[ 2 ] ), tokens[ 3 ] ) )
      end

    end

    ## Loads a weekly expense
    class WeeklyExpenseLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 4, line_number )
        configuration.add_expense( WeeklyExpense.new( date( tokens[ 1 ] ), float( tokens[ 2 ] ), tokens[ 3 ] ) )
      end

    end

    ## Loads a biweekly expense
    class BiWeeklyExpenseLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 4, line_number )
        configuration.add_expense( BiWeeklyExpense.new( date( tokens[ 1 ] ), float( tokens[ 2 ] ), tokens[ 3 ] ) )
      end

    end

    ## Loads a budget-related expense
    class BudgetExpenseLoader < Loader

      def load( tokens, line_number, configuration )
        validate_token_count( tokens, 4, line_number )
        validate_type( tokens[ 1 ], line_number )
        if tokens[ 1 ] == 'monthly'
          add_monthly_expense( tokens, configuration )
        else
          add_annual_expense( tokens, configuration )
        end
      end

      private

      def add_monthly_expense( tokens, configuration )
        configuration.add_expense( MonthlyBudgetExpense.new( float( tokens[ 2 ] ), tokens[ 3 ] ) )
      end

      def add_annual_expense( tokens, configuration )
        configuration.add_expense( AnnualBudgetExpense.new( float( tokens[ 2 ] ), tokens[ 3 ] ) )
      end

      def validate_type( type, line_number )
        raise "Syntax error on line #{line_number}" unless valid_type?( type )
      end

      def valid_type?( type )
        %w( monthly annual ).include? type
      end

    end

  end

end
