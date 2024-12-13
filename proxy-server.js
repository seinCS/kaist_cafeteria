const express = require('express');
const cors = require('cors');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

app.use(cors());

app.use('/api', createProxyMiddleware({
  target: 'http://3.36.145.239:3000',
  changeOrigin: true,
  pathRewrite: {
    '^/api': '',
  },
}));

app.listen(8080, () => {
  console.log('Proxy server running on port 8080');
}); 