ktf = require('ktf')
fs = require('fs');

var file = fs.readFile('Greta Salome - Hear them calling.ktf', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  console.log(data);
});

ktf.parse(file)
