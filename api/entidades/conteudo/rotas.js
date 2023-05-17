module.exports = (app) => {

    const controller = require('./controller')

    //Criar um novo conteúdo
    app.post('/conteudo', controller.create)

    //Busca todos os conteúdos
    app.get('/conteudo', controller.findAll)

    //Atualizar um conteúdo
    app.put('/conteudo/:id', controller.update)

    //Deletar um conteúdo
    app.delete('/conteudo/:id', controller.delete)

}