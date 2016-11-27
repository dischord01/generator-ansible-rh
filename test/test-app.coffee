path = require("path")
assert = require("yeoman-generator").assert
helpers = require("yeoman-generator").test
os = require("os")
fs = require("fs")
readline = require("readline")

describe "ansible-generator:app", ->
	
	it "works with prompt", (done) ->
		name = "test-playbook"
		
		helpers.run(path.join(__dirname, "../generators/app"))
		.inDir(path.join(os.tmpdir(), "./test-dir"))
		.withPrompt({
			name: name
		})
		.on "end", ->
		
			fileLineCounts = {}
			fileLineCounts["#{name}/production"] = 39
			fileLineCounts["#{name}/stage"] = 39
			fileLineCounts["#{name}/group_vars/example"] = 4
			fileLineCounts["#{name}/host_vars/example"] = 4
			fileLineCounts["#{name}/site.yml"] = 3
			fileLineCounts["#{name}/roles/.gitkeep"] = 1
			fileLineCounts["#{name}/README.md"] = 13
			fileLineCounts["#{name}/Ansiblefile"] = 4

			for file, lineCount of fileLineCounts
				assert.file file
				contents = fs.readFileSync file, 'utf8'
				count = contents.split("\n").length
				assert.equal lineCount, count, "Expected #{file} to have #{lineCount} lines. (Had #{count})"

			readmeContents = fs.readFileSync "#{name}/README.md", 'utf8'
			assert.notEqual -1, readmeContents.indexOf(name)

			assert.noFile [
				"#{name}/Vagrantfile"
			]
			
			done()
		true
	
	it "works with argument", (done) ->
		name = "test-playbook"
		
		helpers.run(path.join(__dirname, "../generators/app"))
		.inDir(path.join(os.tmpdir(), "./test-dir"))
		.withArguments([name])
		.on "end", ->
			
			fileLineCounts = {}
			fileLineCounts["#{name}/production"] = 39
			fileLineCounts["#{name}/stage"] = 39
			fileLineCounts["#{name}/group_vars/example"] = 4
			fileLineCounts["#{name}/host_vars/example"] = 4
			fileLineCounts["#{name}/site.yml"] = 3
			fileLineCounts["#{name}/roles/.gitkeep"] = 1
			fileLineCounts["#{name}/README.md"] = 13
			fileLineCounts["#{name}/Ansiblefile"] = 4

			for file, lineCount of fileLineCounts
				assert.file file
				contents = fs.readFileSync file, 'utf8'
				count = contents.split("\n").length
				assert.equal lineCount, count, "Expected #{file} to have #{lineCount} lines. (Had #{count})"

			readmeContents = fs.readFileSync "#{name}/README.md", 'utf8'
			assert.notEqual -1, readmeContents.indexOf(name)

			assert.noFile [
				"#{name}/Vagrantfile"
			]
			
			done()
		true
	
	it "works with vagrant", (done) ->
		name = "test-playbook"
		
		helpers.run(path.join(__dirname, "../generators/app"))
		.inDir(path.join(os.tmpdir(), "./test-dir"))
		.withArguments([name])
		.withOptions({ "vagrant": true })
		.on "end", ->
		
			fileLineCounts = {}
			fileLineCounts["#{name}/production"] = 39
			fileLineCounts["#{name}/stage"] = 39
			fileLineCounts["#{name}/group_vars/example"] = 4
			fileLineCounts["#{name}/host_vars/example"] = 4
			fileLineCounts["#{name}/site.yml"] = 3
			fileLineCounts["#{name}/roles/.gitkeep"] = 1
			fileLineCounts["#{name}/README.md"] = 13
			fileLineCounts["#{name}/Ansiblefile"] = 4
			fileLineCounts["#{name}/Vagrantfile"] = 29
			fileLineCounts["#{name}/development"] = 10

			for file, lineCount of fileLineCounts
				assert.file file
				contents = fs.readFileSync file, 'utf8'
				count = contents.split("\n").length
				assert.equal lineCount, count, "Expected #{file} to have #{lineCount} lines. (Had #{count})"
			
			readmeContents = fs.readFileSync "#{name}/README.md", 'utf8'
			assert.notEqual -1, readmeContents.indexOf(name)
			
			done()
		true
	
	true