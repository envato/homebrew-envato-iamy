# Envato envato-iamy

Homebrew tap for the Envato port of the [IAMy by 99designs](https://github.com/99designs/iamy) too.

## How do I install these formulae?

`brew install envato/envato-iamy/<formula>`

Or `brew tap envato/envato-iamy` and then `brew install <formula>`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Updating formulae

1. Open a PR with the update, something like:
   `brew bump-formula-pr --url https://github.com/envato/iamy/archive/refs/tags/v3.1.0.tar.gz --version 3.1.0+envato --no-fork` from the Formula directory should do the trick. It will do commits and pull-requests on your behalf, so maybe try with `-n` first to see what it's going to do.
2. Ensure the tests pass on the PR
3. When ready, **don't merge the PR**. Instead, label it with `pr-pull`.
4. This will trigger the "Publish" workflow, which will automatically merge the updates and close the PR.
