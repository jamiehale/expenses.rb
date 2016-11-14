Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: A monthly expense
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        monthly 15 20.00 "A monthly bill"
        """
        When I run `expenses --start 2016-11-14 --count 33 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-14,100.00
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
        2016-11-28,80.00
        2016-11-29,80.00
        2016-11-30,80.00
        2016-12-01,80.00
        2016-12-02,80.00
        2016-12-03,80.00
        2016-12-04,80.00
        2016-12-05,80.00
        2016-12-06,80.00
        2016-12-07,80.00
        2016-12-08,80.00
        2016-12-09,80.00
        2016-12-10,80.00
        2016-12-11,80.00
        2016-12-12,80.00
        2016-12-13,80.00
        2016-12-14,80.00
        2016-12-15,60.00
        2016-12-16,60.00
        """

    Scenario: A monthly expense at the end of the month
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        monthly -1 20.00 "A monthly bill on the last day of the month"
        """
        When I run `expenses --start 2016-11-28 --count 5 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-28,100.00
        2016-11-29,100.00
        2016-11-30,80.00
        2016-12-01,80.00
        2016-12-02,80.00
        """
