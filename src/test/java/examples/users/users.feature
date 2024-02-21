Feature:  Testing Restful Booker API

  Background:
    * url 'https://restful-booker.herokuapp.com'

  Scenario: GET Booking IDs Request
    Given path '/booking/{bookingId}'
    And def bookingId = 1
    When method GET
    Then status 200
    And print response