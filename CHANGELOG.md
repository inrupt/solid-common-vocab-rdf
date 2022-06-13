# Changelog

This change log is intended to record changes made across all vocabularies and
configuration files contained in this repository.

## Unreleased

- Added SOSA and SSN to the Common RDF bundle.
- Added glossary term for 'Linked Data', that explains that we capitalize the
  letters, and provides a `rdfs:seeAlso` to Richard's reasons for why that's
  important! 
- Aligned all vocab license IRIs to be "http://purl.org/NET/rdflicense/MIT1.0"
- Added explicit 'xsd:anyURI' datatype to all VANN 'preferredNamespaceUri'
  objects in vocabs we create.
- Added some more Schema.org terms to our Inrupt extension.
- Updated year in license headers.
- Changed Verifiable Credentials prefix from 'cred' to just 'vc' (which
  appears available in prefix.cc).
- Updated SKOS-XL prefix to be just 'skosxl', that they use themselves.
- Used archived VANN vocabulary resource (instead of local Turtle).

## v1.0.3 2021-10-03

- Cherry-picked some new generic terms from Schema.org, and added a couple of
  generically useful terms to the Inrupt Common vocab (for concepts that don't
  seem to exist in Schema.org).
- Added all 5 address-related terms from Schema.org.
- Added SIOC to our Common RDF bundle.
- Switch FOAF to use local copy (namespace URL (http://xmlns.com/foaf/0.1/)
  seems down).

## v1.0.2 2021-09-29

- Updated glossary vocabs, and added an initial Solid one (based on
  [SolidProject](https://docs.inrupt.com/developer-tools/javascript/client-libraries/reference/glossary/)).
- Removed unnecessary vocab descriptions from YAMLS (as descriptions should
  come from vocabs themselves - we only provide the capability for vocabs that
  fail to describe themselves).
- Moved the basic test code into a JavaScript-specific sub-directory.
- Added Schema.org term ('accountId'), and authn token as a JWT term for Inrupt.
- Fixed 3 occurrences of `vann:preferredNamespaceURI` with `vann:preferredNamespaceUri`!
- Updated configuration field names from `artifactPrefix` and `artifactSuffix`
  to `artifactNamePrefix` and `artifactNameSuffix` respectively, to better
  convey their intent, and to align them better with the `artifactName` field
  that they both apply to.

## v1.0.1 2021-08-20

- Updated the StringLiteral artifacts to generate TypeScript instead of
  JavaScript.
- Configure the required Typescript packaging files consistently.
- Updated spelling of multilingual - it shouldn't be hyphenated!
- Now that the AG is open-sourced, added back the git URL to the versioning
  section of all the YAMLs.

## v1.0.0 2021-08-11

- Release to open source.

## v0.0.28 2021-08-10

- Updated CI workflows to use renamed Artifact Generator.
- Further prefix name updates (e.g., changing to underscores instead of
  hyphens, mismatches fixed).
- Update JS packaging YAML to correctly point to rollup config.
- Flipped 'default' term types for artifacts to be string literal, instead
  of RDF/JS types. This means the default artifacts have no dependencies on
  any external libraries (but may make working with RDF libraries more
  awkward, and will have no access to term meta-data - but we do publish
  those artifacts explicitly too, they're just not the 'default').
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
