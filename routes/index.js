var express = require('express');
var moment = require('moment');
var router = express.Router();
var db = require('connection');
var connection = db();
var bodyParser = require('body-parser');
var bunyan = require('bunyan');

var log = bunyan.createLogger({
    name: 'app',
    serializers: {
      req: bunyan.stdSerializers.req,
      res: bunyan.stdSerializers.res
    }
  });


// middleware specific to this router
router.use(function timeLog(req, res, next) {
  console.log('Time: ', Date.now());
  next();
});


/* GET home page. */
router.get('/', function(req, res, next) {
  	console.log('GET /' );
	connection.query('SELECT s.id as id, s.title as name, s.sensor_type_id, t.title as type, t.descr, t.img, d.id as device_id, d.name as device_name, d.img as device_img, u.id as user_id, u.name as user_name  FROM sensors.sensor s, sensor_type t, device d, user u WHERE d.user_id = u.id AND d.id = s.device_id AND s.sensor_type_id = t.id;', function (error, results, fields) {
		res.render('index', { title: 'Sensores disponíveis', descr: 'Listagem com os sensores disponíveis', results: results  });
	});
	

});

router.get('/characteristic/all', function(req, res, next){
	console.log('GET /characteristic/all' );
	connection.query('SELECT * FROM v_characteristic;', function (error, results, fields) {
	  //console.log(results);
	  //res.status(200).json({ results: results });
	  res.render('characteristic_all', { title: 'Sensores disponíveis', descr: 'Listagem com os ensores disponíveis', results: results  });
	});

});


router.get('/characteristic/:id', function(req, res, next){
	console.log('GET /characteristic/' + req.params.id);
	connection.query('SELECT * FROM v_sensor_values WHERE characteristic_id = ? LIMIT 25;', [req.params.id],function (error, results, fields) {
		var labels=[];
		var cols=[];
		var info = [];
		var lastMomentDay;
		for (var i = 0; i < results.length; i++) {
			var m = moment(results[i].moment);
			if(m.format('DD/M') == lastMomentDay){
				labels.push(m.format('HH:mm'));
			}else{
				labels.push(m.format('DD/M'));
			}
			cols.push(results[i].value);
			lastMomentDay = m.format('DD/M')
		}
		connection.query('SELECT * FROM v_characteristic WHERE id = ? ', [req.params.id],function (error, results, fields) {
			var data = {
				labels: labels,
				datasets: [
						{
							label: "My First dataset",
							fillColor: "rgba(220,220,220,0.2)",
							strokeColor: "rgba(220,220,220,1)",
							pointColor: "rgba(220,220,220,1)",
							pointStrokeColor: "#fff",
							pointHighlightFill: "#fff",
							pointHighlightStroke: "rgba(220,220,220,1)",
							data: cols
						},
					]
				};
				log.info({info: results[0]}, "Results")
				
				res.render('characteristic_id', { title: 'Informações do sensor', descr: 'Página com informações do sensor', info: results[0], data: data  });
		});

	});

});


router.get('/sensor/:id', function(req, res, next) {
	connection.query('SELECT * FROM v_characteristic WHERE sensor = ?;', [req.params.id], function (error, results, fields) {
	    var characteristics = results;
		connection.query('SELECT s.id as id, s.title as name, s.sensor_type_id, t.title as type, t.descr, t.img  FROM sensors.sensor s, sensor_type t WHERE s.sensor_type_id = t.id AND s.id = ?;', [req.params.id], function (error, info, fields) {
			console.log({'info': info});
			console.log({'characteristics':characteristics});
			res.render('characteristic', { title: 'Características do sensor escolhido', characteristics: characteristics, info: info[0]});
		});

	});

});

router.get('/sensor/type/:id', function(req, res, next) {
	connection.query('SELECT * FROM v_characteristic WHERE sensor_type_id = ?;', [req.params.id], function (error, results, fields) {
	  console.log(results);
	  //res.status(200).json({ results: results });
	  res.render('dump', { title: 'Características para o sensor escolhido', results: results  });
	});

});

router.get('/unity/:id', function(req, res, next) {
  	console.log('GET /unity/' + req.params.id);
	connection.query('SELECT * FROM v_characteristic WHERE unity_id = ?;', [req.params.id], function (error, results, fields) {
	  console.log(results);
	  //res.status(200).json({ results: results });
	  res.render('dump', { title: 'Características com a unidade de medida escolhida', results: results  });
	});

});

router.get('/contact', function(req, res, next) {

	  res.render('contact');


});

router.get('/about', function(req, res, next) {

	  res.render('about');


});





module.exports = router;
