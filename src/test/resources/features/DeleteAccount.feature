#Account should be exist to deleted and 200 status code.
#make sure Account that is not exist to get 404 status code.
@Regression
Feature: Delete Account Functionality

  Background: Test Setuip and create New Account
    * def CreateAccount = callonce read('createAccount.feature')
    * def ValidToken = CreateAccount.ValidToken
    * def CreateAccountId = CreateAccount.response.id
    And print CreateAccount
    Given url "https://tek-insurance-api.azurewebsites.net"

  #Scenario #10
  Scenario: Successful delete account
    Given path "api/accounts/delete-account"
    And param primaryPersonId = CreateAccountId
    And header Authorization = "Bearer " + ValidToken
    When method delete
    Then status 200
    And assert response == "Account Successfully deleted"
    Given path "api/accounts/delete-account"
    And param primaryPersonId = CreateAccountId
    And header Authorization = "Bearer " + ValidToken
    When method delete
    Then status 404
    Then print response
    And assert response.errorMessage == "Account with id " + CreateAccountId + " not exist"
