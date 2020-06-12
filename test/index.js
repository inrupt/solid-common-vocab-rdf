const { FOAF } = require("@solid/lit-vocab-common");

console.log(`LIT Common: FOAF vocab term accountServiceHomepage: [${FOAF.accountServiceHomepage.value}]`);
console.log(`LIT Common: FOAF vocab term accountServiceHomepage label: [${FOAF.accountServiceHomepage.label.value}]`);
console.log(`LIT Common: FOAF vocab term accountServiceHomepage comment: [${FOAF.accountServiceHomepage.comment.value}]`);
console.log();


const { SOLID } = require("@solid/lit-vocab-solid-common");

const { SOLID:SOLID_TS } = require("@isolid/lit-vocab-solid-common-ts");
const { SOLID:SOLID_RDFLIB } = require("@solid/lit-vocab-solid-common-rdflib");
const { SOLID:SOLID_RDFEXT } = require("@solid/lit-vocab-solid-common-rdfext");

console.log(`Solid vocab term ListedDocument (LIT Vocab Term): [${SOLID.ListedDocument.value}]`);
console.log(`Solid vocab term ListedDocument label: [${SOLID.ListedDocument.label.value}]`);
console.log(`Solid vocab term ListedDocument comment: [${SOLID.ListedDocument.comment.value}]`);

console.log(`Solid vocab term ListedDocument (LIT Vocab Term - TS): [${SOLID_TS.ListedDocument.value}]`);
console.log(`Solid vocab term ListedDocument label: [${SOLID_TS.ListedDocument.label.value}]`);
console.log(`Solid vocab term ListedDocument comment: [${SOLID_TS.ListedDocument.comment.value}]`);

console.log(`Solid vocab term ListedDocument (rdflib): [${SOLID_RDFLIB.ListedDocument.value}]`);
console.log(`Solid vocab term ListedDocument (RdfExt): [${SOLID_RDFEXT.ListedDocument.value}]`);
console.log();


const { INRUPT_COMMON } = require("@inrupt/lit-vocab-inrupt");

console.log(`Inrupt Common vocab term errFailedToProcessIncomingRdf: [${INRUPT_COMMON.errFailedToProcessIncomingRdf.value}]`);
console.log(`Inrupt Common vocab term errFailedToProcessIncomingRdf: [${INRUPT_COMMON.errFailedToProcessIncomingRdf.message.value}]`);
