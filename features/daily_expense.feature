Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: A daily expense
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        daily 5.00 "Holes in pockets"
        """
        When I run `expenses --start 2016-11-12 --count 4 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-12,95.00
        2016-11-13,90.00
        2016-11-14,85.00
        2016-11-15,80.00
        """
