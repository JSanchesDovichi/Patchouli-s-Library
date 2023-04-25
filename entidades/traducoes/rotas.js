module.exports = (app) => {

    const controller = require('./controller')

    //Criar um novo usuário
    app.post('/traducoes', controller.create)

    //Busca todos os usuários
    app.get('/traducoes', controller.findAll)

    //Atualizar um usuário
    app.put('/traducoes/:id', controller.update)

    //Deletar um usuário
    app.delete('/traducoes/:id', controller.delete)

}