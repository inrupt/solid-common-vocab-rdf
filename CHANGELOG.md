# Changelog

This change log is intended to record changes made across all vocabularies and
configuration files contained in this repository.

## Unreleased

- Further prefix name updates (e.g., changing to underscores instead of hyphens, mismatches fixed).
- Update JS packaging YAML to correctly point to rollup config

## v0.0.27 2021-07-27

- Major restructuring and tidying-up in preparation for open sourcing.

## 0.0.26 (missing the leading 'v'!) 2021-07-19

- Added CHANGELOG.
- Added examples of Resume/CV vocabs to Common RDF (these examples require the
  use of a Content-Type override, as they are served with 'text/plain' instead
  of 'application/rdf+xml').
- Added some more cherry-picked terms to our Schema.org extension.
- Playground RDF samples continue to evolve (still very experimental!).

## 0.0.25

- Removed `_EXT` suffix from generated Inrupt extension vocabularies (it's not
  necessary given we already suffix with `_INRUPT`).
- Added a number of vocabs to the Common RDF bundle (and hit what seems to be a
  generator limit of 44 concurrent vocabs).
