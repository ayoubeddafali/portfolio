module.exports = {
  entry: {
    app: ['./web/static/css/app.scss', './web/static/js/app.js']
  },
  port: 3003,
  html: false,
  browsers: ['last 2 versions', 'ie > 8'],
  assets_url: '/assets/',  // Urls dans le fichier final
  stylelint: './web/static/css/**/*.scss',
  assets_path: './priv/static/assets', // ou build ?
  refresh: [], // Permet de forcer le rafraichissement du navigateur lors de la modification de ces fichiers
  historyApiFallback: false, // Passer à true si on utilise le mode: 'history' de vue-router (redirige toutes les requêtes sans réponse vers index.html)
  debug: process.env.NODE_ENV === 'development'
}
