util = require 'util'
path = require 'path'
generators = require 'yeoman-generator'
handlebars = require 'handlebars'

module.exports = class AnsibleGenerator extends generators.NamedBase

	constructor: (args, options, config) ->
		generators.Base.apply(@, arguments)
		@name = @args[0]

	askFor: ->
		cb = @async()
		
		prompts = []
		unless @name?
			prompts.push
				name: 'name'
				message: "What's the role named?"

		if prompts.length
			@prompt(prompts, (props) =>
				@name = props.name
				cb()
			)
		else
			cb()

	createPlaybook: ->
		# TODO: handle @name == '.' ?
		@roleDir = "roles/#{@name}"
		@mkdir @roleDir
				
		# Tasks
		@mkdir "#{@roleDir}/tasks"
		template = handlebars.compile(@src.read('tasks-main.yml.handlebars'))
		@write "#{@roleDir}/tasks/main.yml", template({name: @name})
		
		# Handlers
		@mkdir "#{@roleDir}/handlers"
		template = handlebars.compile(@src.read('handlers-main.yml.handlebars'))
		@write "#{@roleDir}/handlers/main.yml", template({name: @name})
		
		# Templates
		@mkdir "#{@roleDir}/templates"
		template = handlebars.compile(@src.read('templates-example.j2.handlebars'))
		@write "#{@roleDir}/templates/example.j2", template({name: @name})
		
		# Files
		@mkdir "#{@roleDir}/files"
		template = handlebars.compile(@src.read('files-example.txt.handlebars'))
		@write "#{@roleDir}/files/example.txt", template({name: @name})
		
		# Vars
		@mkdir "#{@roleDir}/vars"
		template = handlebars.compile(@src.read('vars-main.yml.handlebars'))
		@write "#{@roleDir}/vars/main.yml", template({name: @name})
		
		# Defaults
		@mkdir "#{@roleDir}/defaults"
		template = handlebars.compile(@src.read('defaults-main.yml.handlebars'))
		@write "#{@roleDir}/defaults/main.yml", template({name: @name})
		
		# Meta
		@mkdir "#{@roleDir}/meta"
		template = handlebars.compile(@src.read('meta-main.yml.handlebars'))
		@write "#{@roleDir}/meta/main.yml", template({name: @name})
		
		true