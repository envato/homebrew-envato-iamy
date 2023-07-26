# Envato envato-iamy

Homebrew tap for the Envato port of the [IAMy by 99designs](https://github.com/99designs/iamy) too.

## How do I install these formulae?

`brew install envato/envato-iamy/<formula>`

Or `brew tap envato/envato-iamy` and then `brew install <formula>`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Updating formulae

1. Make sure you are working _in_ the actual homebrew tap directory, likely `/opt/homebrew/Library/Taps/envato/homebrew-envato-iamy`
1. Open a PR with the update, something like:
   `brew bump-formula-pr --url https://github.com/envato/iamy/archive/refs/tags/v<VERSION>.tar.gz --version <VERSION>+envato --no-fork` from the Formula directory should do the trick. It will do commits and pull-requests on your behalf, so maybe try with `-n` first to see what it's going to do.
2. Ensure the tests pass on the PR
3. When ready, **don't merge the PR**. Instead, label it with `pr-pull`.
4. This will trigger the "Publish" workflow, which will automatically merge the updates and close the PR.
5. You may wish to add additional build architectures to the Formula:
   1.  Download the bottle for the appropriate releases from the homebrew-envato-iamy repository Releases, E.g. [the 5.1.0+envato bottle](https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-5.1.0%2Benvato/iamy-5.1.0+envato.monterey.bottle.tar.gz)
   2.  Unpack it in a tmp directory,  make sure you remove all of the attributes that apple scribbles on it (ls -l will show an @ next to a file with an attribute) `xattr -r -d <attribute - globs don't work> <directory>` for each attribute you find should do the trick.
   3.  Download the approriate release/architecture binary from the envato/iamy repository Releases, E.g. [the 5.1.0+envato arm64 binary](https://github.com/envato/iamy/releases/download/v5.1.0/iamy-darwin-arm64)
   4.  Remove all of the attributes that apple has added to your scary downloaded executable. Something like: `xattr -l iamy-darwin-arm64` to list em all and `xattr -d com.apple.quarantine iamy-darwin-arm64 && xattr -d com.apple.macl iamy-darwin-arm64 && xattr -d com.apple.metadata:kMDItemWhereFroms iamy-darwin-arm64` should do the trick.  Do keep in mind you are removing Apples malware protection from these downloads so make 100% sure you got them from github and the correct repository.
   5.  Replace the `iamy/5.1.0+envato/bin/iamy` binary in the unpacked bottle with your new architecture, make sure you leave it with 555 permissions.
   6.  Tar up the new bottle, the name should be the same as the one you downloaded above with the insertion of arm64 before the macos release.  E.g. `tar zcvf iamy-5.1.0+envato.arm64_monterey.bottle.tar.gz iamy`
   7.  Get the SHA256 checksum for your shiny new manually created bottle:  E.g. `sha256sum iamy-5.1.0+envato.arm64_monterey.bottle.tar.gz`.
   8.  Edit the release of the appropriate homebrew-envato-iamy release and upload the new bottle you just made, the link for the 5.1.0+envato example we have been using is [here](https://github.com/envato/homebrew-envato-iamy/releases/tag/iamy-5.1.0%2Benvato).
   9.  Edit the `Formula/iamy.rb` file to add a reference to your new bottle and push your change to the main branch.  Your edit should look something like [this commit](https://github.com/envato/homebrew-envato-iamy/commit/25d65b817ca305ef6e24b2b1e922c2e8a7cb2305).  This file is linted so pay attention to the lining up of the fields and make sure you add the arm64 bottle before plain bottle.
   10.  Test by doing a pull on your homebrew-envato-iamy tap repository and then test the upgrade by running `brew upgrade iamy`.
   11.  Swear about the fact that no-one has figured out how to make the homebrew github actions do this manual crap for us and resolve to figure it out and commit the changes here.
   12.  Put that in the too much hassle basket and just do it manually next time.
