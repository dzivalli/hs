# Usage
### Run specs:
- `bundle install`
- `rspec spec/`

### Run executable:
- Make sure `bin/run` can be executed (`chmod a+x bin/run`)
- `bin/run -s <source file> -c <file with changes>`
- File `output.json` will be created in the current directory 

_Make sure local ruby version matches to `.ruby-version`_ 

# Scaling
1. Star using database and export data in json format when it's needed
2. If file is too large and doesn't fit RAM then another strategy should be selected. For instance, file should be read by parts/chunks, analyzed (changes should be applied if criteria are met) and then parts/chunks should be written to output.json to avoid memory overflow.
