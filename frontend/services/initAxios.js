const axios = require('axios');
const https = require('https');
const fs = require('fs');

const certFilePath = __dirname + "\\certificat.cer";
const certificate = fs.readFileSync(certFilePath);

const httpsAgent = https.Agent({
  rejectUnauthorized: true,
  ca: certificate
});
const axiosInstance = axios.create({
        httpsAgent: httpsAgent
});

module.exports = axiosInstance;