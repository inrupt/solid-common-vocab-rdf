const core = require('@actions/core');
const yaml = require('js-yaml');
const fs = require('fs');

try {
  // `vocab-config-path` input defined in action metadata file
  yamlConfiguration = yaml.safeLoad(fs.readFileSync(core.getInput('vocab-config-path'), 'utf8'));
  console.log(JSON.stringify(yamlConfiguration, null, "  "));
  core.setOutput("vocab-generator-version", yamlConfiguration.artifactGeneratorVersion);
} catch (error) {
  core.setFailed(error.message);
}