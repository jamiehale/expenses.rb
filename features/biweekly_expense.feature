Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: A bi-weekly expense
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        biweekly 2016-11-14 20.00 "A bi-weekly expense"
        """
        When I run `expenses --start 2016-11-13 --count 17 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-13,100.00
        2016-11-14,80.00
        2016-11-15,80.00
        2016-11-16,80.00
        2016-11-17,80.00
        2016-11-18,80.00
        2016-11-19,80.00
        2016-11-20,80.00
        2016-11-21,80.00
        2016-11-22,80.00
        2016-11-23,80.00
        2016-11-24,80.00
        2016-11-25,80.00
        2016-11-26,80.00
        2016-11-27,80.00
        2016-11-28,60.00
        2016-11-29,60.00
        """
