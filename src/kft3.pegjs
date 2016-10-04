File "file"
  = BOM lm:(Metadata __)* lt:(Timestamp __)* End __
  {
  	/*let r = []
  	for (let m of lm) {
    	r.push(m[0])
    }
    
    let res1 = r.join('\n')*/
    
    let s = []
    let line = ''
    for (let t of lt) {
    	let syl = t[0].lyric
        if (t[0].type != 'SILENCE') {
        
        	if (line !== '' && syl[0] !== ' ')
            	syl = '-' + syl
            
            line += syl
        }
    	else {
        	s.push(`${line}`)
            line = ''
        }
        
    }

	let res2 = s.join('\n')
    return res2;
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
