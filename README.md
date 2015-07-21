# SensorsServerAndFront
Server and Frontend for Aduino sensors app written in node.js

https://github.com/jricardosimoes/ArduinoSensorsWebClient

Server side
-----------
In the folder run the command for install the dependencies:
```bash
npm install
```

Change the line with the variable apiKey  in the file server.js.
```bash
var apiKey = "YouRKeyHere";
```

If you wish to change the port where the server listens (3000 by default) edit the last line of server.js.
```bash
app.listen(3000);
```

A mysql database must be created with the schemas found in the file /SQL/Structure.sql.

Demos from data are in the file /SQL/DemoData.sql.

The mysql dabase configuration is at /node_modules/connection/index.js

This config is used by both server and frontend.

Run the server with
```bash
node server.js
```

Or, as recommended, with pm2:
```bash
npm install pm2 -g
pm2 start server.js --name="sensors_back" --watch
```

More info about pm2 at https://github.com/Unitech/PM2/blob/master/ADVANCED_README.md

Done. 

Frontend side
-------------

The web frontend is straigth forward. Just check the mysql dabase configuration at \node_modules\connection\index.js, change the port (last line, default is 8080)

Run with
```bash
node app.js
```

Or, as recommended, with pm2:
```bash
pm2 start app.js --name="sensors_front" --watch
```

Point you browser to http://server:8080/



*Frontend
![Frontend](https://github.com/jricardosimoes/SensorsServerAndFront/blob/master/Screenshots/Screenshot_2015-07-21-15-18-03.png)

* Humidity Graph
![Humidity Graph](https://github.com/jricardosimoes/SensorsServerAndFront/blob/master/Screenshots/Screenshot_2015-07-21-15-23-34.png)

* Temperature Graph
![Temperature Graph](https://github.com/jricardosimoes/SensorsServerAndFront/blob/master/Screenshots/Screenshot_2015-07-21-15-22-45.png)

* Pressure Graph
![Pressure Graph](https://github.com/jricardosimoes/SensorsServerAndFront/blob/master/Screenshots/Screenshot_2015-07-21-15-23-08.png)




