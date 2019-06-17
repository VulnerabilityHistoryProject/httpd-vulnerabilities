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
      f.end_with?('.c') ||
      f.end_with?('.h') ||
      f.end_with?('.cc') ||
      f.end_with?('.js') ||
      f.end_with?('.cpp') ||
      f.end_with?('.gyp') || 
      f.end_with?('.py') ||
      f.end_with?('.make') ||
      f.end_with?('.sh') ||
      f.end_with?('.S') ||
      f.end_with?('.scons') ||
      f.end_with?('.sb') ||
      f.end_with?('Makefile') ||
      f.end_with?('DEPS') ||
      f.end_with?('.java') ||
      f.end_with?('.dsp') ||
      f.end_with?('.m4')
    end
  end

end
