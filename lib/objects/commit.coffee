GitObject = require("./git.object").GitObject

Commit = exports.Commit = class Commit extends GitObject

  # Constructor takes mandatory `Commit` properties and optionally `repo` id and commit's `id`.
  constructor: (@tree, @parent, @author, @authorEmail, @authoredDate, @committer, @committerEmail, @commitedDate, @message, @repo = null, @_id = null) ->
    super "commit", @repo, @_id

  # todo (anton) author and commiter here should keep authored and commited date. Only in this way sha will be Git compatible
  content: =>
    parentToken = ""
    parentToken += "parent" + char for char in @parent if @parent # todo (anton) check what to do if parent is null. In case of first commit
    "tree " + @tree + "\n" + parentToken + "author " + @author + "<" + @authorEmail + ">" + "\ncommitter " + @committer + "<" + @committerEmail + ">" + "\n\n" + @message

  # Dao related methods.
  # ---------

  # Method for getting plain `attributes` of the GitObject.
  attributes: =>
    attributes = super()
    attributes.message = @message
    attributes.authorEmail = @authorEmail
    attributes.committerEmail = @committerEmail
    attributes.authoredDate = @authoredDate
    attributes.commitedDate = @commitedDate
    attributes

  # Method for getting `links` that connect this GitObject with another GitObjects, users or repositories.
  links: =>
    links = super()
    links.push @buildLink "objects", @tree, "tree"
    links.push @buildLink "objects", @parent, "parent" if @parent
    links.push @buildLink "users", @author, "author"
    links.push @buildLink "users", @committer, "committer"
    links

