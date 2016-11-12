Feature: Expense Projection
    In order to determine what my balance will be
    As a command-line user
    I want to be able to run the expense command

    Scenario: Usage
        When I run `expenses`
        Then the output should contain "Usage:"
