# Contributing to `matchfee`

Feel free to add any PR's you think would be useful to the project. If you have any questions, feel free to open an issue, fill out the template, and I'll get back to you as soon as I can.

1. Fork it
2. Create your feature branch `git checkout -b my-new-feature`
3. Add your chages, **document and test** any new features, update coverage badge [(see)](#update-testing-and-coverage-badge), **fix linting issues**, and have proper **flutter format**, then run `git commit -am 'Add some feature'`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request
Examples:
	- **fix:** Fix a bug (equivalent to a PATCH in Semantic Versioning).
	- **feat:** Add a new feature to the codebase (MINOR in semantic versioning).
	- **chore:** Update something without impacting the user (ex: bump a dependency in package.json).
	- **ci:** Update something related to the pipelines.
	- **docs:** Documentation changes.
	- **style:** Code style change (semicolon, indentation...).
	- **refactor:** Refactor code without changing public API.
	- **perf:** Update code performances.
	- **test:** Add test to an existing feature.

---

## Update testing and coverage badge

Create tests ang check coverage with `flutter test --coverage --test-randomize-ordering-seed random`

You can install [lcov](https://github.com/linux-test-project/lcov) with `brew install lcov` and run `genhtml coverage/lcov.info -o coverage/html`to generate a `.html` report and see the actual code coverage, open it with `open coverage/index.html`

You can also install [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) in VSCode to see real-time coverage in the IDE once the lcov is generated

```bash
# Generate lcov file
flutter test --coverage --test-randomize-ordering-seed random

# Generate html Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html

# Full command
flutter test --coverage --test-randomize-ordering-seed random && genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html
```

**Update `coverage_badge.svg`** file with the current coverage report percentage (there's two fields), update both of them with the same value.
