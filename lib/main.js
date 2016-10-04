const parserData = require('./parser.js')
const parserHtml = require('./parserHtml.js')
const parserText = require('./parserTextSolo.js');

module.exports = { parse }

function parse (opt = 'DATA') {
  if (opt === 'DATA') parserData.parse()
  else if (opt === 'HTML') parserHtml.parse()
  else if (opt === 'TEXT') parserText.parse()
}
