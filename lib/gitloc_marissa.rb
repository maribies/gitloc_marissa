require 'tmpdir'
require 'open3'
require 'gitloc_marissa/version'
require 'gitloc_marissa/errors'

class GitlocMarissa
  def self.call(repo)
    Dir.mktmpdir do |dir|
      Dir.chdir dir do
        out, err, status = Open3.capture3 'git', 'clone', repo, 'cloned'

        raise RepoDoesNotExistError, repo unless status.success?

        Dir.chdir 'cloned'
        files = Dir['**/*'].reject { |name| File.directory? name }
        files.map do |file|
          count = File.readlines(file).count { |line| line !~ /^\s*$/ }
          [file, count]
        end
      end
    end
  end
end
