#!/usr/bin/env brew ruby
directories = ["_data/formula", "api/formula", "formula"]
FileUtils.rm_rf directories
FileUtils.mkdir_p directories

CoreTap.instance.formula_names.each do |n|
  f = Formulary.factory(n)
  json_filename = "#{f.name}.json"
  IO.write("_data/formula/#{json_filename.gsub('+', '_')}", JSON.pretty_generate(f.to_hash))
  FileUtils.cp "_api_formula.json.in", "api/formula/#{json_filename}"

  html = IO.read "_formula.html.in"
  html.gsub!("title: $TITLE", "title: \"#{f.name}\"")
  IO.write("formula/#{f.name}.html", html)
end
