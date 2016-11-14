Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: An annual average expense
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        budget annual 365.00 "Annually budgeted amount"
        """
        When I run `expenses --start 2016-11-12 --count 4 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-12,99.00
        2016-11-13,98.00
        2016-11-14,97.00
        2016-11-15,96.00
        """
