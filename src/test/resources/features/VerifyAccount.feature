@Regression
Feature: Verify Account

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    * def ValidToken = result.response.token
    And print result

  #scenari #7
  Scenario: Verify and account that is exist
    Given path "api/accounts/get-account"
    # with def step we can create variable and and assign value for reusibility
    * def existingId = 9680
    And param primaryPersonId = existingId
    #Hearder have to add to requseatt
    And header Authorization = "Bearer " + ValidToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == existingId

  #Scenario #8
  Scenario: verify get-account with no id exist
    Given path "api/accounts/get-account"
    * def notExistingId = 555556
    And header Authorization = "Bearer " + ValidToken
    And param primaryPersonId = notExistingId
    When method get
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id " + notExistingId + " not found"
