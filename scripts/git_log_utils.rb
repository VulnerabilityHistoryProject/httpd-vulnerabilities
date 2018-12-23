require 'git'
require_relative 'script_helpers'

class GitLogUtils

  def initialize(repo)
    @git = Git.open(repo)
  end

  def get_files_from_shas(fixes)
    files = []
    errs = []
    fixes.each do |sha|
      begin
        commit = @git.object(sha)
        diff = @git.diff(commit, commit.parent)
        files << diff.stats[:files].keys
        print '.'
      rescue => e
        errs << e.message
        print '?'
      end
    end
    return files.flatten.uniq
  end

end
