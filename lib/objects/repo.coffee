Entity = require("riak-entity").Entity

# Repo
# ---------
# Class representing repository.
# `id` - unique repository id. Id calculated from `owner`, `type` and `name` of the repository.
# `author` - repository's author.
# `type` - type of the repository. Meta information.
# `public` - flag that indicated whether repo is public or private. Default to `true`.
# `commit` - last commit for this repository. Can be `null` if repository wasn't commited previously.
# `forkedFrom` - id of the repository from which this was cloned. Default to `null`.
Repo = exports.Repo = class Repo extends Entity

  constructor: (@name, @author, @type, @public = true, @commit, @forkedFrom = null) ->

  id: => @author + "$" + @name

  # Create `forked` copy of the repo.
  fork: (name, author) => new Repo(name, author, @type, @public, @commit, @id())

  # Dao related methods.
  # ---------

  # Method for getting plain `attributes` of the GitObject.
  attributes: =>
    name  : @name
    type  : @type
    public: @public

  # Method for getting `index`es of the GitObject.
  index: =>
    author: @author
    type  : @type
    public: @public

  # Method for getting `links` that connect this GitObject with other Git Objects, users or repositories.
  links: =>
    links = []
    links.push @buildLink "users", @author, "author"
    links.push @buildLink "repositories", @forkedFrom, "forked_from" if @forkedFrom
    links.push @buildLink "objects", @commit, "commit" if @commit
    links

