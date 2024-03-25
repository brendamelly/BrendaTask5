Feature: User Module

  Background:
    # Assume the user is already logged in and has a valid token
    Given url 'https://petstore.swagger.io/v2/user/login'
    And request { username: 'brendachitra', password: 'password123' }
    When method GET
    Then status 200
    And def authToken = response.token

  Scenario: Create a new user
    Given url 'https://petstore.swagger.io/v2/user'
    And header Authorization = 'Bearer ' + authToken
    And request
    """
    {
      "id": 1,
      "username": "new_user",
      "firstName": "Brenda",
      "lastName": "Chitra",
      "email": "brenda.chitra@example.com",
      "password": "password123",
      "phone": "123456789",
      "userStatus": 1
    }
    """
    When method POST
    Then status 200