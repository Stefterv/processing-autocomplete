fuse = require("./fuse.js")
module.exports =
  selector: '.source.processing'

  funcs: []

  loadFunctions: ->
    functions = require("../reference/functions.json")
    for funcname,properties of functions
      func = {}
      func.text = funcname
      func.snippet = funcname+"("
      for property,i in properties
        if(i>0)
          func.snippet += ","
        func.snippet += "${"+(i+1)+":"+property+"}"
      func.type = "function"
      func.snippet+=")"
      @funcs.push(func)
    classes = require("../reference/classes.json")
    for classname,classfunctions of classes
      cls = {}
      cls.text = classname
      cls.type = "class"
      @funcs.push(cls)
      for funcname,properties of classfunctions
        func = {}
        func.text = funcname
        func.snippet = funcname+"("
        func.leftLabel = classname+"."
        for property,i in properties
          if(i>0)
            func.snippet += ","
          func.snippet += "${"+(i+1)+":"+property+"}"
        func.type = "function"
        func.snippet+=")"
        @funcs.push(func)



  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    options = {
      keys: ['text'],
      threshold: 0.25
    }
    f = new fuse(@funcs, options)
    completions = f.search(prefix)
    for func in completions
      func.replacementPrefix = prefix
    completions
