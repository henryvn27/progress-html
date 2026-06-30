#!/usr/bin/env ruby
# frozen_string_literal: true

require "tempfile"
require "tmpdir"
require "json"

ROOT = File.expand_path("..", __dir__)
TEMPLATES = Dir[File.join(ROOT, "templates", "*.html")].sort
REQUIRED_TEXT = [
  "progress.html",
  "Do next",
  "progressbar",
  "Latest update",
  "Slice",
  "State",
  "Updated",
  "Verification",
  "Time remaining",
  "Estimate Learning Log",
  "data-estimate-min",
  "data-actual-min"
].freeze

abort "expected 1 template, found #{TEMPLATES.length}" unless TEMPLATES.length == 1

TEMPLATES.each do |path|
  html = File.read(path)
  name = File.basename(path)

  REQUIRED_TEXT.each do |text|
    abort "#{name}: missing #{text.inspect}" unless html.include?(text)
  end

  abort "#{name}: must be standalone" if html.match?(/https?:\/\//)
  abort "#{name}: external scripts are not allowed" if html.match?(/<script[^>]+\bsrc=/i)
  abort "#{name}: external stylesheets are not allowed" if html.match?(/rel=["']stylesheet/i)
  abort "#{name}: state must not be color-only" unless html.match?(/queued|active|waiting|blocked|verifying|done/i)
  abort "#{name}: avoid gradient styling" if html.match?(/gradient/i)

  html.scan(%r{<script>(.*?)</script>}m).flatten.each do |script|
    Tempfile.create(["progress-html-", ".js"]) do |file|
      file.write(script)
      file.flush
      abort "#{name}: inline script syntax failed" unless system("node", "--check", file.path, out: File::NULL, err: File::NULL)
    end
  end
end

Tempfile.create(["progress-html-generated-", ".html"]) do |file|
  file.close
  abort "cli init failed" unless system(File.join(ROOT, "bin/progress-html"), "init", "--target", file.path, out: File::NULL)
  generated = File.read(file.path)
  abort "cli output missing project brand" unless generated.include?("project-brand")
  abort "cli output missing generated theme" unless generated.include?("--active:")
end

Dir.mktmpdir("progress-html-project-") do |dir|
  File.write(File.join(dir, "package.json"), JSON.dump({ name: "field-notes" }))
  File.write(File.join(dir, "app-icon.svg"), "<svg xmlns='http://www.w3.org/2000/svg'></svg>")
  File.write(File.join(dir, "style.css"), ":root { --brand: #2f6f55; }")
  Dir.chdir(dir) do
    abort "cli themed init failed" unless system(File.join(ROOT, "bin/progress-html"), "init", "--target", "progress.html", out: File::NULL)
  end
  generated = File.read(File.join(dir, "progress.html"))
  abort "cli output missing project name" unless generated.include?("Field Notes")
  abort "cli output missing local logo" unless generated.include?('src="app-icon.svg"')
  abort "cli output missing detected accent" unless generated.include?("--active: #2f6f55")
end

%w[
  README.md
  progress.html
  docs/agent-instructions.md
  docs/integrations.md
  docs/research.md
  examples/goal-runner.md
  examples/tool-wiring.md
  prompts/install-progress-html.md
  skills/progress-html/SKILL.md
  orca-tool.json
].each do |relative|
  path = File.join(ROOT, relative)
  abort "missing #{relative}" unless File.exist?(path)
end

puts "progress-html verification passed"
