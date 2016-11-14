Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: A single one-time expense
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        once 2016-11-14 60.00 "A one-time expense"
        """
        When I run `expenses --start 2016-11-12 --count 4 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-12,100.00
        2016-11-13,100.00
        2016-11-14,40.00
        2016-11-15,40.00
        """

    Scenario: Multiple one-time expenses
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        once 2016-11-13 60.00 "A one-time expense"
        once 2016-11-14 20.00 "A one-time expense"
        """
        When I run `expenses --start 2016-11-12 --count 4 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-12,100.00
        2016-11-13,40.00
        2016-11-14,20.00
        2016-11-15,20.00
        """

    Scenario: Multiple one-time expenses on the same day
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        once 2016-11-14 60.00 "A one-time expense"
        once 2016-11-14 20.00 "A one-time expense"
        """
        When I run `expenses --start 2016-11-12 --count 4 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-12,100.00
        2016-11-13,100.00
        2016-11-14,20.00
        2016-11-15,20.00
        """
