GitObject = require("./git.object").GitObject

# todo (anton) author and commiter should also store date.
class Commit extends GitObject

  constructor: (@tree, @parent, @author, @committer, @message, @repo = null) ->
    super "commit", @repo

  content: =>
    parentToken = ""
    parentToken += "parent" + char for char in @parent
    "tree " + @tree + "\n" + parentToken + "author " + @author + "\ncommitter " + @committer + "\n\n" + @message

  # Dao related methods. Code is too riak-specific. Can be refactored later.
  # ---------

  # Method for getting plain `attributes` of the GitObject.
  attributes: =>
    attributes = super()
    attributes.message = @message
    attributes

  # Method for getting `links` that connect this GitObject with another GitObjects, users or repositories.
  links: =>
    links = super()
    tree      = { bucket : "objects", key : @tree, tag : "tree"}
    parent    = { bucket : "objects", key : @parent, tag : "parent"}
    author    = { bucket : "users", key : @author, tag : "author"}
    committer = { bucket : "users", key : @committer, tag : "committer"}
    links.push tree
    links.push parent
    links.push author
    links.push committer
    links

exports.Commit = Commit
