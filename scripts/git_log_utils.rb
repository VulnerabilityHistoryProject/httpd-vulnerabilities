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
      commit = @git.object(sha)
      diff = @git.diff(commit, commit.parent)
      files << diff.stats[:files].keys
      print '.'
    rescue => e
      errs << e.message
      print '?'
    end
    puts errs if errs.size > 0
    return files.flatten.uniq
  end

  def only_source_code(files)
    files.select do |f|
      f.ends_with?('.c') || f.ends_with?('.h')
    end
  end

end
