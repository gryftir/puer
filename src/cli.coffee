sysPath = require "path"
puer = require "./index"
{Parser} = require "./helper"

pwd = process.cwd()

exports.run = (args) =>
  console.log(args)
  option = {}
  parser = new Parser()
  parser.on "-p --port <port>", "server's listen port, 8000 default", (port) ->
    option.port = parseInt(port) if port
  parser.on "-f --filetype <typelist>", "fileType to watch(split with '|'), default 'js|css|html|xhtml'", (typelist) ->
    option.filetype = typelist
  parser.on "-d --dir <dir>", "your customer working dir. default current dir ", (dir) ->
    option.dir = sysPath.resolve pwd, dir if dir
  parser.on "-i --inspect", "start weinre server and debug all puer page", (dir) ->
    option.inspect = true
  parser.on "-x --exclude", "exclude file under watching(must be a regexp), default: ''", (dir) ->
    ignored = reg.replace /^\/|\/$/g, ""
    option.ignored = new RegExp ignored
  parser.on "-a --addon <file>", "your addon's path", (file) ->
    option.addon = sysPath.resolve pwd, file
  parser.on "-t --target <target>", "proxy url", (file) ->
    option.proxy = file
  parser.on "--no-reload", "close  auto-reload feature,(not recommended)", () ->
    option.reload =false
  parser.on "--no-launch", "close the auto launch feature", () ->
    option.launch =false
  parser.on "-h --help", "help list" ,(haha)->  
    option.help = true
    man = """\n
      Usage:\tpuer [options...]\n
      Options:
      #{parser.output()}  
    """
    console.log man
  # 传入从命令行提取的
  parser.run args
  puer(option) if not option.help
  


