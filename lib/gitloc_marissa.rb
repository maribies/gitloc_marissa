require 'tmpdir'
require 'open3'
require 'gitloc_marissa/version'
require 'gitloc_marissa/errors'

class GitlocMarissa
  class LineCounts
    def self.call(files_and_bodies)
      files_and_bodies.map do |file, body|
        count = body.lines.count { |line| line !~ /^\s*$/ }
        [file, count]
      end
    end
  end


  def self.call(repo)
    files_and_bodies = Dir.mktmpdir do |dir|
      Dir.chdir dir do
        out, err, status = Open3.capture3 'git', 'clone', repo, 'cloned'

        raise RepoDoesNotExistError, repo unless status.success?

        Dir.chdir 'cloned'
        files = Dir['**/*'].reject { |name| File.directory? name }
        files.map do |file|
          body = File.read(file)
          [file, body]
        end
      end
    end
    LineCounts.call(files_and_bodies)
  end
end
