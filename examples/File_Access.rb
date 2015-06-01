require 'celluloid'
require 'pry'

class File_Access
	include Celluloid

	def open_file (aFile, bFile)
		aFile.lock_file
	end

	def lock_file
		@f1 = File.open('/Users/dilum/Desktop/input.txt', File::RDWR|File::CREAT, 0644)
		@f1.flock(File::LOCK_EX)
		@f1.close
	end
end

a = File_Access.new
b = File_Access.new

a.async.open_file(a,b)
a.open_file(b,a)

a.lock_file