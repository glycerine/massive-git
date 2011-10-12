utils = require "./utils"

# GitEntity
# -----------
# Base abstract class for each git entity: user, repository, git objects (blobs, commits, trees, tags).
# Each entity has `id`, `attributes` and `links` to other `entities`.
class GitEntity

  # Id of the entity.
  id: =>
    @_id

  # Dao related methods.
  # ---------

  # Method for getting plain `attributes` of the GitObject.
  attributes: =>
    throw new Error("Should be implemented in every subclass!")

  # Method for getting `links` that connect this GitEntity with git objects, users or repositories.
  links: =>
    []

  # Serialize entity to `JSON`.
  toJSON: =>
    json = @attributes()
    json.id = @id()
    json

  # Method for finding appropriate link `key` by `tag` name.
  getLink: (tagName) =>
    utils.getLink @links(), tagName

  # Method for finding all appropriate links `key` by `tag` name.
  getLinks: (tagName) =>
    utils.getLinks @links(), tagName

  # Method for building link.
  buildLink: (bucket, key, tag) => utils.buildLink bucket, key, tag

exports.GitEntity = GitEntity

