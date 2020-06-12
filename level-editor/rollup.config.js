const typescript = require('rollup-plugin-typescript')

module.exports = {
  input: './src/level-editor.ts',
  plugins: [typescript()],
  output: {
    sourcemap: true,
    format: 'iife',
    name: 'app',
    file: 'dist/level-editor.js',
  },
}
