const Handlebars = require('handlebars');
const core = require('@actions/core');
const fs = require('fs');

try {
    const template = Handlebars.compile(fs.readFileSync(core.getInput('template-path')).toString());
    const contents = template(process.env);
    fs.writeFileSync(core.getInput('output-path'), contents);
} catch (error) {
    core.setFailed(error.message);
}