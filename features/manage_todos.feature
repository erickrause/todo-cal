Feature: Manage todos
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new todo
    Given I am on the new todo page
    When I fill in "Summary" with "summary 1"
    And I fill in "Description" with "description 1"
    And I fill in "Start" with "start 1"
    And I fill in "End" with "end 1"
    And I press "Create"
    Then I should see "summary 1"
    And I should see "description 1"
    And I should see "start 1"
    And I should see "end 1"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity or Selenium2 (webdriver) when pages rely on
  # Javascript events. Only Culerity supports confirmation dialogs.
  #
  # Since Culerity and Selenium2 has some overhead, Cucumber-Rails will detect 
  # the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn off this emulation by tagging your scenario with @selenium, 
  # @culerity, @celerity or @javascript. (See the Capybara documentation for 
  # details about those tags). If any of these tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails'' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  # TODO: Verify with Rob what this means: The rack driver will detect the 
  # onclick javascript and emulate its behaviour without a real Javascript
  # interpreter.
  #
  Scenario: Delete todo
    Given the following todos:
      |summary|description|start|end|
      |summary 1|description 1|start 1|end 1|
      |summary 2|description 2|start 2|end 2|
      |summary 3|description 3|start 3|end 3|
      |summary 4|description 4|start 4|end 4|
    When I delete the 3rd todo
    Then I should see the following todos:
      |Summary|Description|Start|End|
      |summary 1|description 1|start 1|end 1|
      |summary 2|description 2|start 2|end 2|
      |summary 4|description 4|start 4|end 4|
