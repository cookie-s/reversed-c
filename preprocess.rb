require_relative 'table.rb'

fn = nil
check = true

arg1 = ARGV.shift

if arg1 == '--skip-check'
  check = false
  fn = ARGV.shift
else
  fn = arg1
end

if fn.nil?
  warn 'Please specify source file path.'
  exit 1
end

unless not check or fn.end_with? 'rev-c'
  warn 'Is this %s correct reversed-c source file?' % fn
  warn 'Use file extension ".rev-c".'
  exit 1
end

pre = File.binread(fn)
body = pre.unpack("U*").map{|x| TABLE[x] || x}.pack("U*").reverse
File.binwrite '%s.c' % fn.chomp('.rev-c'), body
