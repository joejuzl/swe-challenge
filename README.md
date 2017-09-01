# Snuk Challenge
https://github.com/WATTx/code-challenges/blob/master/swe-challenge.md

## Requirements:
- docker

## To Run:
First build the docker images by running:
	
	./build
	
Then start the docker containers by running:
	
	./start
		
## To Use:
### Sensors:
- Visit localhost:3000 in your browser.
- Click "Add sensor" to add a new sensor.
- Put a number in the text input and click "send" to send a reading.

### Valve:
- Visit localhost:3001 in your browser.
- Watch as the "openness" of the valve is changed in reaction to sensor readings.


# Explaination

## The Problem
To prototype a simple heating control service.
It must be able to read temperature readings from a mqtt queue and publish commands to a radiator valve.

## My solution.

### Technologies

#### Controller

I decided to write the controller in Ruby.
Ruby is definitely not the best language to write an actual temperature controller as:
- It is relatively slow.
- There are not many libraries written for this domain.
- It requires a heavy weight interpreter, not ideal for embedded systems. 
- It has a global interpreter lock restricting efficient use of threads.

However, it is the language I am most familiar with!

#### Sensors

I also decided to make simple web app simulators of the sensors and valve.
I thought this would make it easier to see the controller in action.
It also allowed me to work with different services all connecting to the same message broker.

I wrote them using pure javascript.

#### Deployment

I decided to use docker and docker-compose.
This means that (in theory) any machine with docker running on it will be able to run the services without any other requirements.

### Design

I created an abstract valve controller class that contained the common logic for parsing a message and forming a response.
I then created two subclasses that implemented different algorithms for regulating the temperature.
This means that different methods of temperature regulation can be swapped in and out with ease.

#### Bang Bang Controller

Extremely simple algorithm. If the temperature is too high, turn the radiator to full. 
If it is too low, turn it off completely.

#### Proportional Controller

Also simple, but able to vary the valve proportionally to how far the temperature is from the desired temperature.

## What I would do differently...

- I would use a language more suited to the problem at hand e.g. Go.
- I would use a javascript framework for the web apps e.g. React.
- I would have used encryption to send the message through the broker.
- I would write more tests, covering backend code, front end code, and deployment scripts.
- I would use environment variable to configure the app for different environments i.e development and production.
- I would store state, and record statistics from the services.
- I would have eliminated any duplicate code e.g. the web service Dockerfiles.
