Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: An annual expense
        Given a file named "tmp/input.yml" with:
        """
        account "Main" 100.00
        annual 11-25 20.00 "An annual event"
        """
        When I run `expenses --start 2016-11-14 --count 33 tmp/input.yml`
        Then the output should contain:
        """
        Date,Main
        2016-11-14,100.00
        2016-11-15,100.00
        2016-11-16,100.00
        2016-11-17,100.00
        2016-11-18,100.00
        2016-11-19,100.00
        2016-11-20,100.00
        2016-11-21,100.00
        2016-11-22,100.00
        2016-11-23,100.00
        2016-11-24,100.00
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
        """
