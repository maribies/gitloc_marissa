require 'gitloc_marissa'

class GitlocMarissa
  class Binary
    def self.call(argv, outstream, errstream)
      repo = argv.first
      files_and_counts = GitlocMarissa.call(repo)
      files_and_counts.each do |filename, loc|
        outstream.puts "#{loc}\t#{filename}"
      end
    end
  end
end
