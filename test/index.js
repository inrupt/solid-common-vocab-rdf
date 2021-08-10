//
// Note: This code simply imports some of our generated artifacts, and
//  attempts to output to the console values from those artifacts. If you wish
//  to test artifacts generated locally first (e.g., perhaps before pushing
//  changes to GitHub), then you'll need to first run `npm install` pointing
//  at your local repository, e.g., for Verdaccio on it's default port:
//    npm install --registry http://localhost:4873
//

const { FOAF, RDF, RDF_INRUPT } = require("@inrupt/vocab-common-rdf-vocabterm");
console.log(`Common RDF: FOAF vocab term accountServiceHomepage: [${FOAF.accountServiceHomepage}]`);
console.log(`Common RDF: FOAF vocab term accountServiceHomepage - label: [${FOAF.accountServiceHomepage.label}]`);
console.log(`Common RDF: FOAF vocab term accountServiceHomepage - comment:  [${FOAF.accountServiceHomepage.comment}]`);
console.log(`Common RDF: RDF type: [${RDF.type}]`);
console.log(`Common RDF: RDF type - label: [${RDF.type.label}]`);
// Here our 'NS()' function is returning a NamedNode, and not a string.
console.log(`Common RDF: FOAF Undefined term (useful workaround for terms not yet published): [${FOAF.NS('undefinedTerm').value}]`);
// Test Inrupt extension that offers translations for term labels and comments.
console.log(`Common RDF: RDF type - label in Spanish: [${RDF_INRUPT.type.asLanguage('es').label}]`);
console.log();


const { SOLID } = require("@inrupt/vocab-solid-vocabterm");
console.log(`Solid vocab term ListedDocument: [${SOLID.ListedDocument}]`);
console.log(`Solid vocab term ListedDocument - label: [${SOLID.ListedDocument.label}]`);
console.log(`Solid vocab term ListedDocument - comment:  [${SOLID.ListedDocument.comment}]`);
console.log();

const { SOLID:SOLID_RDFJS_DATAFACTORY } = require("@inrupt/vocab-solid-rdfjs-rdfdatafactory");
console.log(`Solid vocab term ListedDocument (RDF/JS DataFactory): [${SOLID_RDFJS_DATAFACTORY.ListedDocument.value}]`);
console.log();

const { SOLID:SOLID_RDFLIB } = require("@inrupt/vocab-solid-rdflib");
console.log(`Solid vocab term ListedDocument (rdflib): [${SOLID_RDFLIB.ListedDocument}]`);
console.log();


// We rename the Inrupt Common vocab, just to indicate that it's coming in
// fact from the Inrupt Core bundle.
const { INRUPT_COMMON: INRUPT_CORE_COMMON } = require("@inrupt/vocab-inrupt-core-vocabterm");
console.log(`Inrupt Core vocab term errFailedToProcessIncomingRdf: [${INRUPT_CORE_COMMON.errFailedToProcessIncomingRdf}]`);
console.log(`Inrupt Core vocab term errFailedToProcessIncomingRdf: [${INRUPT_CORE_COMMON.errFailedToProcessIncomingRdf.message}]`);
