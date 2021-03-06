should     = require "should"
MassiveGit = new (require("../lib/massive.git").MassiveGit)()
helper     = require "./helper/helper"

describe "init repo", ->
  describe "with fake user", ->
    randomProjectName = "project" + Math.floor(1000000 * Math.random())
    username = "unique-fake-user-name" + Math.floor(1000000 * Math.random())
    it "should return 'User wasn't found' error", (done) ->
      MassiveGit.initRepo randomProjectName, username, "project", (err, repo) -> 
        err.should.have.property "message", "User wasn't found"
        err.should.have.property "statusCode", 400
        done()
  describe "with undefined repo name", ->
    username = "fake-user-name" + Math.floor(1000 * Math.random())
    it "should return 'Invalid parameters' error", (done) ->
      MassiveGit.initRepo undefined, username, "project", (err, repo) ->
        should.exist err
        err.should.have.property "message", "Invalid parameters"
        err.should.have.property "statusCode", 422
        should.not.exist repo
        done()
  describe "with null repo name", ->
    username = "fake-user-name" + Math.floor(1000 * Math.random())
    it "should return 'Invalid parameters' error", (done) ->
      MassiveGit.initRepo null, username, "project", (err, repo) ->
        should.exist err
        err.should.have.property "message", "Invalid parameters"
        err.should.have.property "statusCode", 422
        should.not.exist repo
        done()
  describe "with undefined user name", ->
    it "should return 'Invalid parameters' error", (done) ->
      MassiveGit.initRepo "repo1", undefined, "project", (err, repo) ->
        should.exist err
        err.should.have.property "message", "Invalid parameters"
        err.should.have.property "statusCode", 422
        should.not.exist repo
        done()
  describe "with null user name", ->
    it "should return 'Invalid parameters' error", (done) ->
      MassiveGit.initRepo "repo1", null, "project", (err, repo) ->
        should.exist err
        err.should.have.property "message", "Invalid parameters"
        err.should.have.property "statusCode", 422
        should.not.exist repo
        done()
  describe "with existent repo name", ->
    repoName = "project" + Math.floor(1000 * Math.random())
    username = "some-user-name" + Math.floor(1000 * Math.random())
    before (done) ->
      helper.createUserWithRepo username, repoName, "project", done
    it "should return 'Repo already exists' error", (done) ->
      MassiveGit.initRepo repoName, username, "project", (err, repo) ->
        should.exist err
        err.should.have.property "message", "Repo already exists"
        err.should.have.property "statusCode", 422
        should.not.exist repo
        done()
    after (done) ->
      helper.deleteUser username, done

		    


