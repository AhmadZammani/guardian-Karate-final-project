@Regression
Feature: create account and add new phone number

  Background: 
    * def CreateAccountResult = callonce read('createAccount.feature')
    And print CreateAccountResult
    * def ValidToken = CreateAccountResult.ValidToken
    * def CreateAccountId = CreateAccountResult.response.id
    Given url "https://tek-insurance-api.azurewebsites.net"

  #Scenario #12
  Scenario: Adding Pnone Number to an Account
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = CreateAccountId
    And header Authorization = "Bearer " + ValidToken
    * def dataGenerator = Java.type('Api.Utility.data.GeneratData')
    * def phoneNumGenerator = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(phoneNumGenerator)",
      "phoneExtension": "",
      "phoneTime": "Daytime",
      "phoneType": "DeskPhone"
      }
      """
      When method post
      And status 201
      And assert response.phoneNumber == phoneNumGenerator