# Solid Common Vocabularies in RDF

This repository acts like a mono-repo for all the RDF vocabularies defined,
controlled or used by Inrupt.

Vocabularies (also known, slightly more formally, as Ontologies) provide the
basis to allow developers build interoperable applications by reusing the
individual terms (i.e. Classes and Properties) from well-known and public
vocabularies (such as Schema.org, or Friend-of-a-Friend (FOAF) or the Dublin
Core (DC Terms) etc.), as well as from highly specialised or even private
vocabularies, perhaps only ever intended for use within a narrow field, or
even only within a single organization.

Convenient developer libraries/modules can be generated automatically from
these vocabularies to provide programming language classes (one class per
vocabulary) where each class is made up of constants representing the
individual terms defined by a single vocabulary. As a developer, you just
need to import the individual vocabulary class that you need to have access
to the static constants representing each of the terms defined in that
vocabulary (see the example below showing how easy it is to access the
terms from the popular Friend-of-a-Friend (FOAF) RDF vocabulary).

Because developers typically use terms from multiple, often related
vocabularies, it can be very convenient for them if we bundle together the
generated classes from related vocabularies together into 
libraries/modules for them to import more easily.

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
need to look at the configuration files themselves (i.e., the YAML files) in each
of the respective directories (since different artifacts can be generated for
different programming languages, and that depend on multiple different underlying
RDF libraries, and can be published to multiple repositories - in other words,
the entire generation process is extremely configurable and flexible!).

## Example usage - JavaScript

To use the terms defined in the common Friend-of-a-Friend (FOAF) vocabulary,
which is just one of the vocabularies bundled in the `@inrupt/vocab-common-rdf`
artifact, simply add the following dependency to your project:

```shell
npm install @inrupt/vocab-common-rdf
```

This npm module bundles together many of the most popular and common RDF
vocabularies that exist today, of which FOAF is just one. So to import just the
FOAF class from that dependency, simply do:
```
const { FOAF } = require("@inrupt/vocab-common-rdf");
```

...and now you can very easily and naturally use any of the FOAF terms in your
code:
```javascript
console.log(`The Agent term from the FOAF vocabulary has the IRI: [${FOAF.Agent}]`);
```

This should produce the output:
```shell
The Agent term from the FOAF vocabulary has the IRI: [http://xmlns.com/foaf/0.1/Agent]
```

### Advanced usage

Our artifact generation process can optionally generate static constants that
also provide very easy access to certain meta-data that is commonly provided by
vocabularies (e.g., `rdfs:label` and `rdfs:comment` values, `rdfs:seeAlso`
links, `rdfs:isDefinedBy` links, etc.). For example, to access the comment
associated with the FOAF term 'Agent', do the following:

```javascript
console.log(`The comment associated with Agent: [${FOAF.Agent.comment}]`);
```

## Try it out yourself - on CodeSandbox

Feel free to play around with this yourself using this very simple CodeSandbox
example (e.g., see if you can edit this code to display the label and comment for
the rather cryptically named `fn` term from the vCard vocabulary (which is also
bundled in the same `@inrupt/vocab-common-rdf` artifact, exported as the `VCARD`
class): https://codesandbox.io/s/inrupt-rdf-vocab-demo-206e7?file=/src/index.js

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
