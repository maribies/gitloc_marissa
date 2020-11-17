class GitlocMarissa
  class LineCounts
    def self.call(files_and_bodies)
      files_and_bodies.map do |file, body|
        count = body.lines.count { |line| line !~ /^\s*$/ }
        [file, count]
      end
    end
  end
end
