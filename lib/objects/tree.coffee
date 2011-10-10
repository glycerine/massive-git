_         = require "underscore"
GitObject = require("./git.object").GitObject

stringFromEntry = (name, id, type) ->
  # todo (anton) we can hardcode `mode` right now
  "644" + " " + type + " " + id + "\t" + name + "\n"

# Tree
# ---------
# Tree is one of the 4 core Git Objects. Tree stores `entries` which are links to blobs and other trees.
# todo (anton) store entities also as riak links????
class Tree extends GitObject

  # Constructor takes Tree entries and optionally `repo` id and tree's `id`.
  # Entry object has `name`, `id` and `type`.
  constructor: (entries, @repo = null, @_id = null) ->
    super "tree", @repo, @_id
    # Entries are ordered by name as in native Git implementation.
    @entries = _.sortBy entries, (entry) -> entry.name

  content: =>
    rows = ""
    rows += stringFromEntry entry.name, entry.id, entry.type for entry in @entries
    rows

  # Dao related methods.
  # ---------

  # Method for getting plain `attributes` of the GitObject.
  attributes: =>
    attributes = super()
    attributes.entries = @entries
    attributes

  # Method for getting `links` that connect this GitObject with another GitObjects, users or repositories.
  links: =>
    links = super()
    links

exports.Tree = Tree

