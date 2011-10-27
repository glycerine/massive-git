should     = require "should"
DbTestCase = require("./base/db.test.case").DbTestCase
MassiveGit = new (require("../lib/massive.git").MassiveGit)()
helper     = require "./helper/helper"

exports.testInitRepoForFakeUser = ->
  randomProjectName = "project" + Math.floor(1000 * Math.random())
  MassiveGit.initRepo randomProjectName, "fake-user-name", "project", (err, repo) ->
    should.exist err
    err.should.have.property "message", "User wasn't found"
    err.should.have.property "statusCode", 400
    should.not.exist repo

exports.testUndefinedRepoName = ->
  MassiveGit.initRepo undefined, "fake-user-name", "project", (err, repo) ->
    should.exist err
    err.should.have.property "message", "Invalid parameters"
    err.should.have.property "statusCode", 422
    should.not.exist repo

exports.testNullRepoName = ->
  MassiveGit.initRepo null, "fake-user-name", "project", (err, repo) ->
    should.exist err
    err.should.have.property "message", "Invalid parameters"
    err.should.have.property "statusCode", 422
    should.not.exist repo

exports.testUndefinedUserName = ->
  MassiveGit.initRepo "repo1", undefined, "project", (err, repo) ->
    should.exist err
    err.should.have.property "message", "Invalid parameters"
    err.should.have.property "statusCode", 422
    should.not.exist repo

exports.testNullUserName = ->
  MassiveGit.initRepo "repo1", null, "project", (err, repo) ->
    should.exist err
    err.should.have.property "message", "Invalid parameters"
    err.should.have.property "statusCode", 422
    should.not.exist repo

exports.testSaveRepoWithExistentName = (beforeExit)->
  randomProjectName = "project" + Math.floor(1000 * Math.random())
  # create another user with repo
  step1 = (callback) ->
    helper.createUserWithRepo "anton", randomProjectName, "project", callback
  # create repo with the duplicate name
  step2 = (repo, callback) ->
    MassiveGit.initRepo randomProjectName, "anton", "project", (err, repo) ->
      should.exist err
      err.should.have.property "message", "Repo already exists"
      err.should.have.property "statusCode", 422
      should.not.exist repo

  testCase = new DbTestCase [step1, step2]
  testCase.run()
  beforeExit () -> testCase.tearDown()
