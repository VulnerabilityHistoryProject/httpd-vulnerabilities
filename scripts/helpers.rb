def cve_yaml_exists?(cve)
  File.exists? as_filename(cve)
end

def as_filename(cve)
  File.expand_path('../cves/', __dir__) + '/' + cve + ".yml"
end

# Return the text of the CVE skeleton
def cve_skeleton_yml
  File.read(File.expand_path('../skeletons/cve.yml', __dir__))
end

def repo_dir
  File.expand_path('../tmp/src', __dir__)
end

def fix_skeleton
  <<~EOS
    fixes:
       - commit:
         note:
       - commit:
         note:
  EOS
end

# Replace text in an entire file
def replace_in_file(file, pattern, replacement)
  str = File.read(file)
  str.gsub!(pattern, replacement)
  File.open(file, "w") { |f| f.write(str) }
end

def keep_only_source_code(files)
  files.select do |f|
    f.end_with?('.c') ||
    f.end_with?('.cc') ||
    f.end_with?('.cpp') ||
    f.end_with?('.dsp') ||
    f.end_with?('.gyp') ||
    f.end_with?('.h') ||
    f.end_with?('.java') ||
    f.end_with?('.js') ||
    f.end_with?('.m4') ||
    f.end_with?('.make') ||
    f.end_with?('.py') ||
    f.end_with?('.S') ||
    f.end_with?('.sb') ||
    f.end_with?('.scons') ||
    f.end_with?('.sh') ||
    f.end_with?('.in') ||
    f.end_with?('DEPS') ||
    f.end_with?('Makefile')
  end
end
