const parserData = require('./parser.js')
const parserHtml = require('./parserHtml.js')
const parserText = require('./parserTextSolo.js');

module.exports = { parse }

function parse (file, opt = 'DATA') {
  if (opt === 'DATA') return parserData.parse(file)
  else if (opt === 'HTML') return parserHtml.parse(file)
  else if (opt === 'TEXT') return parserText.parse(file)
  else console.error('Something is wrong');
}
