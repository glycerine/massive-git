should    = require "should"
Blob      = require("../lib/objects/blob").Blob
Tree      = require("../lib/objects/tree").Tree
TreeEntry = require("../lib/objects/tree.entry").TreeEntry

describe "new Tree", ->
  describe "with plain structure", ->
    blob1 = new Blob("test-content", "anton$project1")
    blob2 = new Blob("1111", "anton-project1")
    entries = []
    entries.push new TreeEntry("symbol.json", blob2).attributes()
    entries.push new TreeEntry("datasheet.json", blob1).attributes()
    tree = new Tree(entries, "anton$project1")
    it "should have correct properties", ->
      tree.id().should.equal "7a8b327d8ec3e00838b350a59887c4ae6c183928"
      tree.entries.should.have.length 2
      tree.entries.should.equal tree.attributes().entries
  describe "with hierarchical structure", ->
    blob1 = new Blob("test-content", "anton$project1")
    blob2 = new Blob("1111", "anton-project1")
    subtreeEntries = []
    subtreeEntries.push new TreeEntry("symbol.json", blob2).attributes()
    subtree = new Tree(subtreeEntries, "anton-project1")
    subtree.id().should.equal "b1c610ed5d646a401e710d3a110d04431cfd231e"
    subtree.entries.should.have.length 1
    entries = []
    entries.push new TreeEntry("datasheet.json", blob1).attributes()
    entries.push new TreeEntry("js", subtree).attributes()
    tree = new Tree(entries, "anton$project1")
    it "should have correct properties", ->
      tree.id().should.equal "260f756862c7fc027f275aaec07ba4fa2139b0e9"
      tree.entries.should.have.length 2
      tree.entries.should.equal tree.attributes().entries

