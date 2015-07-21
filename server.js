var express    = require('express');
var bodyParser = require('body-parser');
var mysql      = require('mysql');
var bunyan = require('bunyan');
var moment = require('moment');
var db = require('connection');
var connection = db();

var apiKey = "32gss64XZab";
var app = express();
app.use(bodyParser.json()); 
app.use(bodyParser.urlencoded({ extended: true }));

function isInt(n) 
{
    return n != "" && !isNaN(n) && Math.round(n) == n;
}

app.post('/api/sensor', function(req, res){
	//Check ApiKey
	if(apiKey  == req.body.key){
		var m = moment();
		var data = req.body.data;
		var pairs = data.split(";");
		console.log(req.body.data);
		for (var i = 0; i < pairs.length; i++) {
			var pair = pairs[i].split(":");
			//Just basic checking for key as integers and values as not empty strings
			if(isInt(pair[0]) && (pair[1].length >0)){
				connection.query('INSERT INTO sensor_value SET ?', {sensor_characteristic_id: pair[0], value:pair[1]}, function(err, result) {
					if (err) throw err;
					console.log(result.insertId);
				});
			}else{
				res.status(501).send("Invalid Key=>value. " + req.body.key + ', moment:' + m.format()  + ', data:'+ req.body.data);
			}
		}
		res.status(200).send('POST /api/sensor key:' + req.body.key + ', moment:' + m.format()  + ', data:'+ req.body.data);
	}else{
		res.status(401).send("Unauthorized");
	}
});




app.listen(3000);
