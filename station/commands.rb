aliases = {
  'g' => 'generate'
}

command = ARGV.shift
command = aliases[command] || command
Station::Command.invoke command, ARGV
