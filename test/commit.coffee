should = require "should"
assert = require "assert"
Commit = require("../lib/objects/commit").Commit

# test commit object
authoredDate = new Date().getTime()
commitedDate = new Date().getTime()
commit = new Commit("tree-id", "parent-id", "anton", authoredDate, "andrew", commitedDate, "initial commit", "anton$project1")


exports.testCommitProperties = ->
  commit.id().should.equal "4ca68e7f293e0b7445beda64f0f8fe854682a0ac"
  commit.should.have.property "type", "commit"
  commit.should.have.property "tree", "tree-id"
  commit.should.have.property "parent", "parent-id"
  commit.should.have.property "author", "anton"
  commit.should.have.property "authoredDate", authoredDate
  commit.should.have.property "committer", "andrew"
  commit.should.have.property "commitedDate", commitedDate
  commit.should.have.property "message", "initial commit"
  commit.should.have.property "repo", "anton$project1"
  commit.attributes().should.have.property "type", "commit"

exports.testCommitLinks = ->
  commit.links().should.have.lengthOf(5)
  # repo link
  repoLink = commit.links()[0]
  repoLink.should.have.property "bucket", "repositories"
  repoLink.should.have.property "key", "anton$project1"
  repoLink.should.have.property "tag", "repository"
  commit.getLink("repository").should.equal "anton$project1"
  # tree link
  treeLink = commit.links()[1]
  treeLink.should.have.property "bucket", "objects"
  treeLink.should.have.property "key", "tree-id"
  treeLink.should.have.property "tag", "tree"
  commit.getLink("tree").should.equal "tree-id"
  # parent link
  parentLink = commit.links()[2]
  parentLink.should.have.property "bucket", "objects"
  parentLink.should.have.property "key", "parent-id"
  parentLink.should.have.property "tag", "parent"
  commit.getLink("parent").should.equal "parent-id",
  # author link
  authorLink = commit.links()[3]
  authorLink.should.have.property "bucket", "users"
  authorLink.should.have.property "key", "anton"
  authorLink.should.have.property "tag", "author"
  commit.getLink("author").should.equal "anton"
  # committer link
  committerLink = commit.links()[4]
  committerLink.should.have.property "bucket", "users"
  committerLink.should.have.property "key", "andrew"
  committerLink.should.have.property "tag", "committer"
  commit.getLink("committer").should.equal "andrew"

