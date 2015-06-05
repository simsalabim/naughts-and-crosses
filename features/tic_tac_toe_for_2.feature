Feature: Create game and play it

  @javascript
  Scenario: Create and play default Tic-Tac-Toe (3x3x3) game
    for 2 players in hot seat mode. Then try rematch

    When I am on the homepage
    Then I should see game creation form
    When I start new game with defaults
    Then I should see a blank game board

    When first human makes move to (0, 0)
    And second human makes move to (0, 1)
    And first human makes move to (1, 1)
    And second human makes move to (0, 2)
    And first human makes move to (2, 2)
    Then I should see board with winner
    And winning streak is 3 cells

    # Keep clicking cells even when the game is finished
    When human makes move to (0, 0)
    And human makes move to (2, 0)
    Then I should see board with winner
    And winning streak is 3 cells

    When I click to rematch the game
    Then I should see a blank game board

    When first human makes move to (0, 0)
    And second human makes move to (0, 1)
    And first human makes move to (0, 2)
    And second human makes move to (2, 0)
    And first human makes move to (2, 1)
    When first human makes move to (2, 2)
    And second human makes move to (1, 1)
    When first human makes move to (1, 0)
    And second human makes move to (1, 2)

    Then I should see a cat's game board
