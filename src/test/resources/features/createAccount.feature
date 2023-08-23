@Regression
Feature: Creat Account feature

  Background: setup tests and generate token
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    * def ValidToken = result.response.token
    And print result

  #Scenario #10
  Scenario: create valid account
    Given path "api/accounts/add-primary-account"
    And header Authorization = "Bearer " + ValidToken
    #calling java in feature file.this utility will create object from java class
    * def generateDataObject = Java.type('Api.Utility.data.GeneratData')
    * def autoEmail = generateDataObject.getEmail()
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "kabul",
      "lastName": "mazar",
      "title": "Mr",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Enginner",
      "dateOfBirth": "2023-08-24"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
   
