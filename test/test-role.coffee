path = require("path")
assert = require("yeoman-generator").assert
helpers = require("yeoman-generator").test
os = require("os")
fs = require("fs")
readline = require("readline")

describe "ansible-generator:role", ->
	
	it "works with prompt", (done) ->
		name = "test-role"
		
		helpers.run(path.join(__dirname, "../generators/role"))
		.inDir(path.join(os.tmpdir(), "./test-dir"))
		.withPrompt({
			name: name
		})
		.on "end", ->
		
			fileLineCounts = {}
			fileLineCounts["roles/#{name}/tasks/main.yml"] = 17
			fileLineCounts["roles/#{name}/handlers/main.yml"] = 6
			fileLineCounts["roles/#{name}/templates/example.j2"] = 1
			fileLineCounts["roles/#{name}/files/example.txt"] = 1
			fileLineCounts["roles/#{name}/vars/main.yml"] = 4
			fileLineCounts["roles/#{name}/defaults/main.yml"] = 4
			fileLineCounts["roles/#{name}/meta/main.yml"] = 17

			for file, lineCount of fileLineCounts
				assert.file file
				contents = fs.readFileSync file, 'utf8'
				count = contents.split("\n").length
				assert.equal lineCount, count, "Expected #{file} to have #{lineCount} lines. (Had #{count})"

			readmeContents = fs.readFileSync "roles/#{name}/meta/main.yml", 'utf8'
			assert.notEqual -1, readmeContents.indexOf(name)
			
			done()
		true
	
	it "works with argument", (done) ->
		name = "test-playbook"
		
		helpers.run(path.join(__dirname, "../generators/role"))
		.inDir(path.join(os.tmpdir(), "./test-dir"))
		.withArguments([name])
		.on "end", ->
			
			fileLineCounts = {}
			fileLineCounts["roles/#{name}/tasks/main.yml"] = 17
			fileLineCounts["roles/#{name}/handlers/main.yml"] = 6
			fileLineCounts["roles/#{name}/templates/example.j2"] = 1
			fileLineCounts["roles/#{name}/files/example.txt"] = 1
			fileLineCounts["roles/#{name}/vars/main.yml"] = 4
			fileLineCounts["roles/#{name}/defaults/main.yml"] = 4
			fileLineCounts["roles/#{name}/meta/main.yml"] = 17

			for file, lineCount of fileLineCounts
				assert.file file
				contents = fs.readFileSync file, 'utf8'
				count = contents.split("\n").length
				assert.equal lineCount, count, "Expected #{file} to have #{lineCount} lines. (Had #{count})"

			readmeContents = fs.readFileSync "roles/#{name}/meta/main.yml", 'utf8'
			assert.notEqual -1, readmeContents.indexOf(name)
			
			done()
		true
	
	true