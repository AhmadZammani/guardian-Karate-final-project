@Regression 
Feature: Create end to end execution

  Background: setup tests and create End to End test
    
    Background:

    * def EnToEndTest = callonce read('createAccount.feature')
    And print EnToEndTest
    * def ValidToken = EnToEndTest.ValidToken
    * def CreateAccountId = EnToEndTest.response.id
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: creating End to End execution test
    # creating priamry account
    Given path "api/accounts/add-primary-account"
    And header Authorization = "Bearer " + ValidToken
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
      "employmentStatus": "Engineer",
      "dateOfBirth": "2023-08-24"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    # adding phone nummber to the created account
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
    # Adding address
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = CreateAccountId
    And header Authorization = "Bearer " + ValidToken
    * def EndToEndAddress = Java.type('Api.Utility.data.GeneratData')
    * def autoAddress = EndToEndAddress.getAutoAddress()
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "#(autoAddress)",
      "city": "Sacramento",
      "state": "CA",
      "postalCode": "95899",
      "countryCode": "",
      "current": true
      }
      """
    When method post
    And status 201
    And print response
    And assert response.addressLine1 == autoAddress
    #Adding new car to the created account
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = CreateAccountId
    And header Authorization = "Bearer " + ValidToken
    * def PlateGenerator = Java.type('Api.Utility.data.GeneratData')
    * def LicenseAutoGenerator = PlateGenerator.getLicensePlate()
    And request
      """
      {
      "make": "Ford",
      "model": "Mustang ",
      "year": "2020",
      "licensePlate": "#(LicenseAutoGenerator)"
      }
      """
    When method post
    And status 201
    And print response
    And assert response.licensePlate == LicenseAutoGenerator
    # And deleting the account eventually
    Given path "api/accounts/delete-account"
    And param primaryPersonId = CreateAccountId
    And header Authorization = "Bearer " + ValidToken
    When method delete
    Then status 200
    And assert response == "Account Successfully deleted"
