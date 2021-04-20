const { FOAF, RDF, RDF_INRUPT } = require("@inrupt/vocab-common-rdf");
console.log(`Common RDF: FOAF vocab term accountServiceHomepage: [${FOAF.accountServiceHomepage}]`);
console.log(`Common RDF: FOAF vocab term accountServiceHomepage - label: [${FOAF.accountServiceHomepage.label}]`);
console.log(`Common RDF: FOAF vocab term accountServiceHomepage - comment:  [${FOAF.accountServiceHomepage.comment}]`);
console.log(`Common RDF: RDF type: [${RDF.type}]`);
console.log(`Common RDF: RDF type - label: [${RDF.type.label}]`);
console.log(`Common RDF: FOAF Undefined term (useful workaround for terms not yet published): [${FOAF.NS('undefinedTerm')}]`);
// Test Inrupt extension that offers translations for term labels and comments.
console.log(`Common RDF: RDF type - label in Spanish: [${RDF_INRUPT.type.asLanguage('es').label}]`);
console.log();



const { SOLID } = require("@inrupt/vocab-solid-common");
console.log(`Solid vocab term ListedDocument: [${SOLID.ListedDocument}]`);
console.log(`Solid vocab term ListedDocument - label: [${SOLID.ListedDocument.label}]`);
console.log(`Solid vocab term ListedDocument - comment:  [${SOLID.ListedDocument.comment}]`);
console.log();

const { SOLID:SOLID_RDFLIB } = require("@inrupt/vocab-solid-common-rdflib");
console.log(`Solid vocab term ListedDocument (rdflib): [${SOLID_RDFLIB.ListedDocument}]`);
console.log();

const { SOLID:SOLID_RDFEXT } = require("@inrupt/vocab-solid-common-rdfext");
console.log(`Solid vocab term ListedDocument (RdfExt): [${SOLID_RDFEXT.ListedDocument.value}]`);
console.log();


const { INRUPT_COMMON } = require("@inrupt/vocab-inrupt-common");
console.log(`Inrupt Common vocab term errFailedToProcessIncomingRdf: [${INRUPT_COMMON.errFailedToProcessIncomingRdf}]`);
console.log(`Inrupt Common vocab term errFailedToProcessIncomingRdf: [${INRUPT_COMMON.errFailedToProcessIncomingRdf.message}]`);
