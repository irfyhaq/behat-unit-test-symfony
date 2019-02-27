# features/product.feature

Feature: Provide a consistent standard JSON API endpoint

  In order to build interchangeable front ends
  As a JSON API developer
  I need to allow Create, Read, Update, and Delete functionality

  Background:
    Given there are Products with the following details:
      | name                   | category     | sku        | price  | quantity     |created_at                | modified_at               |
      | Pong                   | Games        | A0001      | 69.99  | 20           |2020-01-08T00:00:00+00:00 | 2020-01-08T00:00:00+00:00 |
      | Gas Station 5          | Games        | A0002      | 269.99 | 15           |2019-01-07T23:22:21+00:00 | 2020-01-08T00:00:00+00:00 |
      | Oman PC - Aluminium    | Computers    | A0003      | 1399.99| 10           |2018-02-06T11:10:09+00:00 | 2020-01-08T00:00:00+00:00 |

  Scenario: Can get a single Product
    Given I request "/product/1" using HTTP GET
    Then the response code is 200
    And the response body contains JSON:
    """
    {
      "id": 1,
      "name": "Pong",
      "category": "Games",
      "sku": "A0001",
      "price": "69.99",
      "quantity": 20
    }
    """

  Scenario: Can get a collection of Products
    Given I request "/product" using HTTP GET
    Then the response code is 200
    And the response body contains JSON:
    """
    [
      {
        "id": 1,
        "name": "Pong",
        "category": "Games",
        "sku": "A0001",
        "price": "69.99",
        "quantity": 20
      },
      {
        "id": 2,
        "name": "Gas Station 5",
        "category": "Games",
        "sku": "A0002",
        "price": "269.99",
        "quantity": 15
      },
      {
        "id": 3,
        "name": "Oman PC - Aluminium",
        "category": "Computers",
        "sku": "A0003",
        "price": "1399.99",
        "quantity": 10
      }
    ]
    """
  Scenario: Can add a new Product
    Given the request body is:
      """
      {
        "name": "Fony UHD HDR 55 4k TV",
        "category": "TVs and Accessories",
        "sku": "A0004",
        "price": 1499.99,
        "quantity": 5
      }
      """
    When I request "/product" using HTTP POST
    Then the response code is 201

  Scenario: Can update an existing Product - PUT
    Given the request body is:
      """
      {
        "name": "AP Oman PC- Aluminium",
        "category": "Games",
        "sku": "A0003",
        "price": 1399.99,
        "quantity": 10
      }
      """
    When I request "/product/3" using HTTP PUT
    Then the response code is 204

  Scenario: Can update an existing Product - PATCH
    Given the request body is:
      """
      {
        "quantity": 23
      }
      """
    When I request "/product/2" using HTTP PATCH
    Then the response code is 204

  Scenario: Can delete a Product
    Given I request "/product/3" using HTTP GET
    Then the response code is 200
    When I request "/product/3" using HTTP DELETE
    Then the response code is 204
    When I request "/product/3" using HTTP GET
    Then the response code is 404


