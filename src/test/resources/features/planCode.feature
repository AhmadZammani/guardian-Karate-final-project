@Regression
Feature: plan code feature

  Background: 
    Background: setup test

    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    * def ValidToken = result.response.token
    And print result

  #Scenario #9
  Scenario: Validate plan codes
    Given path "api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + ValidToken
    When method get
    Then status 200
    And print response
    And assert response[0].planExpired == false
    And assert response[1].planExpired == false
    And assert response[2].planExpired == false
    And assert response[3].planExpired == false
