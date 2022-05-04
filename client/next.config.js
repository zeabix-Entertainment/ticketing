const webpack = require("webpack");

module.exports = {
  webpack: (config) => {
    config.node = {
      fs: "empty",
    };

    process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
    const env = Object.keys(process.env).reduce((acc, curr) => {
      acc[`process.env.${curr}`] = JSON.stringify(process.env[curr]);
      return acc;
    }, {});

    config.plugins.push(new webpack.DefinePlugin(env));

    return config;
  },
}; 

/*
module.exports = {
  webpackDevMiddleware: (config) => {
    config.watchOptions.poll = 300;
    return config;
  },
};
*/