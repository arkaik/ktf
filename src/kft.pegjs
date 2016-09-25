File "file"
  = lm:(Metadata __)* lt:(Timestamp __)* End
  {
  	let r = {}
  	for (let m of lm) {
    	Object.assign(r,m[0])
    }

    let s = []
    for (let t of lt) {
    	s.push(t[0])
    }

    Object.assign(r, {'SONG':s})

    return r;
  }

Metadata "metadata"
  = '#' name:MAYUSTRING ':' value:STRING
  { return {[name]:value}; }

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
  = [ \t]*
  
__ "new line"
  = [\r\n]*
  {return null}
