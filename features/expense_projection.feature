Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: Usage
        When I run `expenses`
        Then the output should contain "Usage:"

    Scenario: No expenses
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 0.00
        """
        When I run `expenses --start 2016-11-12 --count 4 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-12,0.00
        2016-11-13,0.00
        2016-11-14,0.00
        2016-11-15,0.00
        """
