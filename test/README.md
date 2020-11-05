# Test generated artifact

This repository acts like a mono-repo for all the RDF vocabularies defined,
controlled and used by Inrupt. It provides a basis to allow developers build
interoperable applications by reusing the individual terms (i.e. Classes and
Properties) from well-known or public vocabularies. 

Libraries can be generated that provide programming language classes (one class
per vocabulary) where each class is made up of constants that represent the
individual terms defined by that vocabulary. As a developer, you just need to
import the individual vocabulary classes that you need to have full access to
constants representing all that vocabularies term terms.

## Published vocabulary bundles

Currently, this repository contains configuration for the following bundles of
vocabularies (each configured in its own directory from the root of this
repository):

 - [@inrupt/vocab-common-rdf](https://www.npmjs.com/package/@inrupt/vocab-common-rdf),
 including dozens of well-known RDF vocabularies: [FOAF](http://xmlns.com/foaf/spec/), 
 [LDP](http://www.w3.org/ns/ldp#), [OWL](http://www.w3.org/2002/07/owl#),
 [RDFS](http://www.w3.org/2000/01/rdf-schema#), etc.
 
 - [@inrupt/vocab-solid-common](https://www.npmjs.com/package/@inrupt/vocab-solid-common), 
 including vocabularies related to Solid like [Solid Terms](https://www.w3.org/ns/solid/terms), 
 [WebACL](http://www.w3.org/ns/auth/acl#), the [Workspace Ontology](http://www.w3.org/ns/pim/space), etc.
 
 - [@inrupt/vocab-inrupt-common](https://www.npmjs.com/package/@inrupt/vocab-inrupt-common), 
 including Inrupt-specific vocabularies, such as product-specific vocabs, or our
 UI components).

To see how and where these bundles are generated, packaged and published, you'll
need to look at the configuration files themselves (i.e. the YAML files) in each
of the respective directories (since different bundles can be generated for
different programming languages, and published to multiple places - i.e. the
generation process is highly flexible!).


# Issues & Help

## Solid Community Forum

If you have questions about working with Solid, or just want to share what
you’re working on, visit the [Solid forum](https://forum.solidproject.org/). The
Solid forum is a good place to meet with the rest of the community.

## Bugs and Feature Requests

- For public feedback, bug reports, and feature requests please file an issue
via [GitHub](https://github.com/inrupt/solid-vocab-common-rdf/issues/).

- For non-public feedback or support inquiries please use the
[Inrupt Service Desk](https://inrupt.atlassian.net/servicedesk).

## Documentation
- To learn more about vocabularies, have a look at the
[Inrupt Vocabularies documentation](https://solidproject.org/for-developers/apps/vocabularies)
 
- [Inrupt documentation homepage](https://docs.inrupt.com/)

# License

MIT © [Inrupt](https://inrupt.com)
