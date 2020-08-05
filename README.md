# solid-common-vocab-rdf

This repository acts as a mono-repo for all the RDF vocabularies defined and controlled 
by Inrupt.

It also stores Artifact Generator configuration files that allow us generate
programming-language-specific artifacts (e.g. Java JARs, NPM modules, etc.) that provide
convenient constants representing the individual terms from RDF vocabularies (including
from RDF vocabularies that are not under our control, such as common vocabularies like
Schema.org, or FOAF, or Dublin Core, etc.).

## Published vocabulary bundles

Currently this repository bundles the following sets of vocabularies (each configured in
it's own directory from the root of this repository) :

 - Common RDF (includes dozens of common RDF vocabularies, like FOAF, LDP, OWL, RDFS, etc.)
 - Solid RDF (includes Solid vocabularies like Solid Terms, WebACL, the Workspace Ontology, etc.)
 - Inrupt RDF (Inrupt-specific vocabularies, such as product-specific vocabs, or our UI components)
 - LIT RDF (to be renamed - includes vocabs for our common tooling, like our Artifact Generator)

To see how and where these bundles are packaged and published, you'll need to look at the
YAML files in each of the respective directories (since different bundles can be generated for
different programming languages, and published to multiple places - i.e. the generation process
is very flexible!).
