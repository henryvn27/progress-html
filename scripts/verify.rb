#!/usr/bin/env ruby
# frozen_string_literal: true

require "tempfile"

ROOT = File.expand_path("..", __dir__)
TEMPLATES = Dir[File.join(ROOT, "templates", "*.html")].sort
REQUIRED_TEXT = [
  "progress.html",
  "Latest update",
  "Slice",
  "State",
  "Verification"
].freeze

abort "expected 3 templates, found #{TEMPLATES.length}" unless TEMPLATES.length == 3

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

%w[README.md docs/agent-instructions.md docs/research.md skills/progress-html/SKILL.md orca-tool.json].each do |relative|
  path = File.join(ROOT, relative)
  abort "missing #{relative}" unless File.exist?(path)
end

puts "progress-html verification passed"
