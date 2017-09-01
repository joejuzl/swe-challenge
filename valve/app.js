const mqtt = require('mqtt');

const valve = document.getElementById('valve');
valve.innerHTML = 50;

const updateValve = (openness) => {
  valve.innerHTML = openness;
};

const receiveMessage = (_topic, message) => {
  const openness = JSON.parse(message.toString()).level;
  updateValve(openness)
};

const client  = mqtt.connect('ws://localhost:9001');

client.on('connect', ()=>{
  client.subscribe('actuators/room-1');
  client.on('message', receiveMessage)
});
