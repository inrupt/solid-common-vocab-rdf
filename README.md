# lit-vocab

This repository acts as a mono-repo for all vocabularies defined and controlled 
by Inrupt.

It also stores LIT Artifact Generator configuration files that allow
us generate programming-language artifacts (e.g. Java JARs or NPM modules) that
provide convenient constants representing the terms from collections of RDF
vocabularies.

This repository also utilities for managing collections of LIT Artifact
Generator configuration files (e.g. YAML files). For example, these utilities
can be used to maintain consistent version numbers across all generated
artifacts, or to ensure all artifacts depend on the same versions of dependent
libraries (such as the LIT Vocab Term library, or the LIT Artifact Generator
itself).
