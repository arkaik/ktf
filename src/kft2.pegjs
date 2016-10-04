File "file"
  = BOM lm:(Metadata __)* lt:(Timestamp __)* End __
  {
  	let r = []
  	for (let m of lm) {
    	r.push(m[0])
    }
    
    let res1 = r.join('\n')

    let s = []
    for (let t of lt) {
    	let line = ''
        if (t.type != 'SILENCE') {
        	line += t.lyric
        }
    	else {
        	s += line
            line = []
        }
    }


    return res1+s;
  }

Metadata "metadata"
  = '#' name:MAYUSTRING ':' value:STRING
  { return `<p class='meta'>${name}: ${value}</p>`; }

Timestamp "timestamp"
  = pr:Prefix _ time:Integer b:(_ Integer _ Integer _ STRING)?
  {
  	let t = {'time':time}
    Object.assign(t, pr)

    if (b)
      Object.assign(t, {'length':b[1], 'pitch':b[3], 'lyric':b[5]})

  	return t
  }

Prefix "note prefix"
  = Normal
  / Silence
  / Gold
  / Free

Silence = '-' { return {'type': 'SILENCE'} }
Normal = ':' { return {'type': 'NORMAL'} }
Gold = '*' { return {'type': 'GOLD'} }
Free = '+' { return {'type': 'FREE'} }

End "end of file"
  = 'E'

Integer "integer"
  = '-'?[0-9]+ { return parseInt(text(), 10) }

MAYUSTRING "Capital string"
  = $[A-Z0-9]+

STRING "normal string"
  = $[^\r\n]*

_ "whitespace"
  = [ \t]

__ "new line"
  = [\r\n]*
  {return null}

BOM "byte order mark"
  = [\xEF]?
