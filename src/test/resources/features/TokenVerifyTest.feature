@Smoke
Feature: Token Verify Feature

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"

  #Scenario #3
  Scenario: Verify a valid token
    And param username = "Supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response == "true"

  #Scenario #4
  Scenario: verify invalid username
    And param username = "wrong"
    And param token = response.token
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  #Scenario #5
  Scenario: validate with  invalid token
    And param username = "Supervisor"
    And param token = "invalid token"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
