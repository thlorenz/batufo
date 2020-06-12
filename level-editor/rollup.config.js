const typescript = require('rollup-plugin-typescript')

module.exports = {
  input: './src/main.ts',
  plugins: [typescript()],
  output: {
    sourcemap: true,
    format: 'iife',
    name: 'app',
    file: 'dist/bundle.js',
  },
}
