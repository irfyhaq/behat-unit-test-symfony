# Behat Unit Test for Symfony4 based REST API
Behat Unit test for the Symfony4 REST project

## Introduction
Behat is a BDD framework for PHP to help you test business expectations.<br/>
This Behat Unit Test relies on own pre-set data to execute the tests. All the unit tests are defined in the scenario. Quite similar to Kahlan, it is also Behaviour-Driven Development framework for PHP.

<b><i></i>The Main Project repository is at: </b>
<url>https://github.com/irfyhaq/symfony4-fos-catalog-api</url> 

## Files
<ul>
<li><b>StatusCheck.feature</b> : Just to see server is up and running</li>
<li><b>Product.feature</b> : Individually tests all the end-points.</li>
</ul>

## Installation
<small>Start with downloading all the dependencies of the project by running.</small><br/>
<code>php composer.phar install
</code><br/><br/>

<small>Commented Both Volumes <code>docker-compose.yml</code> file definition.</small></br><br/>
<small>created <code>Makefile</code> to ease up the docker run and down commands. This could be implemented by:</small><br/>

<code>make dev</code><br/>
<code>make down</code><br/>

<p>The content of the file is:</p>

      dev:
          @docker-compose down && \
              docker-compose build --pull --no-cache && \
              docker-compose \
                  -f docker-compose.yml \
              up -d --remove-orphans
      
      down:
          @docker-compose down
          

 
<small> For unit test either individually or as a whole, run </small><br/>
<code>vendor/bin/behat features/product.feature</code><br/><br/>

<small>Or you can run the individual tests by adding tags in the feature file like</small><br/>
```bash
@tagName
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
```

<small>and then run it like this:</small><br/>
<code>vendor/bin/behat features/product.feature --tags=tagName</code>

##TODO
<ul>
<li>Connect to Database to retrieve data from dev DB</li>
<li>Better Error handling</li>
</ul>

## License
[MIT](https://choosealicense.com/licenses/mit/)