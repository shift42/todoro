namespace :version do
  desc "Bump the gem version, update changelog, build and release the gem"
  task :bump, [:version] => :environment do |t, args|
    version = args[:version]
    raise "Please specify a version. Usage: rake version:bump[0.1.5]" unless version

    gemspec_file = Dir.glob("*.gemspec").first
    raise "No gemspec file found" unless gemspec_file

    # Update the gemspec version
    gemspec_content = File.read(gemspec_file)
    new_gemspec_content = gemspec_content.gsub(/(spec\.version\s*=\s*")\d+\.\d+\.\d+("?)/, "\\1#{version}\\2")
    File.write(gemspec_file, new_gemspec_content)
    puts "Updated gemspec version to #{version}"

    # Update the changelog
    changelog_file = "CHANGELOG.md"
    raise "CHANGELOG.md not found" unless File.exist?(changelog_file)

    changelog_content = File.read(changelog_file)
    new_changelog_content = changelog_content.sub("## [Unreleased]", "## [Unreleased]\n\n## [#{version}] - #{Time.now.strftime('%Y-%m-%d')}")
    File.write(changelog_file, new_changelog_content)
    puts "Updated CHANGELOG.md with version #{version}"

    # Commit changes and create a git tag
    `git add #{gemspec_file} #{changelog_file}`
    `git commit -m "Bump version to #{version}"`
    `git tag -a v#{version} -m "Version #{version}"`
    puts "Committed and tagged version #{version}"

    # Build the gem
    `gem build #{gemspec_file}`
    puts "Built gem version #{version}"

    # Release the gem
    gem_file = Dir.glob("*.gem").max_by { |f| File.mtime(f) }
    raise "No gem file found" unless gem_file
    `gem push #{gem_file}`
    puts "Released gem #{gem_file}"
  end
end
