Feature: User Module

  Scenario: Creates list of users with given input array
    Given url 'https://petstore.swagger.io/v2/user/createWithArray'
    And request
    """
    [
    {
        "id": 1,
        "username": "brenda",
        "firstName": "Brenda",
        "lastName": "Chitra",
        "email": "user1@example.com",
        "password": "password123",
        "phone": "123456789",
        "userStatus": 1
     },
     {
        "id": 2,
        "username": "brenda2",
        "firstName": "Brenda2",
        "lastName": "Chitra",
        "email": "user2@example.com",
        "password": "password456",
        "phone": "987654321",
        "userStatus": 1
    }
    ]
    """
    When method POST
    Then status 200
    And match response == {code: 200, type: 'unknown', message: 'ok'}
    And print response


  Scenario: Creates list of users with given input list
    Given url 'https://petstore.swagger.io/v2/user/createWithList'
    And request
    """
    [
  {
    "id": 3,
    "username": "brenda",
    "firstName": "Brenda",
    "lastName": "Chitra",
    "email": "user3@example.com",
    "password": "password789",
    "phone": "987654321",
    "address": [
       { "city": "Jakarta",
        "State": "Indonesia"}
    ],
    "userStatus": 1
  }
]
    """
    When method POST
    Then status 200
    And match response == {"code": 200, "type": "unknown", "message": "ok"}

  Scenario: Get User By Username
    Given url 'https://petstore.swagger.io/v2/user/brenda'
    When method GET
    Then status 200
    And print response

  Scenario: updated user
    Given url "https://petstore.swagger.io/v2/user/brenda"
    And request
    """
    {
      "id": 1,
      "username": "brendachitra",
      "firstName": "Brenda",
      "lastName": "Chitra",
      "email": "user1@example.com",
      "password": "password123",
      "phone": "123456789",
      "userStatus": 1
    }
    """
    When method put
    Then status 200
    And match response == {"code": 200,"type": "unknown","message": "1"}

  Scenario: delete user
    Given url "https://petstore.swagger.io/v2/user/brendachitraaa"
    When method delete
    Then status 404
    And print response

  Scenario: Login and print token expiration date and rate limit
    Given url 'https://petstore.swagger.io/v2/user/login'
    And param username = 'brendachitra'
    And param password = 'password123'
    When method GET
    Then status 200
    And print response

    And def xExpiresAfter = responseHeaders['X-Expires-After'][0]
    And def xRateLimit = responseHeaders['X-Rate-Limit'][0]

    * print 'X-Expires-After: ', xExpiresAfter
    * print 'X-Rate-Limit: ', xRateLimit

  Scenario: logs out current logged in user session
    Given url 'https://petstore.swagger.io/v2/user/logout'
    When method GET
    Then status 200
    And print response
