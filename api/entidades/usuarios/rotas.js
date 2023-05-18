module.exports = (app) => {

    const controller = require('./controller')

    //Criar um novo usuário
    app.post('/signup', controller.create)

    //Busca todos os usuários
    app.get('/usuarios', controller.findAll)

    //Atualizar um usuário
    app.put('/usuarios/:id', controller.update)

    //Deletar um usuário
    app.delete('/usuarios/:id', controller.delete)

}