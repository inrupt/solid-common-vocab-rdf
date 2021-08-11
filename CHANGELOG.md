# Changelog

This change log is intended to record changes made across all vocabularies and
configuration files contained in this repository.

## Unreleased

## v1.0.0 2021-08-11
- Release to open source.

## v0.0.28 2021-08-10

- Updated CI workflows to use renamed Artifact Generator.
- Further prefix name updates (e.g., changing to underscores instead of
  hyphens, mismatches fixed).
- Update JS packaging YAML to correctly point to rollup config.
- Flipped 'default' term types for atifacts to be string literal, instead
  of RDF/JS types. This means the default artifacts have no dependencies on
  any external libraries (but may make working with RDF libraries more
  awkward, and will hav eno access to term meta-data - but we do publish
  those artifacts too, they're just not the 'default').
- Remove '@types/rdf-js' and 'rdfjsTypesVersion' from YAMLs (it's
  deprecated now).
- Remove '-List' from all YAML filenames, and make all lower-case.

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
