# Changelog

This change log is intended to record changes made across all vocabularies and
configuration files contained in this repository.

## Unreleased

## 0.7.5

- Added CHANGELOG.
- Added examples of Resume/CV vocabs to Common RDF (these examples require the
  use of a Content-Type override, as they are served with 'text/plain' instead
  of 'application/rdf+xml').
- Added some more cherry-picked terms to our Schema.org extension.
- Playground RDF samples continue to evolve (still very experimental!).

## 0.7.4

- Removed `_EXT` suffix from generated Inrupt extension vocabularies (it's not
  necessary given we already suffix with `_INRUPT`).
- Added a number of vocabs to the Common RDF bundle (and hit what seems to be a
  generator limit of 44 concurrent vocabs).
