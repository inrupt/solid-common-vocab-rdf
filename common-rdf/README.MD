# Common RDF vocabularies

## Vocabularies referenced in the repository

General structure within each folder here:
  * In the root we may provide a YAML file to bundle multiple vocabularies
   into single artifacts (e.g. a single npm module, or a single Java JAR).
   
  * A 'CopyOfVocab' directory that stores local vocabularies, such as copies of
   online vocabularies (e.g. if we can't easily access online versions in
   RDF, or if the hosting server is unreliable).
   
  * A 'Extension' directory that stores extension vocabularies that provide
   translations of labels or comments in other vocabularies, or that select
   subsets of terms from other large vocabularies.

## Artifact generation

The RDF vocabularies referenced in configuration file are used to generate
source code artifacts (e.g. Java JARs, or npm packages) that can then be
published locally or remotely to one or more repositories (e.g. Maven Central,
or [npmjs.org](npmjs.org), or Cloudsmith, or a shared Verdaccio server, or a
local Verdaccio, or a local `.m2` Maven repository, etc.), and from there used
in your code to provide direct access to all the Classes, Properties and
constants defined in those vocabularies.

For more information about the Artifact Generator itself, feel free to visit 
[the documentation](https://github.com/inrupt/lit-artifact-generator).
