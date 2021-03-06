should = require "should"
Repo   = require("../lib/objects/repo").Repo

describe "new Repo", ->
  describe "with regular parameters", ->
    repo = new Repo("project1", "anton", "project")
    it "should have correct properties", ->
      repo.id().should.equal "anton$project1"
      repo.should.have.property "type", "project"
      repo.should.have.property "author", "anton"
      repo.should.have.property "name", "project1"
      repo.public.should.be.ok
      should.not.exist repo.forkedFrom
      repo.attributes().should.have.property "type", "project"
      repo.attributes().public.should.be.ok
      repo.links().should.have.length(1)
      repo.getLink("author").should.equal "anton"
  describe "with private flag", ->
    repo = new Repo("project1", "anton", "project", false)
    it "should have correct properties", ->
      repo.id().should.equal "anton$project1"
      repo.should.have.property "type", "project"
      repo.should.have.property "author", "anton"
      repo.should.have.property "name", "project1"
      repo.public.should.be.not.ok
      should.not.exist repo.forkedFrom
  describe "forked from another repo", ->
    repo = new Repo("project1", "anton", "project", false, null, "andrew$project1")
    it "should have correct properties", ->
      repo.id().should.equal "anton$project1"
      repo.should.have.property "type", "project"
      repo.should.have.property "author", "anton"
      repo.should.have.property "name", "project1"
      repo.public.should.be.not.ok
      repo.should.have.property "forkedFrom", "andrew$project1"
      repo.links().should.have.length(2)
      repo.getLink("author").should.equal "anton"
      repo.getLink("forked_from").should.equal "andrew$project1"
  describe "created from another repo", ->
    repo = new Repo("project1", "anton", "project", false, "4ca68e7f293e0b7445beda64f0f8fe854682a0ac")
    it "should have correct properties", ->
      repo.id().should.equal "anton$project1"
      repo.should.have.property "type", "project"
      repo.should.have.property "author", "anton"
      repo.should.have.property "name", "project1"
      repo.public.should.be.not.ok
      repo.should.have.property "commit", "4ca68e7f293e0b7445beda64f0f8fe854682a0ac"
      repo.links().should.have.length(2)
      repo.getLink("author").should.equal "anton"
      repo.getLink("commit").should.equal "4ca68e7f293e0b7445beda64f0f8fe854682a0ac"

describe "forked repo", ->
  repo = new Repo("project1", "anton", "project", false, null, "andrew$project1")
  forked = repo.fork("new-project-name", "peter")
  it "should have same properties from original and forked field", ->
exports.testForkRepo = ->
    forked.id().should.equal "peter$new-project-name"
    forked.should.have.property "name", "new-project-name"
    forked.should.have.property "author", "peter"
    forked.public.should.be.not.ok
    should.not.exist forked.commit
    forked.should.have.property "forkedFrom", "anton$project1"

