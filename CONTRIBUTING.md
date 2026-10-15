# Contributing

Thanks for taking the time to improve AppClipsStudio.

## Reporting bugs

Open an issue with:

- the API or `appclipstudio` command you used and its input (an invocation URL, a size report
  excerpt, an association file),
- what you expected and what happened,
- platform and OS version (iOS simulator, device or macOS) and Xcode version.

If the bug is about what Apple accepts (a size limit, an App Clip Code rule, the association
file format), link the Apple documentation page that describes the expected behavior.

## Pull requests

1. Fork the repository and branch from `master`.
2. Keep each pull request focused on one change.
3. Run the tests on both platforms:

    ```sh
    swift test
    xcodebuild test -scheme AppClipsStudio-Package \
      -destination 'platform=iOS Simulator,name=iPhone 17'
    ```

4. Add or update a test in `Tests/AppClipsStudioTests` (library) or
   `Tests/AppClipsStudioToolTests` (command-line tool) for every logic change. Code that reads
   untrusted input (invocation URLs, size reports, association files, command-line arguments)
   needs tests for its limits and for malformed input: empty, oversized, `nan`/`inf`, values
   out of `Int` range, control characters.
5. If you change a README sample, change the same code in `Examples/CoffeeShop` (or in
   `Tests/AppClipsStudioTests/ReadmeQuickStartTests.swift` for the quick start) and build the
   example:

    ```sh
    cd Examples/CoffeeShop
    xcodebuild build -scheme CoffeeShop -destination 'generic/platform=iOS Simulator'
    ```

    The project is generated from `project.yml` with [XcodeGen](https://github.com/yonaskolb/XcodeGen);
    run `xcodegen` there after changing `project.yml` and commit both files.

6. If a change affects the example's screens, regenerate the screenshots with
   `scripts/capture-screenshots.sh`.
7. `README.md` has translations (`README.<language>.md`). Each one records the version of
   `README.md` it follows, and CI fails while a translation is behind. If you change `README.md`
   and cannot update the translations, say so in the pull request and they will be updated
   before it is merged.

## Code style

- Follow the [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/).
- The package builds in the Swift 6 language mode; new code should not add warnings, and
  `xcodebuild docbuild` should stay free of warnings.
- Document public API with DocC comments (`///`).
- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/)
  (`feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `ci:`, `chore:`).

## License

By contributing you agree that your contributions are licensed under the MIT License.
