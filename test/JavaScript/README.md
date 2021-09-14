# Test generated artifact

This is a simple developer project, currently only useful for manually testing
specific versions of specifically published npm vocabulary artifacts. It just
imports a select few of those packages, and then attempts to write to the
console certain values from certain terms we expect to see in the vocabularies
represented in those packages.

## Roadmap

- see if we can automatically populate the list of generated npm artifacts in
our `package.json` (perhaps use a Handlebars template to create the
`package.json` from the LAG itself?).  

- see if we can automatically update the version numbers of the dependent
packages in our `package.json` file, possibly just using our existing update
scripts that work with LAG YAML files, or via a Handlebars template used to
generate the `package.json` file itself, or else just use '*' for the version.

- update our current code (`index.js`) to use Jest to make actual assertions, as
opposed to simply writing to the console.

- update those Jest tests to assert on actual terms found in actual vocabs.
Again this could use a Handlebars template for this test code too, and the LAG
could populate that test source file with expected values from the first 
Class/Property/Constant it encounters while generating the vocab source code.

- include execution of the above Jest tests as part of the CI process, and blow
up the process if there are any test failures.
