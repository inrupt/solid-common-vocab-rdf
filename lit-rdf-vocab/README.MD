# LIT shared vocabularies

## Vocabularies referenced in the repository

Currently this repository holds the LIT vocabularies:
  * LIT Common - made up of the most common Linked Data vocabularies, but also
   some Inrupt extensions to a select few of those vocabularies to include
   multi-lingual translations of some of their labels and comments, and 
   smaller subsets of large vocabularies (e.g. Schema.org has thousands of 
   terms, so we define a select subset of those terms in an inrupt-specific
   version of Schema.org).

  * LIT Core - vocabularies specific to the LIT itself (for use by developers
  using LIT features natively).
  
General structure within each folder here:
  * In the root we may provide a YAML file to bundle multiple vocabularies
   into single artifacts (e.g. a single NPM module, or a single Java JAR).
   
  * A 'CopyOfVocab' directory that stores local vocabularies, such as copies of
   online vocabularies (if we can't easily access online versions in Turtle).
   
  * A 'Extension' directory that stores extension vocabularies that provide
   translations of labels or comments in other vocabularies, or that selects
   subsets of other large vocabularies.

## Artifacts generation

The RDF vocabularies referenced in this repository are used to generate source
code artifacts (e.g. NPM or Maven packages) that can then be used in your code
to provide direct access to all the Classes, Properties and constants defined
in those vocabularies.

### Packages overview

See the Github `packages` tab to see the packages generated from these
vocabularies and hosted on Github.

### Generating the packages in your own environment

You can generate the artifacts in this repository in your local environment by 
using the following command from the cloned repository root:
```
bash buildAll.sh
```

This generates both Java and JS artifacts, respectively published to a local 
Maven cache and to a local Verdaccio. You can turn either of these publications
off by removing the `--publish` flags.

For more information about the LIT artifact generator, feel free to visit 
[the documentation](https://github.com/inrupt/lit-artifact-generator-js).
