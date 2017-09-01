const mqtt = require('mqtt');

const randomId = () => Math.random().toString(16).substr(2, 8);

const sensorList = document.getElementById('sensorList');
const addSensorButton = document.getElementById('addSensor');

const createSensor = (func) => {
  const sensorId = randomId();
  const sensor = document.createElement("div");
  sensor.classList.add('sensor');
  sensor.innerHTML += '<p><span>SensorID: ' + sensorId + '</span></p>';

  const input = document.createElement("input");
  input.id = sensorId + "_input";
  sensor.appendChild(input);

  const button = document.createElement("input");
  button.type = "submit";
  button.classList.add('sensor-btn', 'btn','btn-info');
  button.id = sensorId + "_button";
  button.value = 'send';
  button.onclick = func(sensorId);
  sensor.appendChild(button);

  sensorList.appendChild(sensor);

};

const publishTemperature = (sensorId) => () => {
  const input = document.getElementById(sensorId + "_input");
  const payload = JSON.stringify({
    sensorID: sensorId,
    type: "temperature",
    value: input.value
  });
  client.publish('readings/temperature', payload);
  input.value = '';
};

const client  = mqtt.connect('ws://localhost:9001');

client.on('connect', ()=>{
  addSensorButton.disabled = false;
});

addSensorButton.onclick = () => createSensor(publishTemperature);
