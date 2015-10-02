Provider = require './processing-autocomplete-provider'
{CompositeDisposable} = require 'atom'

module.exports = ProcessingAutocomplete =
  activate: (state) ->
    Provider.loadFunctions()
  provider: -> Provider
