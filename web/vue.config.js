module.exports = {
  assetsDir: 'static',
  devServer: {
    proxy: {
      '/': {
        target: 'http://localhost:8123/',
        ws: false,
        changeOrigin: true
      }
    }
  }
}
