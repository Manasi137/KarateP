Feature:  Testing Restful Booker API

  Background:
    * url 'https://restful-booker.herokuapp.com'

  Scenario: To retrieve token from given credentials
    Given url 'https://restful-booker.herokuapp.com/Auth'
    And def request
    """
    {
      "username": "admin",
      "password": "password123"
    }
    """
    When method POST
    Then status 200
    * print response
    * def jsonResponse = response
    * def name = jsonResponse.data.token
    * print name

  Scenario: GET Booking IDs Request
    Given path '/booking/{bookingId}'
    And def bookingId = 1
    When method GET
    Then status 200
    And print response

  Scenario: POST Request
    Given path '/booking'
    And header Content-type = "application/json"
    And request { "firstname": "Manasi", "lastname": "Patil", "totalprice": 100, "depositpaid": true, "bookingdates": { "checkin": "2024-01-10", "checkout": "2024-01-11" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 200
    And print response
  # And def expectedOutPut = projectPath+ 'src/test/java/responseBody/postRequestResponse.json'
  # And match response == expectedOutPut
    And match response == { "firstname": "Manasi", "lastname": "Patil", "totalprice": 100, "depositpaid": true, "bookingdates": { "checkin": "2024-01-06", "checkout": "2024-01-06" }, "additionalneeds": "Breakfast" }


  Scenario: PUT Request
    Given path '/booking/{bookingId}'
    And def bookingId = 1
    And header Content-type = "application/json"
    And request { "firstname": "Manasi", "lastname": "Patil", "totalprice": 200, "depositpaid": true, "bookingdates": { "checkin": "2024-01-06", "checkout": "2024-01-06" }, "additionalneeds": "mobile" }
    When method PUT
    Then status 200
    And print response
    And match response contains { "firstname": "Manasi", "lastname": "Patil", "totalprice": 200 }

  Scenario: PATCH Request
    Given path '/booking/{bookingId}'
    And def bookingId = 1
    And header Content-type = "application/json"
    And request { "firstname": "LTIMindtree" }
    When method PATCH
    Then status 200
    And print response
    And match response contains { "firstname": "LTIMindtree" }

  Scenario: DELETE Request
    Given path '/booking/{bookingId}'
    And def bookingId = 1
    And header Content-type = "application/json"
    When method DELETE
    Then status 201
