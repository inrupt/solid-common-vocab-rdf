
# Solid JavaScript Vocabularies - solid-common-vocab-rdf

This repository acts as a mono-repo for all the RDF vocabularies defined and controlled by Inrupt. 
It allows developers to build interoperable apps by reusing well-known vocabularies. 
These libraries provide vocabularies available as constants that you just have to import.

This repo also stores configuration files that allow us generate
programming-language-specific artifacts (e.g. Java JARs, NPM modules, etc.) that provide
convenient constants representing the individual terms from RDF vocabularies (including
from RDF vocabularies that are not under our control, such as common vocabularies like
Schema.org, or FOAF, or Dublin Core, etc.).

## Published vocabulary bundles

Currently this repository bundles the following sets of vocabularies (each configured in
its own directory from the root of this repository) :

 - [@inrupt/vocab-common-rdf](https://www.npmjs.com/package/@inrupt/vocab-common-rdf),
 including dozens of well-known RDF vocabularies: [FOAF](http://xmlns.com/foaf/spec/), 
 [LDP](http://www.w3.org/ns/ldp#), [OWL](http://www.w3.org/2002/07/owl#),
 [RDFS](http://www.w3.org/2000/01/rdf-schema#), etc.
 - [@inrupt/vocab-solid-common](https://www.npmjs.com/package/@inrupt/vocab-solid-common), 
 including vocabularies related to Solid like [Solid Terms](https://www.w3.org/ns/solid/terms), 
 [WebACL](http://www.w3.org/ns/auth/acl#), the [Workspace Ontology](http://www.w3.org/ns/pim/space), etc.
 - [@inrupt/vocab-inrupt-common](https://www.npmjs.com/package/@inrupt/vocab-inrupt-common), 
 including Inrupt-specific vocabularies, such as product-specific vocabs, or our UI components)


To see how and where these bundles are packaged and published, you'll need to look at the
YAML files in each of the respective directories (since different bundles can be generated for
different programming languages, and published to multiple places - i.e. the generation process
is very flexible!).

@inrupt/solid-common-vocab-rdf is part of a family open source JavaScript libraries designed to support developers building Solid applications.

# Inrupt Solid JavaScript Client Libraries

## Data access and permissions management - solid-client

[@inrupt/solid-client](https://docs.inrupt.com/client-libraries/solid-client-js/) allows developers to access data and manage permissions on data stored in Solid Pods.

## Authentication - solid-client-authn

[@inrupt/solid-client-authn](https://github.com/inrupt/solid-client-authn) allows developers to authenticate against a Solid server. This is necessary when the resources on your Pod are not public.

## Vocabularies and interoperability - solid-common-vocab-rdf

[@inrupt/solid-common-vocab-rdf](https://github.com/inrupt/solid-common-vocab-rdf) allows developers to build interoperable apps by reusing well-known vocabularies. These libraries provide vocabularies available as constants that you just have to import.

# Installation

For the latest stable version of solid-common-vocab-rdf:

```bash
npm install @inrupt/solid-common-vocab-rdf
```

For the latest stable version of all Inrupt Solid JavaScript libraries:

```bash
npm install @inrupt/solid-client @inrupt/solid-client-authn-browser @inrupt/vocab-common-rdf
```

# Issues & Help

## Solid Community Forum

If you have questions about working with Solid or just want to share what you’re working on, visit the [Solid forum](https://forum.solidproject.org/). The Solid forum is a good place to meet the rest of the community.

## Bugs and Feature Requests

- For public feedback, bug reports, and feature requests please file an issue via [GitHub](https://github.com/inrupt/solid-vocab-common-rdf/issues/).
- For non-public feedback or support inquiries please use the [Inrupt Service Desk](https://inrupt.atlassian.net/servicedesk).

## Documentation
- To learn more about vocabularies, have a look at the [Inrupt Vocabularies documentation](https://solidproject.org/for-developers/apps/vocabularies) 
- [Inrupt documentation homepage](https://docs.inrupt.com/)

# License

MIT © [Inrupt](https://inrupt.com)
