require 'tmpdir'
require 'open3'
require 'gitloc_marissa/version'

class GitlocMarissa
  def self.call(repo)
    Dir.mktmpdir do |dir|
      Dir.chdir dir
      out, err, status = Open3.capture3 'git', 'clone', repo, 'cloned'
      unless status.success?
        errstream.puts out, err
        exit "Failed somehow >.<"
      end
      Dir.chdir 'cloned'
      files = Dir['**/*'].reject { |name| File.directory? name }
      files.map do |file|
        count = File.readlines(file).count { |line| line !~ /^\s*$/ }
        [file, count]
      end
    end
  end
end
