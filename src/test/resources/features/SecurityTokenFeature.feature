@Smoke
Feature: Security Token Tests

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  #Scenario #1
  Scenario: Generate valid token with valid username and password
    #prepate the request
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  #Scenario #2
  Scenario Outline: validate token with invalid username
    And request
      """
      {
       "username": "<username>",
       "password": "<password>"
      }
      """
    When method post
    Then status 400
    And print response
    And assert response.errorMessage=="<errorMessage>"

    Examples: 
      | username   | password       | errorMessage         |
      | wrong      | tek_supervisor | User not found       |
      | supervisor | wrong          | Password Not Matched |
  #Scenario: validate token with invalid password
    #And request
      #"""
      #{
       #"username": "supervisor",
       #"password": "wrong"
      #}
      #"""
    #When method post
    #Then status 400
    #And print response
    #And assert response.errorMessage=="Password Not Matched"
