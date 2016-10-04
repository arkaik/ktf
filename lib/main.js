const parserData = require('./parser.js')
const parserHtml = require('./parserHtml.js')
const parserText = require('./parserTextSolo.js');

module.exports = { parse }

function parse (file, opt = 'DATA') {
  if (opt === 'DATA') parserData.parse(file)
  else if (opt === 'HTML') parserHtml.parse(file)
  else if (opt === 'TEXT') parserText.parse(file)
}
