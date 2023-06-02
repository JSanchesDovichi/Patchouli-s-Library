const express = require('express')
var cors = require('cors')
//var https = require('https')
//var http = require('http')
//const fs = require('fs');
const app = express()
const port = 3000

const db = require('./database.js')

app.use(express.urlencoded({ extended: true }));
app.use(cors())

db.sequelize.sync({ force: true })

app.get('/atualizar_banco_dados', (req, res) => {
  db.sequelize.sync({ force: true })

  res.send("Ok")
})

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/conn_test', async (req, res) => {
  try {
    await db.authenticate();
    res.send("Connection estabilished with success!");
  } catch (error) {
    res.send("Unable to estabilish connection!");
  }
});

/*
app.get('/test_file', (req, res) => {
  res.sendFile("/home/workstation/Projetos/dweb2/Patchoulis_Library/assets/pages/onepiece1.jpg")
});

app.get('/test_file2', (req, res) => {
  res.sendFile("/home/workstation/Projetos/dweb2/Patchoulis_Library/assets/pages/onepiece1_overlay.png")
});
*/

require('./entidades/usuarios/rotas')(app)
require('./entidades/conteudo/rotas')(app)
require('./entidades/traducoes/rotas')(app)
app.use(require('./auth.js'));

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

/*
var key = fs.readFileSync(__dirname + '/selfsigned.key');
var cert = fs.readFileSync(__dirname + '/selfsigned.crt');
var options = {
  key: key,
  cert: cert
};

https.createServer(options, app).listen(443)

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
*/