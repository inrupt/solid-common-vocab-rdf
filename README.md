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
its own directory from the root of this repository) :

 - Common RDF, including dozens of well-known RDF vocabularies: [FOAF](http://xmlns.com/foaf/spec/), 
 [LDP](http://www.w3.org/ns/ldp#), [OWL](http://www.w3.org/2002/07/owl#), [RDFS](http://www.w3.org/2000/01/rdf-schema#),
 etc. To learn more about common vocabularies, have a look at the [Solid project website](https://solidproject.org/for-developers/apps/vocabularies) 
    - [@inrupt/vocab-common-rdf](https://www.npmjs.com/package/@inrupt/vocab-common-rdf) on NPM
 - Solid RDF, including vocabularies related to Solid like [Solid Terms](https://www.w3.org/ns/solid/terms), 
 [WebACL](http://www.w3.org/ns/auth/acl#), the [Workspace Ontology](http://www.w3.org/ns/pim/space), etc.
    - [@inrupt/vocab-solid-common](https://www.npmjs.com/package/@inrupt/vocab-solid-common) on NPM
 - Inrupt RDF (Inrupt-specific vocabularies, such as product-specific vocabs, or our UI components)
    - [@inrupt/vocab-inrupt-common](https://www.npmjs.com/package/@inrupt/vocab-inrupt-common) on NPM

To see how and where these bundles are packaged and published, you'll need to look at the
YAML files in each of the respective directories (since different bundles can be generated for
different programming languages, and published to multiple places - i.e. the generation process
is very flexible!).

## Put the vocabularies to action

If you want to use these vocabularies in an app to read/write data in your Solid Pod, have a look at our [Solid Client library](https://github.com/inrupt/solid-client-js).