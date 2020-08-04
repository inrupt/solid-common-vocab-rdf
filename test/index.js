const { FOAF } = require("@inrupt/vocab-common-rdf");
console.log(`LIT Common: FOAF vocab term accountServiceHomepage: [${FOAF.accountServiceHomepage.value}]`);
console.log(`LIT Common: FOAF vocab term accountServiceHomepage label: [${FOAF.accountServiceHomepage.label}]`);
console.log(`LIT Common: FOAF vocab term accountServiceHomepage comment: [${FOAF.accountServiceHomepage.comment}]`);
console.log();


const { SOLID } = require("@inrupt/vocab-solid-common");
console.log(`Solid vocab term ListedDocument (LIT Vocab Term): [${SOLID.ListedDocument.value}]`);
console.log(`Solid vocab term ListedDocument label: [${SOLID.ListedDocument.label}]`);
console.log(`Solid vocab term ListedDocument comment: [${SOLID.ListedDocument.comment}]`);

const { SOLID:SOLID_RDFLIB } = require("@inrupt/vocab-solid-common-rdflib");
console.log(`Solid vocab term ListedDocument (rdflib): [${SOLID_RDFLIB.ListedDocument.value}]`);

const { SOLID:SOLID_RDFEXT } = require("@inrupt/vocab-solid-common-rdfext");
console.log(`Solid vocab term ListedDocument (RdfExt): [${SOLID_RDFEXT.ListedDocument.value}]`);
console.log();


const { INRUPT_COMMON } = require("@inrupt/vocab-inrupt-common");
console.log(`Inrupt Common vocab term errFailedToProcessIncomingRdf: [${INRUPT_COMMON.errFailedToProcessIncomingRdf.value}]`);
console.log(`Inrupt Common vocab term errFailedToProcessIncomingRdf: [${INRUPT_COMMON.errFailedToProcessIncomingRdf.message}]`);
